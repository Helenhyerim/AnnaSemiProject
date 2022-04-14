package product.controller_lsh;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
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
			
// 페이지바 시작
			Map<String, String> paraMap = new HashMap<>();
			
			// 사용자가 보고자하는 페이지바의 페이지 번호
			String currentShowPageNo = request.getParameter("currentShowPageNo");
			// 한 페이지당 화면상에 보여줄 리뷰 개수
			String sizePerPage = "6";
			
			// currentShowPageNo이 null인 경우 1 페이지로 변경해야 한다.
			if(currentShowPageNo == null) {
				currentShowPageNo = "1";
			}
			
			// sizePerPage가 null이거나 6이 아닌 경우 6으로 변경해야 한다.
			if(sizePerPage == null || !("6".equals(sizePerPage))) {
				sizePerPage = "6";
			}
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
			//     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			try {
				Integer.parseInt(currentShowPageNo);
			} catch(NumberFormatException e) {
				currentShowPageNo = "1";
			}
			
			paraMap.put("sizePerPage", sizePerPage);
			paraMap.put("productnum", productnum);
			
			// 페이징 처리를 위해 전체 리뷰에 대한 총페이지 알아오기
			int totalPage = pdao.getReviewTotalPage(paraMap);
			
			// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 
			//     토탈페이지수 보다 큰 값을 입력하여 장난친 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
			if( Integer.parseInt(currentShowPageNo) > totalPage ) {
				currentShowPageNo = "1";
			}
			
			paraMap.put("currentShowPageNo", currentShowPageNo);
			
			List<PurchaseReviewVO> reviewList = pdao.selectPagingReview(paraMap);
			
			int totalReviewCnt = reviewList.size();
			
			request.setAttribute("reviewList", reviewList);
			request.setAttribute("totalReviewCnt", totalReviewCnt);
			paraMap.put("sizePerPage", sizePerPage);
			
			String pageBar = "";
			
			int blockSize = 10;
			// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다. 
			
			int loop = 1;
			// loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(blockSize 지금은 10개) 까지만 증가하는 용도이다. 
			
			// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //
			int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
			// pageNo 는 페이지바에서 보여지는 첫번째 번호이다. 
			
			// **** [맨처음][이전] 만들기 **** //
			if( pageNo != 1 ) {
				pageBar += "<li class='page-item'><a class='page-link' href='productDetail.an?productnum="+productnum+"&currentShowPageNo=1&sizePerPage="+sizePerPage+"'>[맨처음]</a></li>"; 
				pageBar += "<li class='page-item'><a class='page-link' href='productDetail.an?productnum="+productnum+"&currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a></li>";  
			}
						
			while( !(loop > blockSize || pageNo > totalPage) ) {
			
				if( pageNo == Integer.parseInt(currentShowPageNo) ) {
					pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
				}
				else {
					pageBar += "<li class='page-item'><a class='page-link' href='productDetail.an?productnum="+productnum+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a></li>";   
				}
				
				loop++;
				pageNo++;
			}// end of while---------------------------------
			
			// **** [다음][마지막] 만들기 **** //
			// pageNo ==> 11
			if( pageNo <= totalPage ) {
				pageBar += "<li class='page-item'><a class='page-link' href='productDetail.an?productnum="+productnum+"&currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a></li>";  
				pageBar += "<li class='page-item'><a class='page-link' href='productDetail.an?productnum="+productnum+"&currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"'>[마지막]</a></li>"; 
			}
			
			request.setAttribute("pageBar", pageBar);
			request.setAttribute("totalPage", totalPage);
// 페이지바 끝			
			
			if(pvo != null) {
				request.setAttribute("pvo", pvo);
				
				// 리뷰 정보 조회(select)
				List<PurchaseReviewVO> rList = pdao.reviewInfo(productnum);
				request.setAttribute("rList", rList);
				
				// *** 옵션목록(Product_option)을 보여줄 메소드 생성하기 *** //
				// VO를 사용하지 않고 Map으로 처리해보겠습니다.
				List<HashMap<String, String>> optionList = pdao.getOptionList(productnum);
				request.setAttribute("optionList", optionList);
	
				// 할인 가격(정가 - 회원가)
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
