package member.controller_DH;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.*;

public class LeaveAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		
		String method = request.getMethod();
		
		String message = "";
        String loc = "";
		
		if("POST".equalsIgnoreCase(method)) {
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			
			request.setAttribute("userid", userid);
			request.setAttribute("pwd", pwd);
			
			InterMemberDAO member = new MemberDAO();
			Map<String, String> paraMap = new HashMap<>();
			
			paraMap.put("userid", userid);
			paraMap.put("pwd", pwd);
			
			int n = member.leaveMember(paraMap);
			
			if(n == 1) {
				HttpSession session = request.getSession();// 세션불러오기

			    session.invalidate(); // 로그아웃처리로 세션삭제 해줌
				message = "회원탈퇴 성공";
		        loc = request.getContextPath() + "/index.an";
			}
			else {
				
				message = "회원탈퇴 실패";
		        loc = "javascript:history.back()";
		        
			}
			
		}
		else {
			message = "비정상적인 경로를 통해 들어왔습니다.";
	        loc = "javascript:history.back()";
	         
	        
		}
	
		request.setAttribute("message", message);
        request.setAttribute("loc", loc);
         
        super.setViewPage("/WEB-INF/msg.jsp");
	}

}
