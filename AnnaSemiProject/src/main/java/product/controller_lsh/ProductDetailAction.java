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
import product.model_lsh.PurchaseReviewVO;

public class ProductDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
			// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임.
			super.goBackURL(request);
			
			// 카테고리 목록 조회
			super.getCategoryList(request);
		
			String productnum = request.getParameter("productnum");
			
			// 사용자가 주소 입력창에서 장난치는 경우 productnum="문자" or "존재하지 않는 제품번호"
			// 참고 : (ProdViewAction.java), (MemberListAction.java)
			try {
				Integer.parseInt(productnum);
			} catch(NumberFormatException e) {
				String message = "잘못된 접근 경로입니다.";
				String loc = request.getContextPath() + "/index.an";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return; // execute() 메소드를 종료시킨다.
			}
			
			// 상품 정보 조회(select)
			InterProductDAO pdao = new ProductDAO();
			ProductVO pvo = pdao.productInfo(productnum);
			
			// 리뷰 정보 조회(select)
			List<PurchaseReviewVO> reviewList = pdao.reviewInfo(productnum);
			
			if(pvo != null) {
				request.setAttribute("pvo", pvo);
				request.setAttribute("reviewList", reviewList);
				
				// 할인 가격
				String discountPrice = String.valueOf(pvo.getProductprice() - pvo.getSaleprice());
				request.setAttribute("discountPrice", discountPrice);
				
				// 상품 이미지 조회(select)
				List<ProductImageVO> imgList = pdao.productImageSelectAll(productnum);
				request.setAttribute("imgList", imgList);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/product_lsh/productDetail.jsp");
			}
			else {
				String message = "잘못된 접근 경로입니다.";
				String loc = request.getContextPath() + "/index.an";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return; // execute() 메소드를 종료시킨다.
			}
	}

}
