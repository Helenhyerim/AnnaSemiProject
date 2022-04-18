package memberYJ.controller;

import java.util.HashMap;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import member.controller.GoogleMail;
import member.controller.MySMTPAuthenticator;
import member.model.MemberVO;

public class EmailSendAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		JSONObject jsobj = new JSONObject();
		
		GoogleMail mail = new GoogleMail();

		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String emailContent = request.getParameter("emailContent");
		boolean sendMailSuccess = false;
		
		HashMap<String, String> paraMap = new HashMap<>();
	
	    try {
			mail.sendmail_memberOneDetail(email, name, emailContent);
				
            sendMailSuccess = true; // 메일 전송이 성공했음을 기록함.

	   } catch(Exception e) { // 메일 전송이 실패한 경우
           e.printStackTrace();
           sendMailSuccess = false; // 메일 전송이 실패했음을 기록함.
       }
		
		jsobj.put("sendMailSuccess", sendMailSuccess);  
		
		String json = jsobj.toString();
		
	    //System.out.println("~~~~ 확인용 json => " + json);
		
		request.setAttribute("json", json);
		
		// super.setRedirect(false);
		   super.setViewPage("/WEB-INF/jsonview.jsp");
	}

}
