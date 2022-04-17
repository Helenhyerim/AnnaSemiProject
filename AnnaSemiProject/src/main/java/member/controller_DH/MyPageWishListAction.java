package member.controller_DH;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model_lsh.*;

public class MyPageWishListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		HttpSession session = request.getSession();
		
		// 세션에 저장되어있던 loginuser을 가져와서 loginuser를 만들어줌
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if(loginuser != null) {
			// 만약 login이 되어있어서 세션에 데이터가 남아있을 경우 loginuser의 아이디를 가져옴
			String userid = loginuser.getUserid();
			
			InterProductDAO pdao = new ProductDAO();
			
			
			// userid 를 받아서 WishList의 count(*)을 반환해주는 메소드를 생성할 것이다.
			int totalWishListCount = pdao.totalWishListCount(userid);
			request.setAttribute("totalWishListCount", totalWishListCount);
			
			request.setAttribute("userid", userid);
			// System.out.println(userid);
			
			super.setViewPage("/WEB-INF/view/member/myPageWishList.jsp");
		}
		else {
			// login이 되어있지않아 session영역에 저장되어있는 MemberVO가 없다면
			
			String message = "로그인을 해주세요";
			String loc = request.getContextPath()+"/login/login.an";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		
		
		
		
		
	}

}
