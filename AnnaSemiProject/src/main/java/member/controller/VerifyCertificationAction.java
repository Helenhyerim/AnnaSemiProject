<<<<<<< HEAD
package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class VerifyCertificationAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      String userCertificationCode = request.getParameter("usercertificationCode");
      
      System.out.println(userCertificationCode);
      //사용자가 보낸 인증키
      System.out.println(userCertificationCode);
      
      String userid = request.getParameter("userid");
      System.out.println(userid);
      // 세션불러오기
      HttpSession session = request.getSession();
      
      String certificationCode = (String)session.getAttribute("certificationCode");
      // 발급해준 인증키
      
      String message = "";
      String loc = "";
      
      if(certificationCode.equals(userCertificationCode)) {
         message = "인증성공 되었습니다.";
         loc = request.getContextPath()+"/login/pwdUpdateEnd.an?userid="+userid;
         System.out.println(loc);
      }
      else {
         message = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!";
         loc = request.getContextPath()+"/login/pwdFind.an";
      }
   
      request.setAttribute("message", message);
      request.setAttribute("loc", loc);
      
      // super.setRedirect(false);
      
      super.setViewPage("/WEB-INF/msg.jsp");
      
      
      session.removeAttribute("certificationCode");
      

   }

=======
package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class VerifyCertificationAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      String userCertificationCode = request.getParameter("usercertificationCode");
      
      System.out.println(userCertificationCode);
      //사용자가 보낸 인증키
      System.out.println(userCertificationCode);
      
      String userid = request.getParameter("userid");
      System.out.println(userid);
      // 세션불러오기
      HttpSession session = request.getSession();
      
      String certificationCode = (String)session.getAttribute("certificationCode");
      // 발급해준 인증키
      
      String message = "";
      String loc = "";
      
      if(certificationCode.equals(userCertificationCode)) {
         message = "인증성공 되었습니다.";
         loc = request.getContextPath()+"/login/pwdUpdateEnd.up?userid="+userid;
      }
      else {
         message = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요!!";
         loc = request.getContextPath()+"/login/pwdFind.up";
      }
   
      request.setAttribute("message", message);
      request.setAttribute("loc", loc);
      
      // super.setRedirect(false);
      
      super.setViewPage("/WEB-INF/msg.jsp");
      
      
      session.removeAttribute("certificationCode");
      

   }

>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
}