package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class MyAdminAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub

		// 마이어드민이 보이기 위한 전제조건은 관리자로 로그인을 해야 하는 것이다. 
				HttpSession session = request.getSession();
				
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				if( loginuser == null || !"admin".equals(loginuser.getUserid()) ) {
					// 로그인을 안하고 접근하려는 경우 로그인 페이지로 이동
					String message = "관리자로 로그인을 해야 들어올 수 있습니다.";
					String loc = "javascript:history.back()";
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				
				else { 
					//로그인 한 경우 
					
					// orderhistory, cshistory 관련 정보 가져오기를 해야 하는데 그건 합칠 때 할 예정.	
					
					
					super.setRedirect(false);
			        super.setViewPage("/WEB-INF/view/member/myAdmin.jsp");
			        
		        
				}
		
		
	}

}
