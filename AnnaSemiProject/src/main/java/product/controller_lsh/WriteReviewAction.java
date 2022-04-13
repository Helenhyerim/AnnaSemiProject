package product.controller_lsh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;
import product.model_lsh.ProductVO;

public class WriteReviewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		String productnum = request.getParameter("productnum");
		
		InterProductDAO pdao = new ProductDAO();
		
		request.setAttribute("userid", userid);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/product_lsh/writeReview.jsp");
		
	}

}
