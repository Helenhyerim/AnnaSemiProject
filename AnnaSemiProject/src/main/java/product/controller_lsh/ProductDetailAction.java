package product.controller_lsh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class ProductDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/product_lsh/productDetail.jsp");
		
	}

}
