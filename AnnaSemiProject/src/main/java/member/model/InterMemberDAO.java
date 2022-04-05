<<<<<<< HEAD
package member.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterMemberDAO {

   
      // ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
      boolean idDuplicateCheck(String userid) throws SQLException;

      // email 중복검사 (tbl_member 테이블에서 email 이 존재하면 true를 리턴해주고, email 이 존재하지 않으면 false를 리턴한다)
      boolean emailDuplicateCheck(String email) throws SQLException;

      // 회원가입을 해주는 메소드 (tbl_member 테이블에 insert)
      int registerMember(MemberVO member) throws SQLException;

      // 입력받은 paraMap 을 가지고 한명의 회원정보를 리턴시켜주는 메소드(로그인 처리)
      MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException;

      // 아이디 찾기 성명, 이메일을 입력받아서 해당 사용자의 아이디를 알려준다)
      String findUserid(Map<String, String> paraMap)throws SQLException;
      
      // 비밀번호를 찾기 위해서 성명, 이메일 유저 아이디를 입력받아서 해당 사용자의 존재여부를 알려준다.
      boolean isUserExist(Map<String, String> paraMap)throws SQLException;      
      
      // 페이징 처리가 되어진 모든 회원 또는 검색한 회원 목록 보여주기 
      List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException;

      // 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총 페이지 알아오기 
      int getTotalPage(Map<String, String> paraMap) throws SQLException;
      
      // userid 정보를 받아와서 회원에 대한 상세정보 알아오기
      MemberVO memberOneDetail(String userid) throws SQLException;
      
=======
package member.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterMemberDAO {

   
      // ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
      boolean idDuplicateCheck(String userid) throws SQLException;

      // email 중복검사 (tbl_member 테이블에서 email 이 존재하면 true를 리턴해주고, email 이 존재하지 않으면 false를 리턴한다)
      boolean emailDuplicateCheck(String email) throws SQLException;

      // 회원가입을 해주는 메소드 (tbl_member 테이블에 insert)
      int registerMember(MemberVO member) throws SQLException;

      // 입력받은 paraMap 을 가지고 한명의 회원정보를 리턴시켜주는 메소드(로그인 처리)
      MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException;

      // 아이디 찾기 성명, 이메일을 입력받아서 해당 사용자의 아이디를 알려준다)
      String findUserid(Map<String, String> paraMap)throws SQLException;
      
      // 비밀번호를 찾기 위해서 성명, 이메일 유저 아이디를 입력받아서 해당 사용자의 존재여부를 알려준다.
      boolean isUserExist(Map<String, String> paraMap)throws SQLException;
      
      
      
      
      
      
      
      
      
      
      
      
      
      // 페이징 처리가 되어진 모든 회원 또는 검색한 회원 목록 보여주기 
      List<MemberVO> selectPagingMember(Map<String, String> paraMap) throws SQLException;

      // 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총 페이지 알아오기 
      int getTotalPage(Map<String, String> paraMap) throws SQLException;
>>>>>>> refs/heads/YuHyeRim
}