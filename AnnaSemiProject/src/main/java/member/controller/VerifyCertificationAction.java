package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class VerifyCertificationAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	   String method = request.getMethod();
	   HttpSession session = request.getSession();
	   String message = "";
	   String loc = "";
	   if("GET".equalsIgnoreCase(method)){
		   message = "잘못된경로입니다.";
	       loc = request.getContextPath()+"/index.an";
	   }
	   else {
	      String userCertificationCode = request.getParameter("usercertificationCode");
	      
	      String userid = request.getParameter("userid");
	      System.out.println(userid);
	      // 세션불러오기
	      
	      
	      String certificationCode = (String)session.getAttribute("certificationCode");
	      // 발급해준 인증키
	      
	      
	      
	      if(certificationCode.equals(userCertificationCode)) {
	         message = "인증성공 되었습니다.";
	         // super.setRedirect(false);
	         loc = request.getContextPath()+"/login/pwdUpdateEnd.an?userid="+userid;
	      }
	      else {
	         message = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!";
	         loc = request.getContextPath()+"/login/pwdFind.an";
	      }
	   

	   }
	      request.setAttribute("message", message);
	      request.setAttribute("loc", loc);
	      
	      // super.setRedirect(false);
	      
	      super.setViewPage("/WEB-INF/msg.jsp");
	      
	      
	      session.removeAttribute("certificationCode");
   }

}