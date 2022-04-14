package qnaCBJ.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import my.utilCBJ.MyUtil;
import qnaCBJ.model.*;

public class QnaController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");

		InterQnaDAO ndao = new QnaDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		
		String sizePerPage = request.getParameter("sizePerPage");
		
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		sizePerPage = "10";
		
		try {
			Integer.parseInt(currentShowPageNo);
		} catch(NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		paraMap.put("sizePerPage", sizePerPage);
		
		// === 검색이 있을 경우 시작 === //
		if(searchType != null && !"".equals(searchType) && !"questionTitle".equals(searchType) && !"questionContents".equals(searchType)) {
		    // 사용자가 웹브라우저 주소입력란에서 searchType 란에 장난친 경우 
			String message = "부적절한 검색 입니다. 장난치지 마세요~~";
			String loc = request.getContextPath()+"/qna.an";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return; // execute() 메소드를 종료시킨다.
		}
		
		paraMap.put("searchType", searchType); 
		paraMap.put("searchWord", searchWord); 
		// === 검색이 있을 경우 끝 === //
		
		// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기 
		int totalPage = ndao.getTotalPage(paraMap);
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 
		//     토탈페이지수 보다 큰 값을 입력하여 장난친 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
		if( Integer.parseInt(currentShowPageNo) > totalPage ) {
			currentShowPageNo = "1";
		}
		
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		List<QnaVO> qnaList = ndao.selectPagingQna(paraMap);
		
		request.setAttribute("qnaList", qnaList);
		request.setAttribute("sizePerPage", sizePerPage);
		
		
		String pageBar = "";
		
		int blockSize = 10;
		// blockSize 는 블럭(토막)당 보여지는 페이지 번호의 개수이다. 
		
		int loop = 1;
		// loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(blockSize 지금은 10개) 까지만 증가하는 용도이다. 
		
		// !!!! 다음은 pageNo 를 구하는 공식이다. !!!! //
		int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
		// pageNo 는 페이지바에서 보여지는 첫번째 번호이다. 
		
		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
		
		// **** [맨처음][이전] 만들기 **** //
		if( pageNo != 1 ) {
			pageBar += "<li class='page-item'><a class='page-link' href='qna.an?currentShowPageNo=1&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>&#8810;</a></li>"; 
			pageBar += "<li class='page-item'><a class='page-link' href='qna.an?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>&lt;</a></li>";  
		}
					
		while( !(loop > blockSize || pageNo > totalPage) ) {
		
			if( pageNo == Integer.parseInt(currentShowPageNo) ) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='qna.an?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>"+pageNo+"</a></li>";   
			}
			
			loop++;
			pageNo++;
		}// end of while---------------------------------
		
		// **** [다음][마지막] 만들기 **** //
		// pageNo ==> 11
		if( pageNo <= totalPage ) {
			pageBar += "<li class='page-item'><a class='page-link' href='qna.an?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>&gt;</a></li>";  
			pageBar += "<li class='page-item'><a class='page-link' href='qna.an?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"&searchType="+searchType+"&searchWord="+searchWord+"'>&#8811;</a></li>"; 
		}
		
		request.setAttribute("pageBar", pageBar); 
		// **** ============ 페이지바 만들기 끝 ============ **** //
		
		// **** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 **** //
		String currentURL = MyUtil.getCurrentURL(request);
		
		request.setAttribute("goBackURL", currentURL);
		
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchWord", searchWord);

		super.setViewPage("/WEB-INF/view/qnaCBJ/qna.jsp");
	}

}
