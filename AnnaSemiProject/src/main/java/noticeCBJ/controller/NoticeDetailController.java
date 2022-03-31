package noticeCBJ.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class NoticeDetailController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		super.setViewPage("/WEB-INF/view/noticeCBJ/noticeDetail.jsp");
		
	}

}
