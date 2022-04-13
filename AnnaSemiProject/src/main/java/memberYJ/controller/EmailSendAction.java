package memberYJ.controller;

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

import org.json.JSONObject;

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
		
		// 메일보내기 시작
		GoogleMail mail = new GoogleMail();
					
		String email = request.getParameter("email");
		String name = request.getParameter("name");
		String emailContent = request.getParameter("emailContent");
		String datetime = request.getParameter("datetime");
					

		mail.sendmail_memberOneDetail(email, name, emailContent);
		

		String json = jsobj.toString();
		request.setAttribute("json", json);

	}

}
