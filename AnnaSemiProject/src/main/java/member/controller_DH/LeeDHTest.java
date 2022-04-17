package member.controller_DH;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class LeeDHTest extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/view/login/ldhTest.jsp");
		
		
	}

}
