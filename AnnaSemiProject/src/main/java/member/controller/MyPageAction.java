<<<<<<< HEAD
package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class MyPageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 마이페이지가 보이기 위한 전제조건은 먼저 로그인을 해야 하는 것이다. 
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser == null ) {
			// 로그인을 안하고 접근하려는 경우 로그인 페이지로 이동
			String message = "로그인을 해야 들어올 수 있습니다.";
			String loc = request.getContextPath()+"/login/login.an";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else { 
			//로그인 한 경우 
			
			// orderhistory, cshistory 관련 정보 가져오기를 해야 하는데 그건 합칠 때 할 예정.	
			
			
			super.setRedirect(false);
	        super.setViewPage("/WEB-INF/view/member/myPage.jsp");
	        
        
		}

	}
}
=======
package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class MyPageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 일단 파일 보여주고..
		super.setRedirect(false);
        super.setViewPage("/WEB-INF/view/member/myPage.jsp");
        
        // get으로 왔는데 아이디가 다르면 안된다고 말하기..
        
        // post로 와야 함. 

	}

}
>>>>>>> refs/heads/YuHyeRim
