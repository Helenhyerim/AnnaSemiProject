package memberYJ.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import myshop.model.InterProductDAO;
import myshop.model.ProductDAO;

public class MemberPointAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 포인트 정보(회원정보)를 열람하기 위한 조건은 로그인 여부임.
		// == 로그인 유무 검사하기 == // 
		boolean isLogin = super.checkLogin(request);
		
		if( !isLogin ) {
			// 로그인을 안 했으면 
			String message = "포인트 정보 열람을 위해서는 먼저 로그인을 하세요!!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		 // super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		else {
			// 로그인했으면 
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {
			//post 방식이면
				String userid = request.getParameter("userid");
				
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
				
				super.setRedirect(false);
		        super.setViewPage("/WEB-INF/view/member/memberPoint.jsp");
				
			}
			else {
				// get 방식이면
 				 String message = "비정상적인 경로로 들어왔습니다";
	             String loc = "javascript:history.back()";
	               
	             request.setAttribute("message", message);
	             request.setAttribute("loc", loc);
	              
	        //  super.setRedirect(false);   
	             super.setViewPage("/WEB-INF/msg.jsp");
			}
		}		
	}

}
