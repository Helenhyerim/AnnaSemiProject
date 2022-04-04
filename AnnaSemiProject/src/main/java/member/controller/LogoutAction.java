package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class LogoutAction extends AbstractController {

   @Override
   public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
      // 로그아웃 처리하기
      
      HttpSession session = request.getSession();// 세션불러오기
      
      // 두번째 방법 : WAS 메모리 상에서 세션을 아예 삭제해버리기
      session.invalidate(); // 로그아웃은 이걸 많이 씀
      
      
      super.setRedirect(true);
      super.setViewPage(request.getContextPath() + "/index.an");

   }

}