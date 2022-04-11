package product.controller_YHL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;

public class MyOrderPayEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 아임포트 결제창을 사용하기 위한 전제 조건은, 먼저 로그인을 해야 하는 것이다.
		if(super.checkLogin(request)) {// true 라면 로그인을 한 경우임
			
			String userid = request.getParameter("userid"); 
			String paymentprice = request.getParameter("paymentprice"); 
			/*
				const url = "<%= request.getContextPath()%>/product/myOrderPayEnd.an?userid="+userid+"&paymentprice="+sum;
				의 get 방식으로 저장해둔 userid 를 가져온 것임
			*/
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser.getUserid().equals(userid)) {// 세션에 저장된 아이디와, getPara 한 아이디가 같으면
				// 즉 로그인 한 사용자가 자신의 결제 하는 경우
	
				// 아직 paymentprice 안넘겨줌, jsp 에서 100 으로 고정됨
				
				request.setAttribute("paymentprice", paymentprice);
				request.setAttribute("email", loginuser.getEmail());
				request.setAttribute("name", loginuser.getName());
				request.setAttribute("mobile", loginuser.getMobile());
				request.setAttribute("userid", userid);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/view/product_YHL/paymentGateway.jsp");
				
			}
			else {// 로그인 한 사용자가 다른 사용자의 상품 결제를 시도 하는 경우
				String message = "다른 사용자의 상품 결제는 불가합니다!";
				String loc = "javascript:history.back()";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
			}
			
		}
		else {// 로그인을 안했으면
			String message = "상품 결제를 하기 위해서는 먼저 로그인을 하세요!";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
	 
	}

}
