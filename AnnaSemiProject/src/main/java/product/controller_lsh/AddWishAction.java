package product.controller_lsh;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;
import product.model_lsh.ProductVO;

public class AddWishAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		// 제품코드와 로그인한 사용자 아이디 받아오기
		String productnum = request.getParameter("productnum");
		String userid = request.getParameter("userid");
		
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

}
