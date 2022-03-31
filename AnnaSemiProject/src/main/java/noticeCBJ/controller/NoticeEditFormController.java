package noticeCBJ.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class NoticeEditFormController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String noticeNo = request.getParameter("noticeNo");
		String noticeTitle = request.getParameter("noticeTitle");
		
		
		super.setViewPage("/WEB-INF/view/noticeCBJ/noticeEditForm.jsp");
		
	}

}
