package product.controller_lsh;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import my.util.MyUtil;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;
import product.model_lsh.ProductImageVO;
import product.model_lsh.ProductVO;

public class ProductDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		
			String productnum = request.getParameter("productnum");
		
			InterProductDAO pdao = new ProductDAO();
			ProductVO pvo = pdao.productInfo(productnum);	// 상품 정보 조회(select)
			
			request.setAttribute("pvo", pvo);
			
			String discountPrice = String.valueOf(pvo.getProductprice() - pvo.getSaleprice());
			
			request.setAttribute("discountPrice", discountPrice);
			
			List<ProductImageVO> imgList = pdao.productImageSelectAll(productnum);	// 상품 이미지 조회(select)
			
			request.setAttribute("imgList", imgList);

			// 로그인 후 이용가능한 기능을 로그인하지 않은 사용자가 이용하려고 하는 경우
			// 로그인 페이지로 이동 후 다시 제품상세페이지로 돌아오기 위한 것
			String currentURL = MyUtil.getCurrentURL(request);
			
			request.setAttribute("goBackURL", currentURL);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/product_lsh/productDetail.jsp");
		
	}

}
