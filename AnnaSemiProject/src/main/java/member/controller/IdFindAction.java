package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.*;

public class IdFindAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
      String method = request.getMethod();

      if("GET".equalsIgnoreCase(method)) {
         // GET방식으로 먼저 아이디 찾기를 눌러 id찾는 idFind.jsp 로 보내주려고 한 것
         super.setRedirect(false);
         super.setViewPage("/WEB-INF/view/login/idFind.jsp");
         
      }
      else {
         // 아이디 찾는 페이지에서 POST 형식으로 받아오게 된다면 
         String name = request.getParameter("name");
         String email = request.getParameter("email");
         
         InterMemberDAO mdao = new MemberDAO();
         
         Map<String, String> paraMap = new HashMap<>();
         paraMap.put("name", name);
         paraMap.put("email", email);
         
         String userid = mdao.findUserid(paraMap);
         
         String message = "";
            String loc = "";
         
         if(userid != null) {
               
               request.setAttribute("findUserid", userid);
               request.setAttribute("method", method);
               
            super.setRedirect(false);
              super.setViewPage("/WEB-INF/view/login/login.jsp");
             
         }
         else {
            message = "입력하신 정보로 가입 된 회원 아이디는 존재하지 않습니다.";
               loc = "javascript:history.back()";
               
               request.setAttribute("message", message);
               request.setAttribute("loc", loc);
               
               super.setRedirect(false);
               super.setViewPage("/WEB-INF/msg.jsp");
         }
         
         
         
      }// end of else----------------
      
   }

}