package product.controller_YHL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import cart.model.CartDAO;
import cart.model.InterCartDAO;
import common.controller.AbstractController;
import member.model.MemberVO;

public class DeleteCartItemAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 장바구니에 있는 상품을 삭제하기 위한 전제조건은 먼저 로그인을 해야하는 것이다
		if(super.checkLogin(request)) {// 로그인을 한 경우
		
			String userid = request.getParameter("userid");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");

			if(loginuser.getUserid().equals(userid)) {// 로그인 한 사용자가 자신의 장바구니에 있는 상품을 삭제할때
			
				String cart_checkBox = request.getParameter("cart_checkBox");
				//	System.out.println("확인용 cart_checkBox =>" + cart_checkBox); cartno 1, 2 ..
				String[] cartno_list = cart_checkBox.split(","); // 1 2 
				
				InterCartDAO cdao = new CartDAO();
				
				// 장바구니에서 (선택)상품을 삭제하기
				int n = cdao.deleteCartItems(cartno_list);
				
				if(n != 0) {// 삭제에 성공한 경우
					JSONObject jsonObj = new JSONObject(); // {}
					jsonObj.put("cartDeleteResult", true);
					
					String json = jsonObj.toString(); 
					
					request.setAttribute("json", json);
					
					super.setRedirect(false);
					super.setViewPage("/WEB-INF/jsonview.jsp");
				}
			}
		}
		
	}

}
