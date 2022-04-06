package product.controller_lsh;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;

public class AddCartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		String productnum = request.getParameter("pnum");
		String productname = request.getParameter("pname");
		String[] opList = request.getParameterValues("opList[]");
		String[] qtyList = request.getParameterValues("qtyList[]");
		String productprice = request.getParameter("pprice");
		
		String orderqty = "";
		
		for(String qty : qtyList) {
			orderqty += Integer.parseInt(qty);
		}
		
		System.out.println(orderqty);
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("userid", userid);
		paraMap.put("productnum", productnum);
		paraMap.put("orderqty", orderqty);
		
		try {
			InterProductDAO pdao = new ProductDAO();
		
			int n = pdao.addCartProduct(paraMap);
		
			if(n == 1) {
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/product/addCart.jsp");	
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
