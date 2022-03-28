package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
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
		    // SecretMyKey.KEY 은 우리가 만든 비밀키이다.
		    
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
		
	}// end of private void close()-------------------------------------
	
	
	// ID를 중복검사 해주는 메소드입니다. 
	@Override
	public boolean idDuplicateCheck(String userid) throws SQLException {
		
		boolean isExist = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select * "
					   + " from tbl_member"
					   + " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			isExist = rs.next();  // 행이 있으면(중복된 userid)     true,
			                      // 행이 없으면(사용가능한 userid)  false
			
		} finally {
			close();
		}
		
		return isExist;
	}
	// email을 중복검사 해주는 메소드입니다.
	@Override
	public boolean emailDuplicateCheck(String email) throws SQLException {
		
		boolean isExist = false;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select * "
					   + " from tbl_member"
					   + " where email = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, aes.encrypt(email));
			
			rs = pstmt.executeQuery();
			
			isExist = rs.next();  // 행이 있으면(중복된 userid)     true,
			                      // 행이 없으면(사용가능한 userid)  false
			
		} catch(GeneralSecurityException | UnsupportedEncodingException e) { 
			e.printStackTrace();
		} finally {
			close();
		}
		
		return isExist;
	}
	// 회원가입을 시켜주는 메소드 입니다.
	@Override
	public int registerMember(MemberVO member) throws SQLException {
int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_member(userid, pwd, name, email, mobile, postcode, address, detailaddress, birthday, sms_status, email_status) "  
					   + " values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";  
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, member.getUserid());
			pstmt.setString(2, Sha256.encrypt(member.getPwd()));  // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.   
			pstmt.setString(3, member.getName());
			pstmt.setString(4, aes.encrypt(member.getEmail()));   // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다.   
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
	
	
	// 로그인된 회원의 정보를 뽑아오는 메소드 입니다.
	@Override
	public MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException {
		
		MemberVO member = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "SELECT userid, name, email, mobile, postcode, address, detailaddress \n"+
					"     , birthyyyy, birthmm, birthdd, point, registerday, sms_status, email_status, pwdchangegap \n"+
					"     , nvl(lastlogingap, trunc(months_between(sysdate,registerday) ) ) AS lastlogingap\n"+
					"FROM       \n"+
					"(      \n"+
					"select userid, name, email, mobile, postcode, address, detailaddress\n"+
					"     , substr(birthday,1,4) AS birthyyyy, substr(birthday,6,2) AS birthmm, substr(birthday,9) AS birthdd\n"+
					"     , point, to_char(registerday, 'yyyy-mm-dd') AS registerday,  trunc( months_between(sysdate, lastpwdchangedate) ) AS pwdchangegap\n"+
					"     , sms_status, email_status\n"+
					"from tbl_member\n"+
					"where register_status = 1 and userid = ? and pwd = ?\n"+
					")M\n"+
					"CROSS JOIN\n"+
					"(\n"+
					"select trunc( months_between(sysdate, max(logindate)) ) AS lastlogingap \n"+
					"from tbl_loginhistory \n"+
					"where fk_userid = ?\n"+
					")H";
			
			
			
			 pstmt = conn.prepareStatement(sql);
			 
			 pstmt.setString(1, paraMap.get("userid"));
			 pstmt.setString(2, Sha256.encrypt(paraMap.get("pwd")) ); 
			 pstmt.setString(3, paraMap.get("userid"));
			 
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				 member = new MemberVO();
				 
				 member.setUserid(rs.getString(1));
				 member.setName(rs.getString(2));
				 member.setEmail(aes.decrypt(rs.getString(3))); // 이메일 복호화 해줌
				 member.setMobile(aes.decrypt(rs.getString(4)));// 휴대전화 복호화 해줌
				 member.setPostcode(rs.getString(5));
				 member.setAddress(rs.getString(6));
				 member.setDetailaddress(rs.getString(7));
				 
				 member.setBirthday(rs.getString(8) + rs.getString(9) + rs.getString(10));
				 member.setPoint(rs.getInt(11));
				 member.setRegisterday(rs.getString(12));
				 member.setSms_status(rs.getInt(13));
				 member.setEmail_status(rs.getInt(14));
				 
				 if(rs.getInt(15) >= 6) {
					 // 암호변경 6개월 이 지나면 true 아니면 false
					 
					 member.setRequirePwdChange(true);
				 }
				 if(rs.getInt(16) >= 12) {
					 member.setInactive_status(1);
					 
					// === tbl_member 테이블의 inactive_status 컬럼의 값을 1로 변경하기 === //
					 sql = " update tbl_member set inactive_status = 1 "
					 	 + " where userid = ? ";
					 
					 pstmt = conn.prepareStatement(sql);
					 pstmt.setString(1, paraMap.get("userid")); 
					 
					 pstmt.executeUpdate();
					 
					
				 }
				 // === tbl_loginhistory(로그인기록) 테이블에 insert 하기 === //
				 if(member.getInactive_status() != 1) {
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

}
