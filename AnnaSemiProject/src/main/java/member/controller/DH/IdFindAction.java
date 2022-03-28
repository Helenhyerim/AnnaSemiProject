package member.controller.DH;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class IdFindAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String method = request.getContextPath();
		super.setViewPage("/WEB-INF/view/login/idFind.jsp");
		if("GET".equalsIgnoreCase(method)) {
			
			
			super.setViewPage("/WEB-INF/view/login/idFind.jsp");
		}
		else {
			
		}
		
		
		

	}

}
