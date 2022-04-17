package product.controller_lsh;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model_lsh.InterProductDAO;
import product.model_lsh.OrderVO;
import product.model_lsh.ProductDAO;

public class OrderSuccessAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그인 유무 검사하기
		boolean isLogin = super.checkLogin(request);
		
		if(isLogin) { // 로그인을 한 경우
			
			String method = request.getMethod();
			
		//	if("POST".equalsIgnoreCase(method)) { // POST 방식으로 접근한 경우
		
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
				
				String userid = loginuser.getUserid();
				
				InterProductDAO pdao = new ProductDAO();
				
				// 로그인 중인 사용자의 아이디로 최근 주문 코드 조회하기
				String ordernum = pdao.selectRecentOrdernum(userid);
				
				// 주문 번호로 주문 상세 정보 알아오기
				List<OrderVO> orderList = pdao.selectOrderInfo(ordernum);
				request.setAttribute("orderList", orderList);
				
				// optionnum으로 optionname알아오기
				List<String> optionnumList = new ArrayList<>();
				for(int i=0; i<orderList.size(); i++) {
					String optionnum = String.valueOf(orderList.get(i).getOdvo().getOptionnum());
					
					optionnumList.add(optionnum);
				}
				List<String> optionnameList = pdao.selectOptionName(optionnumList);
			//	String optionname = String.join(",", optionnameList);
				
			//	System.out.println(optionname);
				
				request.setAttribute("optionnameList", optionnameList);
				
				int totalPrice_origin = 0; // 총 주문금액(정가기준)
				for(OrderVO order : orderList) {
					totalPrice_origin += order.getPvo().getProductprice() * order.getOdvo().getOrderqty();
				}
				
				request.setAttribute("totalPrice_origin", totalPrice_origin);
			
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/product_lsh/orderSuccess.jsp");
		//	}
		/*	else { // GET 방식으로 접근한 경우
				
				String message = "잘못된 접근 경로입니다.";
	            String loc = "javascript:history.back()";
	               
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	              
	        //  super.setRedirect(false);   
	            super.setViewPage("/WEB-INF/msg.jsp");
			} */
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
