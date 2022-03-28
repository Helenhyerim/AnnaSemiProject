package member.controller.DH;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;

public class EmailDuplicateCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	String method = request.getMethod(); // "GET" 또는 "POST" 
		
		if("POST".equalsIgnoreCase(method)) {
			
			String email = request.getParameter("email");
		//	System.out.println(">>> 확인용 userid => " + userid);
			
			InterMemberDAO mdao = new MemberDAO();
			boolean isExist = mdao.emailDuplicateCheck(email);
			
			JSONObject jsonObj = new JSONObject(); // {}
			jsonObj.put("isExist", isExist);       // {"isExist":true} 또는 {"isExist":false} 으로 만들어준다.
			
			String json = jsonObj.toString(); // 문자열 형태인 "{"isExist":true}" 또는 "{"isExist":false}" 으로 만들어준다.
		//	System.out.println(">>> 확인용 json => " + json);
			// >>> 확인용 json => {"isExist":false}
			// 또는
			// >>> 확인용 json => {"isExist":true}
			
			request.setAttribute("json", json);
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}// end of if------------------------------------------------------------

	}

}
