package member.controller;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;


public class MemberRegisterAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
    
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			// super.setRedirect(false);	
			super.setViewPage("/WEB-INF/view/member/memberRegister.jsp");
		}
		else {
			// 가입하기 버튼을 클릭했을 경우 
			
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3 = request.getParameter("hp3");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailaddress = request.getParameter("detailAddress");
			String birthyyyy = request.getParameter("birthyyyy");
			String birthmm = request.getParameter("birthmm");
			String birthdd = request.getParameter("birthdd");
			String mobile = hp1 + hp2 + hp3;
			String birthday = birthyyyy+ "-" + birthmm + "-" + birthdd;
			
			int sms_status = 0;
	          if(request.getParameter("sms_status") != null) {
	             sms_status = 1;
	          }
	        int email_status = 0;
	          if(request.getParameter("email_status") != null) {
	        	  email_status = 1;
	          }
			
		//	System.out.println(">>>확인용 sms_status =>"+sms_status);
		//	System.out.println(">>>확인용 email_status =>"+email_status);
			
			MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailaddress, birthday, sms_status, email_status );    
			
			//회원가입이 성공하면 자동으로 로그인하기. // 
			   try {
				   InterMemberDAO mdao = new MemberDAO();
				   int n = mdao.registerMember(member);
				   
				   if(n==1) {
					   request.setAttribute("userid", userid);
					   request.setAttribute("pwd", pwd);
					   
					// super.setRedirect(false);
					   super.setViewPage("/WEB-INF/view/login/registerAfterAutoLogin.jsp");
				   }
			} catch(SQLException e) {
				e.printStackTrace();
				
				String message = "SQL 구문 에러가 발생하였습니다.";
				String loc = "javascript:history.back()";
			
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/view/common/msg.jsp");
		}
		

	}

}
}