package product.controller_lsh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;
import product.model_lsh.ProductVO;

public class ProductDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			String productnum = request.getParameter("productnum");
		//	System.out.println("확인용 productnum =>" +productnum);
			
			request.setAttribute("productnum", productnum);
			
			InterProductDAO pdao = new ProductDAO();
			ProductVO pvo = pdao.getProductDetail(productnum);
		
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/product_lsh/productDetail.jsp");
		
	}

}
