package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.security.AES256;
import util.security.SecretMyKey;
import util.security.Sha256;

public class MemberDAO implements InterMemberDAO {


	private DataSource ds;    // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private AES256 aes;
	
	// 기본생성자
		public MemberDAO() {
			try {
				Context initContext = new InitialContext();
			    Context envContext  = (Context)initContext.lookup("java:/comp/env");
			    ds = (DataSource)envContext.lookup("jdbc/anna_oracle");
			    
			    aes = new AES256(SecretMyKey.KEY);
			    
			    
			} catch(NamingException e) {
				e.printStackTrace();
			} catch(UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
	
		// 자원반납 해주는 메소드
		private void close() {
			
			try {
				if(rs != null)    {rs.close();	  rs = null;}
				if(pstmt != null) {pstmt.close(); pstmt = null;}
				if(conn != null)  {conn.close();  conn = null;}
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}// end of private void close()------------------------------------
			
	
	
	// 회원가입을 해주는 메소드 (tbl_member 테이블에 insert)
	@Override
	public int registerMember(MemberVO member) throws SQLException {
		// TODO Auto-generated method stub
		int result = 0;
		
		try {
			conn = ds.getConnection();

            String sql = " insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, birthday, sms_status, email_status) "
                       + " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";

            pstmt = conn.prepareStatement(sql);

            pstmt.setString(1, member.getUserid());
            pstmt.setString(2, Sha256.encrypt(member.getPwd())); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
            pstmt.setString(3, member.getName());
            pstmt.setString(4, aes.encrypt(member.getEmail()));    // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.
            pstmt.setString(5, aes.encrypt(member.getMobile()));  // 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.
            pstmt.setString(6, member.getPostcode());
            pstmt.setString(7, member.getAddress());
            pstmt.setString(8, member.getDetailaddress());
            pstmt.setString(9, member.getBirthday());
            pstmt.setInt(10, member.getSms_status());
            pstmt.setInt(11, member.getEmail_status());

            result = pstmt.executeUpdate();
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return result;
	}

	
	// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
	@Override
	public boolean idDuplicateCheck(String userid) throws SQLException {
		boolean isExist = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select * "
					 		+ " from tbl_member "
							+ " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs= pstmt.executeQuery();
			
			isExist = rs.next(); // 행이 있으면(중복된 userid) true, 
						           // 행이 없으면(사용가능한 userid) false
		} finally {
			close();
		}
		
		return isExist;
	}

	
	// 이메일 중복검사 (tbl_member 테이블에서 email 가 존재하면 true를 리턴해주고, email 가 존재하지 않으면 false를 리턴한다)
	@Override
	public boolean emailDuplicateCheck(String email) throws SQLException {
		boolean isExist = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select * "
					 		+ " from tbl_member "
							+ " where email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aes.encrypt(email));
			
			rs= pstmt.executeQuery();
			
			isExist = rs.next(); // 행이 있으면(중복된 userid) true, 
						           // 행이 없으면(사용가능한 userid) false
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return isExist;
	}


	// 입력 받은 paraMap으로 한명의 회원정보를 리턴시켜주는 메소드 (로그인 처리) 
	@Override
	public MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException {
		// TODO Auto-generated method stub
		
		MemberVO member = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " SELECT userid, name, email, mobile, postcode, address, detailaddress "+
					"        , birthyyyy, birthmm, birthdd, point, registerday, pwdchangegap, "+
					"        nvl(lastlogingap, trunc(months_between(sysdate,registerday) ) ) "+
					" FROM  "+
					" ( "+
					" select userid, name, email, mobile, postcode, address, detailaddress,"+
					"        , substr(birthday, 1, 4) AS birthyyyy, substr(birthday, 6, 2) AS birthmm, substr(birthday, 9) AS birthdd "+
					"        , point, to_char(registerday, 'yyyy-mm-dd') AS registerday "+
					"        , trunc(months_between(sysdate, lastpwdchangedate)) AS pwdchangegap "+	
					"from tbl_member "+
					"where register_status = 1 and userid = ? and pwd= ? "+
					") M "+
					"CROSS JOIN "+
					"( "+
					"select trunc(months_between(sysdate, max(logindate))) AS lastlogingap "+
					"from tbl_loginhistory "+
					"where fk_userid = ? "+
					") H ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd"))); // pwd는 qwer1234$ 이므로 암호화해서 넣어야 함..
			pstmt.setString(3, paraMap.get("userid"));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) { // select되어진 게 있느냐, 있다면, 
				member = new MemberVO();
				
				member.setUserid(rs.getString(1));
				member.setName(rs.getString(2));
				member.setEmail( aes.decrypt(rs.getString(3)) ); // 복호화함.
				member.setMobile(rs.getString(4));
				member.setPostcode(rs.getString(5));
	            member.setAddress(rs.getString(6));
	            member.setDetailaddress(rs.getString(7));
	            member.setGender(rs.getString(8));
	            member.setBirthday(rs.getString(9) + rs.getString(10) + rs.getString(11));
	            member.setPoint(rs.getInt(12));
	            member.setRegisterday(rs.getString(13));
	            
	            if ( rs.getInt(14) >= 3) {
	            	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
		            // 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false
	            	member.setRequirePwdChange(true); // 로그인시 암호를 변경하라는 alert 띄울 것.
	            }
	            
	            if ( rs.getInt(15) >= 12 ) {
	            	// 마지막으로 로그인한 날짜 시간이 현재시각으로부터 1년이 지났으면 휴면 처리
	            	member.setRegister_status(1);
	            	
	            	// === tbl_member 테이블의 idle 컬럼의 값을 1로 변경하기
	            	sql = " update tbl_member set register_status = 1 "
	            			+ " where userid = ? " ;
	            	
	            	pstmt = conn.prepareStatement(sql);
	    			
	    			pstmt.setString(1, paraMap.get("userid"));
	    			
	    			pstmt.executeUpdate();
	            	
	            }
	            
	            // == tbl_loginhistory(로그인기록) 테이블에 insert 하기 == //
	            if(member.getRegister_status() != 1) {
	            	sql = " insert into tbl_loginhistory(fk_userid, clientip) "
	            			+ " values(?, ?) ";
	            	
	            	pstmt = conn.prepareStatement(sql);
	    			
	            	pstmt.setString(1, paraMap.get("userid"));
	            	pstmt.setString(2, paraMap.get("clientip"));
	    			
	            	pstmt.executeUpdate();
	            	
	            }
	            	
			}
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) {
				e.printStackTrace();
		} finally {
			close();
		}
		
		return member;
	}
		
	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	// 페이징 처리가 되어진 모든 회원 또는 검색한 회원 목록 보여주기
		@Override
		public List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException {
			
			List<MemberVO> memberList = new ArrayList<>();
			
			try {
				conn = ds.getConnection();
				
				String sql = " select userid, name, email, mobile "
						+ " from "
						+ " ( "
						+ "    select rownum AS rno, userid, name, email, mobile "
						+ "    from "
						+ "    ( "
						+ "        select userid, name, email, mobile "
						+ "        from tbl_member "
						+ "        where userid != 'admin' "
						+ "        order by registerday desc "
						+ "    ) V "
						+ " ) T "
						+ " where rno between ? and ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			 	int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
				/*
			 	 >>> where rno between A and B 
		             A 와 B 를 구하는 공식 <<< 
		      
			         currentShowPageNo 은 보고자 하는 페이지 번호이다. 즉, 1페이지, 2페이지, 3페이지... 를 말한다.
			         sizePerPage 는 한페이지당 보여줄 행의 개수를 말한다. 즉, 3개, 5개, 10개를 보여줄때의 개수를 말한다.
			      
			         A 는 (currentShowPageNo * sizePerPage) - (sizePerPage - 1) 이다. 
			         B 는 (currentShowPageNo * sizePerPage) 이다.
			    */	
				pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));
				
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					
					MemberVO mvo = new MemberVO();
					mvo.setUserid(rs.getString(1));
					mvo.setName(rs.getString(2));
					mvo.setEmail(aes.decrypt(rs.getString(3))); // 복호화 
					mvo.setMobile(aes.decrypt(rs.getString(4))); // 복호화
					
					memberList.add(mvo);
				}// end of while--------------------------------
			
			} catch(GeneralSecurityException | UnsupportedEncodingException e) { 
			    e.printStackTrace();	
			} finally {
				close();
			}
			
			return memberList;
		}


		// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총 페이지 알아오기 
		@Override
		public int getTotalPage(Map<String, String> paraMap) throws SQLException {
			
			int totalPage = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select ceil(count(*)/?) "
							+ " from tbl_member "
							+ " where userid != 'admin' ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, paraMap.get("sizePerPage"));
				
				rs = pstmt.executeQuery();
				
				rs.next();
				
				totalPage = rs.getInt(1);
				
			} finally {
				close();
			}
			
			return totalPage;
		}
		
		
}
