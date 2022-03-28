package member.controller.DH;

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
			super.setViewPage("/WEB-INF/view/member/memberRegister.jsp");
		}
		else {
			// 가입하기 버튼을 클릭했을 경우
			
			String name = request.getParameter("name");
		    String userid = request.getParameter("userid");
		    String pwd = request.getParameter("pwd");
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
		    
		    int sms_status = 0;
		    if(request.getParameter("smsAgree") != null) {
		    	sms_status = 1;
		    }
		    int email_status = 0;
		    if(request.getParameter("emailAgree") != null) {
		    	email_status = 1;
		    }
		    
		    
		    String mobile = hp1 + hp2 + hp3;
		    String birthday = birthyyyy +"-"+ birthmm +"-"+ birthdd;
		    
		    
		    
		 
		    
		    
		    MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailaddress, birthday, sms_status, email_status);
		    
		    
		    
		    
		    String message = "";
		    String loc = "";
		   
		    try {
			    InterMemberDAO mdao = new MemberDAO();
			    int n = mdao.registerMember(member);
			   
			    if(n==1) {
				    message = "회원가입 성공";
				    loc = request.getContextPath()+"/index.up"; // 시작페이지로 이동한다.
				    //    /MyMVC/index.up
			    }
			   
		    } catch(SQLException e) {
	 	 	    message = "SQL구문 에러발생";
			    loc = "javascript:history.back()"; // 자바스크립트를 이용한 이전페이지로 이동한다.
			    e.printStackTrace();
		    }
		   
		    request.setAttribute("message", message);
		    request.setAttribute("loc", loc);
		   
		    // super.setRedirect(false);
		    super.setViewPage("/WEB-INF/msg.jsp");
		 }

	}
}
