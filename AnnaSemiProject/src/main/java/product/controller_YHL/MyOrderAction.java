package product.controller_YHL;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;
import product.model_lsh.ProductVO;

public class MyOrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 주문내역에 들어가기 위한 전제 조건은, 먼저 로그인을 해야 하는 것이다.
		if(super.checkLogin(request)) {// true 라면 로그인을 한 경우임
			
			String userid = request.getParameter("userid"); 
			/*
				login.jsp 에서 
				코인구매 금액 선택 팝업창 띄우기
				const url = "<%= request.getContextPath()%>/member/coinPurchaseTypeChoice.up?userid="+userid;
				의 get 방식으로 저장해둔 userid 를 가져온 것임
			*/
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser.getUserid().equals(userid)) {// 세션에 저장된 아이디와, getPara 한 아이디가 같으면
				// 즉 로그인 한 사용자가 자신을 위해 결제하는 경우

				InterProductDAO pdao = new ProductDAO();
				
				String cart_checked = request.getParameter("cart_checked");
			//	System.out.println("~~~ 확인용 cart_checked =>" + cart_checked);
				// 31, 32,,,
				
				List<ProductVO> productList = new ArrayList<ProductVO>();
				
				String[] cartnoList = cart_checked.split(",");
				
				for(String cartno : cartnoList) {
					
					// 장바구니 페이지에서 넘어온 cart_checked(체크된 cartno) 로 주문페이지에 보여줄 아이템 조회해오기
					ProductVO pvoList = new ProductVO();
					pvoList = pdao.getOrderItems(cartno);	
					
					productList.add(pvoList);
				}
				request.setAttribute("productList", productList);
				System.out.println("productList =>" + productList);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/view/product_YHL/order_YHL.jsp");
			}
			else {// 로그인 한 사용자가 다른 사용자을 위해 결제하는 경우
				String message = "다른 사용자의 결제는 불가합니다!";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		else {// 로그인을 안했으면
			String message = "결제를 하기 위해서는 먼저 로그인을 하세요!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
				
	}

}
