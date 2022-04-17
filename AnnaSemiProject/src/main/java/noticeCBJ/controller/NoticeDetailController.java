package noticeCBJ.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberDAO;
import noticeCBJ.model.*;

public class NoticeDetailController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		super.setViewPage("/WEB-INF/view/noticeCBJ/noticeDetail.jsp");
		
	}

}
