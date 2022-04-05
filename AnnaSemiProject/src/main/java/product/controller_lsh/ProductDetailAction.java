package product.controller_lsh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import my.util.MyUtil;
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

			// 로그인 후 이용가능한 기능을 로그인하지 않은 사용자가 이용하려고 하는 경우
			// 로그인 페이지로 이동 후 다시 제품상세페이지로 돌아오기 위한 것
			String currentURL = MyUtil.getCurrentURL(request);
			
			request.setAttribute("goBackURL", currentURL);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/product_lsh/productDetail.jsp");
		
	}

}
