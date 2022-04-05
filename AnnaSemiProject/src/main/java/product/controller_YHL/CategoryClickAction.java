package product.controller_YHL;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;
import product.model_lsh.ProductVO;

public class CategoryClickAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO pdao = new ProductDAO();
		
		

		Map<String, String> paraMap = new HashMap<>();

		String currentShowPageNo = request.getParameter("currentShowPageNo");
		// currentShowPageNo 은 사용자가 보고자 하는 페이지바의 페이지번호이다.
		// 메뉴에서 회원목록만을 클릭했을 경우 currentShowPageNo 은 null 이 된다.
		// currentShowPageNo 이 null 이라면 currentShowPageNo 를 1 페이지로 바꾸어야 한다.

		String sizePerPage = request.getParameter("sizePerPage");
		// sizePerPage 한 페이지당 화면에 보여줄 회원(행)의 개수이다.
		// 메뉴에서 회원목록만을 클릭했을 경우 sizePerPage 은 null 이 된다.
		// sizePerPage 이 null 이라면 sizePerPage 를 9 으로 바꾸어야 한다.
		// "9" 또는 "6" 또는 "3" 등..

		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}

		if(sizePerPage == null ||
				!("3".equals(sizePerPage) || "6".equals(sizePerPage) || "9".equals(sizePerPage)) ) {
			sizePerPage = "9";
		}

		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
		//     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== //
		try {
			Integer.parseInt(currentShowPageNo);
		} catch (NumberFormatException e) {
			// 글자로 장난쳐와도 1로 해준다.
			currentShowPageNo = "1";
		}

		paraMap.put("sizePerPage", sizePerPage);

		
		// 전체회원에 대한 총페이지 알아오기
		int totalPage = pdao.getTotalPage(paraMap);

		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 토탈페이지수보다 큰 값을 입력해 
		//     장난친 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
		if(Integer.parseInt(currentShowPageNo) > totalPage ) {
			currentShowPageNo = "1";
		}

		paraMap.put("currentShowPageNo", currentShowPageNo);


		List<ProductVO> productList = pdao.selectPagingProduct(paraMap);

		
		request.setAttribute("sizePerPage", sizePerPage); // jsp 단에서 선택한 페이지수를 유지해주기위해 넘겨준다


		// *** === 페이지바 만들기 시작 === *** //

		String pageBar = "";

		int blockSize = 10;
		// blockSize 는 블럭(토막)당 보여지는 페이지번호의 개수이다.

		int loop = 1;
		// loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(blockSize 지금은 10개) 까지만 증가하는 용도이다.

		// !!! 다음은 pageNo 를 구하는 공식이다 !!! //
		int pageNo = ( (Integer.parseInt(currentShowPageNo)- 1)/blockSize ) * blockSize + 1  ;
		// pageNo 는 페이지바에서 보여지는 첫번째 번호이다. 1, 11, 21...


		// **** [맨처음] [이전] 만들기 **** //
		if( pageNo != 1 ) {
			pageBar += "<li class='page-item'><a class='page-link' href='categoryClick.an?currentShowPageNo=1&sizePerPage="+sizePerPage+"'>[맨처음]</a></li>"; 
			pageBar += "<li class='page-item'><a class='page-link' href='categoryClick.an?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a></li>";  
		}

		while( !(loop > blockSize || pageNo > totalPage) ) {

			if( pageNo == Integer.parseInt(currentShowPageNo) ) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='categoryClick.an?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a></li>";   
			}

			loop++;
			pageNo++; // 빠져나올 때 11이다.
		}// end of while( !(loop > blockSize) )  ------

		// **** [다음] [마지막] 만들기 **** //
		// pageNo ==> 11 인 상태에서
		if( pageNo <= totalPage) {// 맨 마지막에는 다음과 마지막이 나오지 않게 하기 위해
			pageBar += "<li class='page-item'><a class='page-link' href='categoryClick.an?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a></li>";  
			pageBar += "<li class='page-item'><a class='page-link' href='categoryClick.an?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+"'>[마지막]</a></li>"; 

		}

		request.setAttribute("pageBar", pageBar);

		// *** === 페이지바 만들기 끝 === *** //

		
		// *** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 *** //

		request.setAttribute("productList", productList);
		

		//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/view/product_YHL/category_YHL.jsp");

	}

}