package member.controller_DH;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class PwdUpdateEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		
		String method = request.getMethod();
		
		if("POST".equalsIgnoreCase(method)) {
			String pwd = request.getParameter("pwd");
			
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("pwd", pwd);
			paraMap.put("userid", userid);
			
			InterMemberDAO mdao = new MemberDAO();
			
			int n = mdao.pwdUpdate(paraMap);
			
			request.setAttribute("n", n);
			
		}

		request.setAttribute("userid", userid);
		
		request.setAttribute("method", method);
		
		// super.setRedirect(false);

		super.setViewPage("/WEB-INF/view/login/pwdUpdateEnd.jsp");
		
	}

}
