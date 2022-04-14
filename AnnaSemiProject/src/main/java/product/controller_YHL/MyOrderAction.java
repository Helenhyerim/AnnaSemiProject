package product.controller_YHL;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
	
		// form 태그로 넘긴 값
		// 사용자 아이디 : userid
		// 제품 코드 : productnum
		// 상품명 : productname
		// 옵션명(리스트) : opList
		// 옵션별 수량(리스트) : qtyList -> 총 수량은 리스트에 저장된 값 모두 더하기
		// 상품 가격(req, 고정값) : productprice -> 구매는 회원만 이용 가능한 메뉴로 할인가 적용
		// 상품 가격(sel, 고정값) : 선택 옵션은 항목이 하나라서 (상품가격(req) * 총수량) + 상품 가격(sel)로 구하기
		
		// 선택 옵션이 선택된 경우 opList와 qtyList 마지막 인덱스에 각각 '선물용 포장'과 '1'이 넣어지도록 함.
		
		//	super.setRedirect(false);
	//	super.setViewPage("/WEB-INF/view/product_YHL/order_YHL.jsp");
		
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
				
				List<ProductVO> productList = new ArrayList<ProductVO>();
				
				String[] cartnoList = cart_checked.split(",");
				
				for(String cartno : cartnoList) {
					
					// db 테이블이 있다면 넘길필요 없지않을까
					String opList = request.getParameter("opList[]");
					String qtyList = request.getParameter("qtyList[]");
					
					
					// 장바구니 페이지에서 넘어온 cart_checked(체크된 cartno) 로 주문페이지에 보여줄 아이템 조회해오기
					ProductVO pvoList = new ProductVO();
					pvoList = pdao.getOrderItems(cartno);	
					
					productList.add(pvoList);
				}
				request.setAttribute("productList", productList);
				
				int sumPrice = 0;
				int sumPoint = 0;
				// 주문한 상품에 대한 총 주문금액과 총포인트 알아오기
				for(String cartno : cartnoList) {
					
					Map<String, Integer> totalpricepointMap = pdao.getTotalPricePoint(cartno);
					
					sumPrice += totalpricepointMap.get("sumPrice");
					sumPoint += totalpricepointMap.get("sumPoint");
					
				}
			
				request.setAttribute("sumPrice", sumPrice);
			//	System.out.println("sumPrice =>" + sumPrice);
				request.setAttribute("discountedsumPrice", sumPrice*0.95);
				request.setAttribute("sumPoint", sumPoint);
				
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
