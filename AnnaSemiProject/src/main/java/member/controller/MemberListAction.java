package member.controller;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;


public class MemberListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		// == 관리자(일단 지금은 hongkd)로 로그인 했을 때만 조회가능하게 하기 == //
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser == null || !"hongkd".equals(loginuser.getUserid()) ) {
			// 로그인을 안한 경우 또는 일반사용자로 로그인 한 경우
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		else {
		
		// 관리자(일단 지금은 hongkd)로 로그인 했을 경우 
		// == 페이징 처리가 되어진 모든 회원 또는 검색한 회원 목록 보여주기 == //
						
		// 검색이 있을 경우
		String searchType = request.getParameter("searchType");
		String searchWord = request.getParameter("searchWord");
		
		InterMemberDAO mdao = new MemberDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		
		String currentShowPageNo = request.getParameter("currentShowPageNo");
		// currentShowPageNo 은 사용자가 보고자 하는 페이지바의 페이지번호 이다.
		// 메뉴에서 회원목록 만을 클릭했을 경우에는 currentShowPageNo 은 null 이 된다.
		// currentShowPageNo 이 null 이라면 currentShowPageNo 을 1 페이지로 바꾸어야 한다.
		
		String sizePerPage = request.getParameter("sizePerPage");
		// 한 페이지당 화면상에 보여줄 회원의 개수
		// 메뉴에서 회원목록 만을 클릭했을 경우에는 sizePerPage 는 null 이 된다.
		// sizePerPage 가 null 이라면 sizePerPage 를 10 으로 바꾸어야 한다.
		// "10" 또는 "5" 또는 "3" 
		
		if(currentShowPageNo == null) {
			currentShowPageNo = "1";
		}
		
		if(sizePerPage == null || 
		   !("3".equals(sizePerPage) || "5".equals(sizePerPage) || "10".equals(sizePerPage)) ) {
			sizePerPage = "10";
		}
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 숫자가 아닌 문자를 입력한 경우 또는 
		//     int 범위를 초과한 숫자를 입력한 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
		try {
			Integer.parseInt(currentShowPageNo);
		} catch(NumberFormatException e) {
			currentShowPageNo = "1";
		}
		
		paraMap.put("sizePerPage", sizePerPage);		
		
		
		// === 검색이 있을 경우 시작 === //
			if(searchType != null && !"".equals(searchType) && !"name".equals(searchType) && !"userid".equals(searchType) && !"email".equals(searchType)) {
			    // 사용자가 웹브라우저 주소입력란에서 searchType 란에 장난친 경우 
				String message = "부적절한 검색 입니다. 장난치지 마세요~~";
				String loc = request.getContextPath()+"/member/memberList.an";
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/msg.jsp");
				
				return; // execute() 메소드를 종료시킨다.
			}
			
			paraMap.put("searchType", searchType); 
			paraMap.put("searchWord", searchWord); 
			// === 검색이 있을 경우 끝 === //
		
		// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총 페이지 알아오기 
		int totalPage = mdao.getTotalPage(paraMap);
		
		//System.out.println("확인용 totalPage =>" +totalPage);
		
		// === GET 방식이므로 사용자가 웹브라우저 주소창에서 currentShowPageNo 에 토탈페이지수보다 큰 값을 입력하여  
		//     장난친 경우라면 currentShowPageNo 는 1 페이지로 만들도록 한다. ==== // 
		if ( Integer.parseInt(currentShowPageNo) > totalPage ){
			currentShowPageNo = "1";
		}
		

		
		paraMap.put("currentShowPageNo", currentShowPageNo);

		
		List<MemberVO> memberList = mdao.selectPagingMember(paraMap);
		
		request.setAttribute("memberList", memberList);
		request.setAttribute("sizePerPage", sizePerPage)	;
		
		String pageBar = "";
		
		int blockSize = 10;
		// blockSize는 블럭(토막)당 보여지는 페이지 번호의 개수이다.
		
		int loop = 1;
		// loop는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 개수(blockSize 지금은 10개)까지만 증가하는 용도이다.
		
		
		// !!!! 다음은 pageNo을 구하는 공식이다.!!! // 
		int pageNo = ( ( Integer.parseInt(currentShowPageNo) - 1)/blockSize ) * blockSize + 1;
		// pageNo는 페이지바에서 보여지는 첫번째 번호이다.
		

		if(searchType == null) {
			searchType = "";
		}
		
		if(searchWord == null) {
			searchWord = "";
		}
		
		
		// ** [맨처음][이전] 만들기 ** //
		if(pageNo !=1) {
			pageBar += "<li class='page-item'><a class='page-link' href='memberList.an?currentShowPageNo=1&sizePerPage="+sizePerPage+"'>《</a></li>"; 
			pageBar += "<li class='page-item'><a class='page-link' href='memberList.an?currentShowPageNo="+(pageNo-1)+"&sizePerPage="+sizePerPage+"'>〈</a></li>"; 
		}
		
		
		while( !(loop > blockSize || pageNo > totalPage) ) {
			
			if( pageNo == Integer.parseInt(currentShowPageNo) ) {
				pageBar += "<li class='page-item active'><a class='page-link' href='#'>"+pageNo+"</a></li>"; 
			}
			else {
				pageBar += "<li class='page-item'><a class='page-link' href='memberList.an?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>"+pageNo+"</a></li>"; 
			}
			loop++;
			pageNo++;
		} // end of while
		
		// ** [다음][마지막] 만들기 ** //
		if(pageNo <= totalPage) {
		pageBar += "<li class='page-item'><a class='page-link' href='memberList.an?currentShowPageNo="+pageNo+"&sizePerPage="+sizePerPage+"'>〉</a></li>"; 
		
		pageBar += "<li class='page-item'><a class='page-link' href='memberList.an?currentShowPageNo="+totalPage+"&sizePerPage="+sizePerPage+"'>》</a></li>"; 
		}
		
		request.setAttribute("pageBar", pageBar); 
		// **** ============ 페이지바 만들기 끝 ============ **** //
		
		request.setAttribute("searchType", searchType);
		request.setAttribute("searchWord", searchWord);
		
		
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/view/member/memberList.jsp");
		}
		
	}

}
