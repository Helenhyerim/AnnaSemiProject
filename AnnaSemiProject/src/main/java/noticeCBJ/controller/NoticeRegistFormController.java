package noticeCBJ.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class NoticeRegistFormController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		super.setViewPage("/WEB-INF/view/noticeCBJ/noticeRegistForm.jsp");
	}

}
