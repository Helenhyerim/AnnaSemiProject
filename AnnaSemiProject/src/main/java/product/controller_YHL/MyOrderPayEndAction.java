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
			String totalpayprice = request.getParameter("paymentprice"); 
			String totalpaypoint = request.getParameter("totalpaypoint"); 
			String receivedname = request.getParameter("receivedname"); 
			String postcode = request.getParameter("postcode"); 
			String address = request.getParameter("address"); 
			/*	
			System.out.println("~~~ 확인용 userid =>" + userid);
			System.out.println("~~~ 확인용 totalpayprice =>" + totalpayprice);
			System.out.println("~~~ 확인용 totalpaypoint =>" + totalpaypoint);
			System.out.println("~~~ 확인용 receivedname =>" + receivedname);
			System.out.println("~~~ 확인용 postcode =>" + postcode);
			System.out.println("~~~ 확인용 address =>" + address);
			*/
			
			/*
				const url = "<%= request.getContextPath()%>/product/myOrderPayEnd.an?userid="+userid+"&paymentprice="+sum;
				의 get 방식으로 저장해둔 userid 를 가져온 것임
			*/
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			if(loginuser.getUserid().equals(userid)) {// 세션에 저장된 아이디와, getPara 한 아이디가 같으면
				// 즉 로그인 한 사용자가 자신의 결제 하는 경우
	
				// userid, totalpayprice, totalpaypoint, receivedname, postcode, address
				request.setAttribute("userid", userid);

				// 아직 paymentprice, point 안넘겨줌, jsp 에서 100 으로 고정됨
				request.setAttribute("totalpayprice", totalpayprice);
				request.setAttribute("totalpaypoint", totalpaypoint);
				request.setAttribute("receivedname", receivedname);
				request.setAttribute("postcode", postcode);
				request.setAttribute("address", address);
				
				
				request.setAttribute("email", loginuser.getEmail());
				request.setAttribute("name", loginuser.getName());
				request.setAttribute("mobile", loginuser.getMobile());
				
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
