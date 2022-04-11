package member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class LoginAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      
       String method = request.getMethod();   
         
         if("GET".equalsIgnoreCase(method)) {
            super.setRedirect(false); // logoutAction 에서 true를 사용했기 때문에 다시 false로 바꿔줌 
                                  // 안바꿔주니 한번 로그아웃 하면 404 에러가 뜸
            
            super.setViewPage("/WEB-INF/view/login/login.jsp");
         }
         else {
            String userid = request.getParameter("userid");
            String pwd = request.getParameter("pwd");
            
            // ===> 클라이언트의 IP 주소를 알아오는 것 <=== //
            String clientip = request.getRemoteAddr();
            
            
            Map<String, String> paraMap = new HashMap<>();
            paraMap.put("userid", userid);
            paraMap.put("pwd", pwd);
            paraMap.put("clientip", clientip);
            
            InterMemberDAO mdao = new MemberDAO();
            
            MemberVO loginuser = mdao.selectOneMember(paraMap);
            
            if(loginuser != null) {
               
               if(loginuser.getInactive_status() == 1){
                  
                  String message = "로그인을 한지 1년이 지나 휴면상태로 전환되었습니다.";
                  String loc = request.getContextPath()+"/index.an";
                  // 원래는 위와같이 index.up이 아니라 휴면인 계정을 풀어주는 페이지로 잡아주어야 한다.
                  
                  request.setAttribute("message", message);
                  request.setAttribute("loc", loc);
                  
                  super.setRedirect(false);
                  super.setViewPage("/WEB-INF/msg.jsp");
                  
                  return; // execute()메소드 종료
               }
         
               HttpSession session = request.getSession();
               // 메모리에 생성되어져 있는 session 을 불러오는 것이다.
               
               session.setAttribute("loginuser", loginuser);
               // sessino(세션)에 로그인 되어진 사용자 정보인 loginuser을 키이름을 "loginuser" 으로 저장시켜 두는 것이다.
               
               if(loginuser.isRequirePwdChange() == true) {
                  
                  String message = "비밀번호를 변경한지 3개월이 지났습니다. 비밀번호를 변경하세요!!";
                  String loc = request.getContextPath()+"/index.an";
                  // 원래는 위와같이 index.up이 아니라. 암호변경해주는 페이지로 가야함
                  
                  request.setAttribute("message", message);
                  request.setAttribute("loc", loc);
                  
                  super.setRedirect(false);
                  super.setViewPage("/WEB-INF/msg.jsp");
                  
               }
               
               else {
                  // 비밀번호를 변경한지 3개월 이내인 경우
               
                  // 페이지를 이동을 시킨다
                  super.setRedirect(true);
                  
                  // 로그인을 하면 시작페이지(index.up)로 가는 것이 아니라 로그인을 시도하려고 머물렀던 그 페이지로 가기 위한 것이다.
                  
                  
                  super.setViewPage(request.getContextPath()+"/index.an");
                  
               }
               
               
            }
            else {
               String message = "로그인 실패";
               String loc = "javascript:history.back()";
               
               request.setAttribute("message", message);
               request.setAttribute("loc", loc);
               
               super.setRedirect(false);
               super.setViewPage("/WEB-INF/msg.jsp");
            }
         }
         
   
   }

}