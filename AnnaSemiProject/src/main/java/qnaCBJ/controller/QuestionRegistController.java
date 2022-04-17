package qnaCBJ.controller;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import qnaCBJ.model.QnaDAO;
import qnaCBJ.model.QnaVO;
import qnaCBJ.model.InterQnaDAO;
import member.model.MemberVO;
import qnaCBJ.model.InterQnaDAO;
import qnaCBJ.model.QnaDAO;
import qnaCBJ.model.QnaVO;

public class QuestionRegistController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession();
		
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
			
		String method = request.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) { // GET 이라면
											
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/view/qnaCBJ/questionRegist.jsp");
			
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
                request.setAttribute("loc", request.getContextPath()+"/questionRegist.an"); 
              
                super.setViewPage("/WEB-INF/msg.jsp");
                return; // 종료
			}				
		// ==== 파일을 업로드 해준다. 끝 ==== //
			
		// === 첨부 이미지 파일을 올렸으니 그 다음으로 제품정보를 (제품명, 정가, 제품수량,...) DB의 tbl_product 테이블에 insert 를 해주어야 한다.  ===
			
			// 새로운 제품 등록시 form 태그에서 입력한 값들을 얻어오기
			String fk_userId = mtrequest.getParameter("fk_userId");
			String questionTitle = mtrequest.getParameter("questionTitle");
			String questionContents = mtrequest.getParameter("questionContents");
			String questionImg = mtrequest.getFilesystemName("questionImg");
			
			InterQnaDAO qdao = new QnaDAO();
			
			// 제품번호 채번 해오기 // 채번 : 시퀀스를 자동증가
			int qnano = qdao.getEnumOfQna();
			
			QnaVO qvo = new QnaVO();
			qvo.setQnaNo(qnano);
			qvo.setFk_userId(fk_userId);
			qvo.setQuestionTitle(questionTitle);
			qvo.setQuestionContents(questionContents);
			qvo.setQuestionImg(questionImg);
			
			String message = "";
			String loc = "";
							
			try {
				qdao.questionInsert(qvo);
				
				message = "등록 성공!!";
				loc = request.getContextPath()+"/qna.an";
				
			} catch(SQLException e) {
				e.printStackTrace();
				
				message = "등록 실패!!";
				loc = request.getContextPath()+"/questionRegist.an";
			}
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setViewPage("/WEB-INF/msg.jsp");

		}		
	}

}
