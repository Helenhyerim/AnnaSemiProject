package qnaCBJ.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class QnaRegistController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		super.setViewPage("/WEB-INF/view/qnaCBJ/qnaRegist.jsp");
		
	}

}
