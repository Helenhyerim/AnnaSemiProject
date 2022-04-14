package eventCBJ.controller;


import java.io.IOException;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.ServletContext;
import javax.servlet.http.*;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import eventCBJ.model.*;
import member.model.MemberVO;

public class EventRegistFormController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		if( loginuser == null || !"admin".equals(loginuser.getUserid()) ) {
			String message = "관리자만 접근이 가능합니다.";
			String loc = "javascript:history.back()";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		else {
			
			String method = request.getMethod();
			
			if(!"POST".equalsIgnoreCase(method)) { // GET 이라면
												
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/view/eventCBJ/eventRegistForm.jsp");
				
			}
			else {
				
				MultipartRequest mtrequest = null;
				
				ServletContext svlCtx = session.getServletContext();
				String uploadFileDir = svlCtx.getRealPath("/imagesCBJ");
				
			// ==== 파일을 업로드 해준다. 시작 ==== //
				try {
					mtrequest = new MultipartRequest(request, uploadFileDir, 10*1024*1024, "UTF-8", new DefaultFileRenamePolicy());
				} catch(IOException e) {
					e.printStackTrace();
					
					request.setAttribute("message", "업로드 되어질 경로가 잘못되었거나 또는 최대용량 10MB를 초과했으므로 파일업로드 실패함!!");
	                request.setAttribute("loc", request.getContextPath()+"/eventRegistForm.an"); 
	              
	                super.setViewPage("/WEB-INF/msg.jsp");
	                return; // 종료
				}				
			// ==== 파일을 업로드 해준다. 끝 ==== //
				
			// === 첨부 이미지 파일을 올렸으니 그 다음으로 제품정보를 (제품명, 정가, 제품수량,...) DB의 tbl_product 테이블에 insert 를 해주어야 한다.  ===
				
				// 새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기
				String eventTitle = mtrequest.getParameter("eventTitle");
				String eventStartdate = mtrequest.getParameter("eventStartdate");
				String eventEnddate = mtrequest.getParameter("eventEnddate");
				String thumbNail = mtrequest.getFilesystemName("thumbNail");
				String eventImg1 = mtrequest.getFilesystemName("eventImg1");
				String eventImg2 = mtrequest.getFilesystemName("eventImg2");
				
				InterEventDAO edao = new EventDAO();
				
				// 제품번호 채번 해오기 // 채번 : 시퀀스를 자동증가
				int eventno = edao.getEnumOfEvent();
				
				EventVO evo = new EventVO();
				evo.setEventNo(eventno);
				evo.setEventTitle(eventTitle);
				evo.setEventStartdate(eventStartdate);
				evo.setEventEnddate(eventEnddate);
				evo.setEventImg1(eventImg1);
				evo.setEventImg2(eventImg2);
				evo.setThumbNail(thumbNail);
				
				String message = "";
				String loc = "";
								
				try {
					edao.eventInsert(evo);
					
					message = "등록 성공!!";
					loc = request.getContextPath()+"/event.an";
					
				} catch(SQLException e) {
					e.printStackTrace();
					
					message = "등록 실패!!";
					loc = request.getContextPath()+"/eventRegistForm.an";
				}
				
				request.setAttribute("message", message);
				request.setAttribute("loc", loc);
				
				super.setViewPage("/WEB-INF/msg.jsp");
				
			}
		
		}
		
	}

}
