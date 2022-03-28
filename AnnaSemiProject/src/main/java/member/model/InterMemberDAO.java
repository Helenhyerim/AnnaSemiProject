package member.model;

import java.sql.SQLException;
import java.util.Map;

public interface InterMemberDAO {

		// 회원가입을 해주는 메소드 (tbl_member 테이블에 insert)
		int registerMember(MemberVO member) throws SQLException;

		// ID 중복검사 (tbl_member 테이블에서 userid 가 존재하면 true를 리턴해주고, userid 가 존재하지 않으면 false를 리턴한다)
		boolean idDuplicateCheck(String userid) throws SQLException;

		// 이메일 중복검사 (tbl_member 테이블에서 email 가 존재하면 true를 리턴해주고, email 가 존재하지 않으면 false를 리턴한다)
		boolean emailDuplicateCheck(String email) throws SQLException;

		// 입력 받은 paraMap으로 한명의 회원정보를 리턴시켜주는 메소드 (로그인 처리) 
		MemberVO selectOneMember(Map<String, String> paraMap) throws SQLException;
}
