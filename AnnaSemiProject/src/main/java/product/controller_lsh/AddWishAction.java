package product.controller_lsh;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;
import product.model_lsh.ProductVO;

public class AddWishAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		// 로그인 유무 검사하기
		boolean isLogin = super.checkLogin(request);
		
		if(isLogin) { // 로그인을 한 경우
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			String userid = loginuser.getUserid();
			String productnum = request.getParameter("productnum");
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("productnum", productnum);	// 정수 변환 해줘야 함(productDAO에서)
			paraMap.put("userid", userid);
			
			try {
				InterProductDAO pdao = new ProductDAO();
			
				int n = pdao.addWishProduct(paraMap);
			
				if(n == 1) {
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/product_lsh/addWish.jsp");	
				}
			} catch(SQLException e) {
				e.printStackTrace();
				
				String message = "SQL구문 에러발생";
				String loc = request.getContextPath() + "/product_lsh/productDetail.an?productnum=" + productnum;
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
			}
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
