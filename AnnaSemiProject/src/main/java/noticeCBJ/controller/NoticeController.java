package noticeCBJ.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import noticeCBJ.model.*;

public class NoticeController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {		
		
		// 검색이 있을 경우 시작 //
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		InterNoticeDAO ndao = new NoticeDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		
		String noticeCurrentShowPageNo = request.getParameter("noticeCurrentShowPageNo");
		String noticeSizePerPage = request.getParameter("noticeSizePerPage");
		
		if(noticeCurrentShowPageNo == null) {
			noticeCurrentShowPageNo = "1";
		}
		
		if(noticeSizePerPage == null ||
			!("3".equals(noticeSizePerPage) || "5".equals(noticeSizePerPage) || "10".equals(noticeSizePerPage)) ) {
			noticeSizePerPage = "10";
		}
		
		try {
			Integer.parseInt(noticeCurrentShowPageNo);
		} catch(NumberFormatException e) {
			noticeCurrentShowPageNo = "1";
		}
		
		paraMap.put("noticeSizePerPage", noticeSizePerPage);
		
		// 검색이 있을 경우 시작 //						
		if( searchType != null && !"".equals(searchType) && !"noticeTitle".equals(searchType) && !"noticeContents".equals(searchType)) {
			// 사용자가 웹브라우저 주소입력란에서 searchType 란에 장난친 경우
			String message = "부적절한 검색 입니다. 장난치지 마세요~~";
			String loc = request.getContextPath()+"/notice.an";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/view/noticeCBJ/notice.jsp");
			
			return; // execute() 메소드를 종료시킨다.
		}
		paraMap.put("searchType", searchType); 
		paraMap.put("searchWord", searchWord); 
		// 검색이 있을 경우 끝 //

		int totalPage = ndao.noticeGetTotalPage(paraMap);
		
		if( Integer.parseInt(noticeCurrentShowPageNo) > totalPage ) {
			noticeCurrentShowPageNo = "1";
		}

		paraMap.put("noticeCurrentShowPageNo", noticeCurrentShowPageNo);
		
		List<NoticeVO> noticeList = ndao.noticeSelectPagingMember(paraMap);
		
		request.setAttribute("noticeList", noticeList);
		request.setAttribute("noticeSizePerPage", noticeSizePerPage);
		
		String pageBar = "";
		
		int blockSize = 10;
		
		int loop = 1;
				
		int pageNo = ( ( Integer.parseInt(noticeCurrentShowPageNo) - 1)/blockSize ) * blockSize + 1;
		
		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
		
		if(pageNo != 1) {
			pageBar += "<li class='page-item'><a class='page-link' href='notice.an?noticeCurrentShowPageNo=1&noticeSizePerPage="+noticeSizePerPage+"'>[맨처음]</a></li>";
			pageBar += "<li class='page-item'><a class='page-link' href='notice.an?noticeCurrentShowPageNo="+(pageNo-1)+"&noticeSizePerPage="+noticeSizePerPage+"'>[이전]</a></li>";
		}
		while( !( loop > blockSize || pageNo > totalPage) ) {
			if( pageNo == Integer.parseInt(noticeCurrentShowPageNo) ) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; // 부트스트랩
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='notice.an?noticeCurrentShowPageNo="+pageNo+"&noticeSizePerPage="+noticeSizePerPage+"'>"+pageNo+"</a></li>";
			}
			loop++;
			pageNo++;
		}// end of while--------------------------------------------	
		
		if(pageNo <= totalPage) {
			pageBar += "<li class='page-item'><a class='page-link' href='notice.an?noticeCurrentShowPageNo="+pageNo+"&noticeSizePerPage="+noticeSizePerPage+"'>[다음]</a></li>";				
			pageBar += "<li class='page-item'><a class='page-link' href='notice.an?noticeCurrentShowPageNo="+totalPage+"&noticeSizePerPage="+noticeSizePerPage+"'>[마지막]</a></li>";
		}
		
		request.setAttribute("pageBar", pageBar); 
		
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchWord", searchWord);
		
		super.setViewPage("/WEB-INF/view/noticeCBJ/notice.jsp");
	}

}
