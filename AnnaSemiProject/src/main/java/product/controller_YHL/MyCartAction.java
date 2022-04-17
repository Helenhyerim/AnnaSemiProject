package product.controller_YHL;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;
import product.model_lsh.ProductVO;

public class MyCartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		// 내 장바구니를 보기 위한 전제조건은 먼저 로그인을 해야하는 것이다
		if(super.checkLogin(request)) {// 로그인을 한 경우
			
			String userid = request.getParameter("userid");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");

			if(loginuser.getUserid().equals(userid)) {// 로그인 한 사용자가 자신의 장바구니에 접근할 때
				InterProductDAO pdao = new ProductDAO();
				
				// userid 를 받아서 장바구니에 있는 상품 보여주기
				List<ProductVO> productList = pdao.getCartItemsByUserid(userid);
				
				// TBL_PRODUCT_OPTION 에서 옵션명 select 해오기
				// String optionname = pdao.get
				// request.setAttribute("optionname", optionname);
				
				
				request.setAttribute("userid", userid);
				request.setAttribute("productList", productList);
				
				//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/view/product_YHL/cart_YHL.jsp");

			}
			else {// 로그인 한 사용자가 다른 사람의 장바구니에 접근할 때
				String message = "다른 사용자의 장바구니는 볼 수 없습니다!";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
	
		}
		
		else {// 로그인을 안한 경우
			String message = "장바구니를 보기 위해서는 먼저 로그인을 하세요!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}

}
