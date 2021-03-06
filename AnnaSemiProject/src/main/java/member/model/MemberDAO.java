package member.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
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
            if(rs != null)    {rs.close();     rs = null;}
            if(pstmt != null) {pstmt.close(); pstmt = null;}
            if(conn != null)  {conn.close();  conn = null;}
         } catch(SQLException e) {
            e.printStackTrace();
         }
      }// end of private void close()------------------------------------
         

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

      // 아이디 찾기(성명, 이메일을 입력받아서 해당 사용자의 아이디를 알려준다)
      @Override
      public String findUserid(Map<String, String> paraMap) throws SQLException {
         
         String userid = null;
         
         try {
            conn = ds.getConnection();
            
            String sql = " select userid "
                     + " from tbl_member"
                     + " where register_status = 1 and name = ? and email = ? ";
            
             pstmt = conn.prepareStatement(sql);
             pstmt.setString(1, paraMap.get("name"));
             pstmt.setString(2, aes.encrypt(paraMap.get("email")));
             
             rs = pstmt.executeQuery();
             
             if(rs.next()) {
                userid = rs.getString(1);
             }
            
         } catch(GeneralSecurityException | UnsupportedEncodingException e) { 
             e.printStackTrace();    
         } finally {
            close();
         }
         
         return userid;
      }


      // 비밀번호를 찾기 위해서 성명, 이메일 유저 아이디를 입력받아서 해당 사용자의 존재여부를 알려준다.
      @Override
      public boolean isUserExist(Map<String, String> paraMap) throws SQLException {
         
         boolean isUserExist = false;
         
         
         try {
            conn = ds.getConnection();
            
            String sql = " select userid "
                     + " from tbl_member"
                     + " where register_status = 1 and userid = ? and name = ? and email = ? ";
            
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, paraMap.get("userid"));
            pstmt.setString(2, paraMap.get("name"));
            pstmt.setString(3, aes.encrypt(paraMap.get("email")));
             
            rs = pstmt.executeQuery();
             
            
            isUserExist = rs.next();
             
            
         } catch(GeneralSecurityException | UnsupportedEncodingException e) { 
             e.printStackTrace();    
         } finally {
            close();
         }
         
         return isUserExist;
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
               + "        where userid != 'admin' ";
         
         String colname = paraMap.get("searchType");
         String searchWord = paraMap.get("searchWord");
            
         if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
            sql += " and "+colname+" like '%'|| ? ||'%' ";
         }
         
         sql += "        order by registerday desc "
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
             if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
              
              if("email".equals(colname)) {
                 pstmt.setString(1, aes.encrypt(searchWord));
             }
             else {
                pstmt.setString(1, searchWord);   
             }
              
              pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
             pstmt.setInt(3, (currentShowPageNo * sizePerPage));   
           }
           else {
              pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
             pstmt.setInt(2, (currentShowPageNo * sizePerPage));   
           }
             
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

    // 인증번호를 받아 비밀번호를 변경해주는 메소드  
   @Override
   public int pwdUpdate(Map<String, String> paraMap) throws SQLException {
      int result = 0;
      
      try {
          conn = ds.getConnection();
          
          String sql = " update tbl_member set pwd = ? "
                    + "                     , lastpwdchangedate = sysdate "
                    + " where userid = ? ";
          
          pstmt = conn.prepareStatement(sql);
          
          pstmt.setString(1, Sha256.encrypt(paraMap.get("pwd")) ); // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.
          pstmt.setString(2, paraMap.get("userid") );
          
          result = pstmt.executeUpdate();
          
      } finally {
         close();
      }
      
      return result;
   }
   
   
   // 회원정보를 수정해주는 메소드
   @Override
   public int updateMember(MemberVO member) throws SQLException {
      int result = 0;
      
      try {
         conn = ds.getConnection();
         
         String sql = " update tbl_member set name = ? "
                  + "                     , pwd = ? "
                  + "                     , email = ? "
                  + "                     , mobile = ? "
                  + "                     , postcode = ? "
                  + "                     , address = ? "
                  + "                     , detailaddress = ? "
                  + "                     , lastpwdchangedate = sysdate "
                  + "                  , sms_status = ? "
                  + "                  , email_status = ? "
                  + " where userid = ? ";
         
         pstmt = conn.prepareStatement(sql);
         
         pstmt.setString(1,  member.getName());
         pstmt.setString(2,  Sha256.encrypt(member.getPwd()));  // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.   
         pstmt.setString(3,  aes.encrypt(member.getEmail()));   // 이메일을 AES256 알고리즘으로 양방향 암호화 시킨다. 
         pstmt.setString(4,  aes.encrypt(member.getMobile()));  // 휴대폰번호를 AES256 알고리즘으로 양방향 암호화 시킨다.     
         pstmt.setString(5,  member.getPostcode());  
         pstmt.setString(6,  member.getAddress());
         pstmt.setString(7,  member.getDetailaddress());
         pstmt.setInt(8, member.getSms_status());
         pstmt.setInt(9, member.getEmail_status());
         pstmt.setString(10,  member.getUserid());
         
         result = pstmt.executeUpdate();
         
         System.out.println(result);
      } catch (Exception e) {
         e.printStackTrace();
      } finally {
         close();
      }
      
      return result;
   }

      
   // userid 정보를 받아와서 회원에 대한 상세정보 알아오기
   @Override
   public MemberVO memberOneDetail(String userid) throws SQLException {
      MemberVO mvo = null;
      
      try {
          conn = ds.getConnection();
          
          String sql = " select userid, name, email, mobile, postcode, address, detailaddress "+
                     "     , substr(birthday,1,4) AS birthyyyy, substr(birthday,6,2) AS birthmm, substr(birthday,9) AS birthdd "+
                     "     , point, to_char(registerday, 'yyyy-mm-dd') AS registerday, Sms_status, Email_status "+
                     " from tbl_member "+
                     " where userid = ? ";
          
          pstmt = conn.prepareStatement(sql);
          pstmt.setString(1, userid);
                    
          rs = pstmt.executeQuery();
          
          if(rs.next()) {
             mvo = new MemberVO();
             
             mvo.setUserid(rs.getString(1));
             mvo.setName(rs.getString(2));
             mvo.setEmail( aes.decrypt(rs.getString(3)) );  // 복호화 
             mvo.setMobile( aes.decrypt(rs.getString(4)) ); // 복호화 
             mvo.setPostcode(rs.getString(5));
             mvo.setAddress(rs.getString(6));
             mvo.setDetailaddress(rs.getString(7));
             mvo.setBirthday(rs.getString(8) + rs.getString(9) + rs.getString(10));
             mvo.setPoint(rs.getInt(11));
             mvo.setRegisterday(rs.getString(12));
             mvo.setSms_status(rs.getInt(13));
             mvo.setEmail_status(rs.getInt(14));
          }
      
      } catch(GeneralSecurityException | UnsupportedEncodingException e) { 
          e.printStackTrace();    
      } finally {
         close();
      }
      
      return mvo;

   }
   
	   
	// 회원탈퇴 메소드 생성 
	@Override
	public int leaveMember(Map<String, String> paraMap) throws SQLException {
		
		int result = 0;
	      
	      try {
	         conn = ds.getConnection();
	         
	         String sql = " update tbl_member set register_status = 0 "
	                  + " where userid = ? and pwd = ?";
	         
	         pstmt = conn.prepareStatement(sql);
	         
	         pstmt.setString(1,  paraMap.get("userid"));
	         pstmt.setString(2,  Sha256.encrypt(paraMap.get("pwd")));  // 암호를 SHA256 알고리즘으로 단방향 암호화 시킨다.   
	        

	         result = pstmt.executeUpdate();
	         
	         System.out.println(result);
	      } catch (Exception e) {
	         e.printStackTrace();
	      } finally {
	         close();
	      }
	      
	      return result;
	
	}
	      
	      


	// 주문내역 페이징 처리를 위해 자신이 주문한 갯수 알아오기
	@Override
	public int getTotalCountOrder(String userid) throws SQLException {
		int totalCountOrder = 0;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = "select count(*) "+
					 "from tbl_order A join tbl_orderdetail B "+
					 "on A.ordernum = B.ordernum ";
			 
			 if("admin".equalsIgnoreCase(userid)) {
				 pstmt = conn.prepareStatement(sql);
			 }
			 else {
				 // 관리자가 아닌 일반사용자로 로그인한 경우
				 sql += " where A.fk_userid = ? " ;
				 
				 pstmt = conn.prepareStatement(sql);
				 pstmt.setString(1, userid);
			 }

			 rs = pstmt.executeQuery();
			 
			 rs.next();
				
			 totalCountOrder = rs.getInt(1);
		} finally {
			close();
		}
		
		return totalCountOrder;
	}

	
	 // 주문내역 페이징 처리하여 조회 해오기
	//  **관리자가 아닌 일반사용자로 로그인 했을 경우에는 자신이 주문한 내역만 페이징 처리하여 조회를 해오고,
    //     관리자로 로그인을 했을 경우에는 모든 사용자들의 주문내역을 페이징 처리하여 조회해온다.	
	@Override
	   public List<Map<String, String>> getOrderList(String userid, int currentShowPageNo, int sizePerPage)
	         throws SQLException {
	      
	      List<Map<String, String>> orderList = new ArrayList<>();
	      
	      try {
	          conn = ds.getConnection();
	          
	          String sql = " select ordernum, fk_userid, orderdate, orderseqnum, fk_productnum, orderqty, orderprice, orderstatus, deliverstatus "  
	                   + "      , productname, productimage1, productprice, saleprice, point, ordertotalprice, ordertotalpoint "
	                   + " from "
	                   + " ( "
	                   + " select row_number() over (order by B.ordernum desc, B.orderseqnum desc) AS RNO "
	                   + "       , A.ordernum, A.fk_userid, A.ordertotalprice, A.ordertotalpoint "
	                   + "       , to_char(A.orderdate, 'yyyy-mm-dd') AS orderdate "
	                   + "       , A.orderstatus "
	                   + "       , B.orderseqnum, B.fk_productnum, B.orderqty, B.orderprice "
	                   + "       , case B.deliverstatus "
	                   + "         when 1 then '주문완료' "
	                   + "         when 2 then '배송중' "
	                   + "         when 3 then '배송완료' "
	                   + "         end AS deliverstatus "
	                   + "     , C.productname, C.productimage1, C.productprice, C.saleprice, C.point "
	                   + " from tbl_order A join tbl_orderdetail B "
	                   + " on A.ordernum = B.ordernum "
	                   + " join tbl_product C "
	                   + " on B.fk_productnum = C.productnum ";
	          
	          if(!"admin".equals(userid)) { 
	             // 관리자가 아닌 일반사용자로 로그인 한 경우 
	             sql += " where A.fk_userid = ? ";
	          }
	          
	          sql += " ) V "
	               + " where RNO between ? and ? "; 
	          
	          pstmt = conn.prepareStatement(sql);
	          
	          if(!"admin".equals(userid)) { 
	             // 관리자가 아닌 일반사용자로 로그인 한 경우 
	             pstmt.setString(1, userid);
	             pstmt.setInt(2, (currentShowPageNo*sizePerPage)-(sizePerPage-1) ); // 공식
	              pstmt.setInt(3, currentShowPageNo*sizePerPage ); // 공식
	          }
	          else {
	             // 관리자로 로그인 한 경우
	             pstmt.setInt(1, (currentShowPageNo*sizePerPage)-(sizePerPage-1) ); // 공식
	              pstmt.setInt(2, currentShowPageNo*sizePerPage ); // 공식
	          }
	          
	          rs = pstmt.executeQuery();
	          
	          while(rs.next()) {
	             String ordernum = rs.getString("ordernum");
	             String fk_userid = rs.getString("fk_userid");
	             String orderdate = rs.getString("orderdate");
	             String orderseqnum = rs.getString("orderseqnum");
	             String fk_productnum = rs.getString("fk_productnum");
	             String orderqty = rs.getString("orderqty");
	             String orderprice = rs.getString("orderprice");
	             String orderstatus = rs.getString("orderstatus");
	             String deliverstatus = rs.getString("deliverstatus");
	             String productname = rs.getString("productname");
	             String productimage1 = rs.getString("productimage1");
	             String productprice = rs.getString("productprice");
	             String saleprice = rs.getString("saleprice");
	             String point = rs.getString("point");
	             String ordertotalprice = rs.getString("ordertotalprice");
	             String ordertotalpoint = rs.getString("ordertotalpoint");
	             
	             Map<String, String> ordermap = new HashMap<>();
	             ordermap.put("ORDERNUM", ordernum);
	             ordermap.put("FK_USERID", fk_userid);
	             ordermap.put("ORDERDATE", orderdate);
	             ordermap.put("ORDERSEQNUM", orderseqnum);
	             ordermap.put("FK_PRODUCTNUM", fk_productnum);
	             ordermap.put("ORDERQTY", orderqty);
	             ordermap.put("ORDERPRICE", orderprice);
	             ordermap.put("ORDERSTATUS", orderstatus);
	             ordermap.put("DELIVERSTATUS", deliverstatus);
	             ordermap.put("PRODUCTNAME", productname);
	             ordermap.put("PRODUCTIMAGE1", productimage1);
	             ordermap.put("PRODUCTPRICE", productprice);
	             ordermap.put("SALEPRICE", saleprice);
	             ordermap.put("POINT", point);
	             ordermap.put("ORDERTOTALPRICE", ordertotalprice);
	             ordermap.put("ORDERTOTALPOINT", ordertotalpoint);
	             
	             orderList.add(ordermap);
	             
	          }// end of while(rs.next())-----------------------------------
	          
	      } finally {
	         close();
	      }
	      
	      return orderList;
	   }

	
	
}    

