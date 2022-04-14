package product.controller_lsh;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model_lsh.InterProductDAO;
import product.model_lsh.OrderVO;
import product.model_lsh.ProductDAO;

public class OrderDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그인 유무 검사하기
		boolean isLogin = super.checkLogin(request);
		
		if(isLogin) {
			
			String method = request.getMethod();
			
		//	if("POST".equalsIgnoreCase(method)) { // POST 방식으로 접근한 경우
				
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
				String userid = loginuser.getUserid();
				String ordernum = request.getParameter("onum");
				
				InterProductDAO pdao = new ProductDAO();

				// 주문 번호로 주문 상세 정보 알아오기
				List<OrderVO> orderList = pdao.selectOrderInfo(ordernum);
				
				request.setAttribute("orderList", orderList);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/product_lsh/orderDetail.jsp");
		//	}
		/*	else { // GET 방식으로 접근한 경우
				String message = "잘못된 접근 경로입니다.";
	            String loc = "javascript:history.back()";
	               
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	              
	        //  super.setRedirect(false);   
	            super.setViewPage("/WEB-INF/msg.jsp");
			}
		*/
		}
		else { // 로그인을 하지 않은 경우
			request.setAttribute("message", "로그인 후 이용할 수 있습니다.");
			request.setAttribute("loc", request.getContextPath() + "/login/login.an");
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
					
			return;
		}
		
	}

}
