package member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class MyPageAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 일단 파일 보여주고..
		super.setRedirect(false);
        super.setViewPage("/WEB-INF/view/member/myPage.jsp");
        
        // get으로 왔는데 아이디가 다르면 안된다고 말하기..
        
        // post로 와야 함. 

	}

}
