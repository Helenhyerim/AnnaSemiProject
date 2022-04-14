package eventCBJ.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import eventCBJ.model.*;
import my.utilCBJ.MyUtil;

public class EventController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterEventDAO fdao = new EventDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		String sizePerPage = request.getParameter("sizePerPage");
				
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		sizePerPage = "10";
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
		//     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
		try {
			Integer.parseInt(currentShowPageNo);
		} catch(NumberFormatException e) {
			currentShowPageNo = "1";
		}
				
		paraMap.put("sizePerPage", sizePerPage);
		
		int totalPage = fdao.getTotalPage(paraMap);
		
		if( Integer.parseInt(currentShowPageNo) > totalPage ) {
			currentShowPageNo = "1";
		}
		
		paraMap.put("currentShowPageNo", currentShowPageNo);
		
		List<EventVO> eventList = fdao.selectPagingEvent(paraMap);
		
		request.setAttribute("eventList", eventList);
		request.setAttribute("sizePerPage", sizePerPage);
		
		String pageBar = "";
		
		int blockSize = 10;
		
		int loop = 1;
		
		int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
		
		if( pageNo != 1 ) {
			pageBar += "<li class='page-item'><a class='page-link' href='event.an?currentShowPageNo=1&sizePerPage="+sizePerPage+"'>[맨처음]</a></li>"; 
			pageBar += "<li class='page-item'><a class='page-link' href='event.an?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>[이전]</a></li>";  
		}
					
		while( !(loop > blockSize || pageNo > totalPage) ) {
		
			if( pageNo == Integer.parseInt(currentShowPageNo) ) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='event.an?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a></li>";   
			}
			
			loop++;
			pageNo++;
		}// end of while---------------------------------
		
		// **** [다음][마지막] 만들기 **** //
		// pageNo ==> 11
		if( pageNo <= totalPage ) {
			pageBar += "<li class='page-item'><a class='page-link' href='event.an?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>[다음]</a></li>";  
			pageBar += "<li class='page-item'><a class='page-link' href='event.an?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"'>[마지막]</a></li>"; 
		}
		
		request.setAttribute("pageBar", pageBar); 
		// **** ============ 페이지바 만들기 끝 ============ **** //
		
		// **** 현재 페이지를 돌아갈 페이지(goBackURL)로 주소 지정하기 **** //
		String currentURL = MyUtil.getCurrentURL(request);
		
		currentURL = currentURL.replaceAll("&", " ");
		
		request.setAttribute("goBackURL", currentURL);		
		
		super.setViewPage("/WEB-INF/view/eventCBJ/event.jsp");
		
	}

}
