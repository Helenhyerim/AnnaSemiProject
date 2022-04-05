package member.controller;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class PwdFindAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

      String method = request.getMethod();
      
      if("GET".equalsIgnoreCase(method)) {
         // GET방식으로 먼저 아이디 찾기를 눌러 id찾는 idFind.jsp 로 보내주려고 한 것
         super.setRedirect(false);
         super.setViewPage("/WEB-INF/view/login/pwdFind.jsp");
         
      }
      else {
         // 아이디 찾는 페이지에서 POST 형식으로 받아오게 된다면 
         String name = request.getParameter("name");
         String email = request.getParameter("email");
         String userid = request.getParameter("userid");
         String message = "";
            String loc = "";
            
         InterMemberDAO mdao = new MemberDAO();
         
         Map<String, String> paraMap = new HashMap<>();
         
         paraMap.put("name",name);
         paraMap.put("userid", userid);
         paraMap.put("email", email);
         
         // 회원으로 존재하나 알아보기
         boolean isUserExist = mdao.isUserExist(paraMap);
         boolean sendMailSuccess = false; // 메일이 정상적으로 전송되었는지 유무를 알아오기 위한 용도
         // System.out.println("존재확인용 => " + isUserExist);
         
         if(isUserExist) {
            // 유저가 존재한다면
            Random rnd = new Random();
            
            String certificationCode = "";
            // 인증키는 영문 소문자 대문자 숫자로 10자리로 만들어보겠습니다.
            
            char randSchar = ' ';
            char randBchar = ' ';
            int randnum = 0;
            
            int rand = 0;
            for(int i = 0; i < 10; i++) {
            /*
                   min 부터 max 사이의 값으로 랜덤한 정수를 얻으려면 
                   int rndnum = rnd.nextInt(max - min + 1) + min;
                      영문 소문자 'a' 부터 'z' 까지 랜덤하게 1개를 만든다.     
                */
               
               rand = rnd.nextInt(3);
               
               if(rand == 0) {
                  randBchar = (char)(rnd.nextInt('Z' - 'A' + 1) + 'A');
                  certificationCode += randBchar;
               }
               else if(rand == 1) {
                  randSchar = (char)(rnd.nextInt('z' - 'a' + 1) + 'a');
                  certificationCode += randSchar;
               }
               else {
                  randnum = rnd.nextInt(9 - 0 + 1);
                  certificationCode += randnum;
               }
            }//end of for----------------------------------------------------
            
            
         
            
            // System.out.println("!!!!확인용  "+ certificationCode);
            // !!!!확인용  sppyc4789442
            
            // 랜덤하게 생성한 인증코드(certificationCode)를 비밀번호 찾기를 하고자 하는 사용자의 email로 전송시킨다
            
            GoogleMail mail = new GoogleMail();
            
            try {
               mail.sendmail(email, certificationCode);
               sendMailSuccess = true; // 메일 전송이 성공했음을 기록함.
               
               
               // 세션불러오기
               HttpSession session = request.getSession();
               session.setAttribute("certificationCode", certificationCode);
               // 발급한 인증코드를 세션에 저장시킴.
            
            } catch(Exception e) {
               // 메일 전송이 실패한 경우
               e.printStackTrace();
               sendMailSuccess = false; // 메일 전송이 실패했음을 기록함.
            }
            
               request.setAttribute("isUserExist", isUserExist);
               request.setAttribute("email", email);
               request.setAttribute("userid", userid);
               request.setAttribute("sendMailSuccess", sendMailSuccess);
               request.setAttribute("method", method);
            
               
               super.setRedirect(false);
               super.setViewPage("/WEB-INF/view/login/pwdFind.jsp");
                 

            
         }//end of if(isUserExist) ----------------------------------
         
         else {
            //유저가 존재하지 않는다면
            message = "입력하신 정보로 가입 된 회원은 존재하지 않습니다.";
               loc = "javascript:history.back()";
               
               request.setAttribute("message", message);
               request.setAttribute("loc", loc);
               
               super.setRedirect(false);
               super.setViewPage("/WEB-INF/msg.jsp");
         }
      //////////////////////////////////////////////////////////////////////////////////
         
         
         
      }
      

   }

}