package product.controller_YHL;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;
import product.model_lsh.ProductVO;

public class CategoryClickAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO pdao = new ProductDAO();
		List<ProductVO> imgList = pdao.productSelectAll();
		
		request.setAttribute("imgList", imgList);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/view/product_YHL/category_YHL.jsp");

	}

}
