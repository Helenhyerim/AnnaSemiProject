package member.controller_DH;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class LeaveAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser == null) {
			// 로그인이 되어있지 않은 상태라면
			String message = "로그인을 먼저 해주세요";
			String loc = request.getContextPath() + "/login/login.an";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			// super.setRedirect(aflse)
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		else {
			// 로그인이 되어진 후 들어온 것이라면
			
			
			super.setRedirect(false);
			super.setViewPage("");
		}
		
		
	}

}
