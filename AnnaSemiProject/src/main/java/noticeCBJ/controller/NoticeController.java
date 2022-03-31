package noticeCBJ.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import noticeCBJ.model.*;

public class NoticeController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {		
		
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
		
		paraMap.put("noticeCurrentShowPageNo", noticeCurrentShowPageNo);
		paraMap.put("noticeSizePerPage", noticeSizePerPage);
		
		List<NoticeVO> noticeList = ndao.noticeSelectPagingMember(paraMap);
		
		request.setAttribute("noticeList", noticeList);
		
		String pageBar = "";
		
		int blockSize = 10;
		
		int loop = 1;
				
		int pageNo = ( ( Integer.parseInt(noticeCurrentShowPageNo) - 1)/blockSize ) * blockSize + 1;
		
		int totalPage = ndao.noticeGetTotalPage(paraMap);
		
		if( Integer.parseInt(noticeCurrentShowPageNo) > totalPage ) {
			noticeCurrentShowPageNo = "1";
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
		
		
		super.setViewPage("/WEB-INF/view/noticeCBJ/notice.jsp");
	}

}
