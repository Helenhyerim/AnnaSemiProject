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
			
			// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임.
			super.goBackURL(request);
			
			// 카테고리 목록 조회
			super.getCategoryList(request);
		
			String productnum = request.getParameter("productnum");
		
			// 상품 정보 조회(select)
			InterProductDAO pdao = new ProductDAO();
			ProductVO pvo = pdao.productInfo(productnum);
			request.setAttribute("pvo", pvo);
			
			// 할인 가격
			String discountPrice = String.valueOf(pvo.getProductprice() - pvo.getSaleprice());
			request.setAttribute("discountPrice", discountPrice);
			
			// 상품 이미지 조회(select)
			List<ProductImageVO> imgList = pdao.productImageSelectAll(productnum);
			request.setAttribute("imgList", imgList);
			
			// 사용자가 주소 입력창에서 장난치는 경우 productnum="문자" or "존재하지 않는 제품번호" or "공백" 등
			// 참고 : (ProdViewAction.java), 페이지바 만들었던 페이지(찾아보기)
			
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/product_lsh/productDetail.jsp");
		
	}

}
