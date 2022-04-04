package member.controller_DH;

import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.InterMemberDAO;
import member.model.MemberDAO;
import member.model.MemberVO;

public class MemberEditEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String method = request.getMethod();
		
		if("GET".equalsIgnoreCase(method)) {
			// *** POST 방식으로 넘어온 것이 아니라면
			String message = "비정상적인 경로를 통해 들어왔습니다.!!";
	        String loc = "javascript:history.back()";
	         
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	         
	        super.setViewPage("/WEB-INF/msg.jsp");
		}
		else {
			// 정보수정을 클릭한 경우
			
			String userid = request.getParameter("userid");
			String pwd = request.getParameter("pwd");
			String name = request.getParameter("name");
			String email = request.getParameter("email");
			String hp1 = request.getParameter("hp1");
			String hp2 = request.getParameter("hp2");
			String hp3 = request.getParameter("hp3");
			String postcode = request.getParameter("postcode");
			String address = request.getParameter("address");
			String detailaddress = request.getParameter("detailAddress");
			String birthyyyy = request.getParameter("birthyyyy");
			String birthmm = request.getParameter("birthmm");
			String birthdd = request.getParameter("birthdd");
			String mobile = hp1 + hp2 + hp3;
			String birthday = birthyyyy+ "-" + birthmm + "-" + birthdd;
			
			int sms_status = Integer.parseInt(request.getParameter("sms_status"));
	        
	        int email_status = Integer.parseInt(request.getParameter("email_status"));
	        
			MemberVO member = new MemberVO(userid, pwd, name, email, mobile, postcode, address, detailaddress, birthday, sms_status, email_status );    
			
			InterMemberDAO mdao = new MemberDAO();
	        int n = mdao.updateMember(member);
			
			String message = "";
			
			
			if(n == 1) {
	        	
	        	// !!! session 에 저장된 loginuser를 변경된 사용자의 정보값으로 변경해주어야 한다. !! //
	        	HttpSession session = request.getSession();
	        	
	        	MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
	        	
	        	loginuser.setPwd(pwd);
	        	loginuser.setName(name);
	        	loginuser.setEmail(email);
	        	loginuser.setMobile(mobile);
	        	loginuser.setPostcode(postcode);
	        	loginuser.setAddress(address);
	        	loginuser.setDetailaddress(detailaddress);
	        	loginuser.setEmail_status(email_status);
	        	loginuser.setSms_status(sms_status);
	        	
	        	message = "회원정보 수정 성공";
	        	
	        }
	        else {
	        	message = "회원정보 수정 실패";
	        }
	        
	        String loc = "javascript:history.back()";
	        
	        request.setAttribute("message", message);
	        request.setAttribute("loc", loc);
	        
	        // super.setRedirect(false);
	        super.setViewPage("/WEB-INF/msg.jsp");
		}

	}

}
