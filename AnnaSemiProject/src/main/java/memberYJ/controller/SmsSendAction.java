package memberYJ.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import net.nurigo.java_sdk.api.Message;

public class SmsSendAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// >> SMS 발송 << 
		// HashMap 에 받는사람번호, 보내는사람번호, 문자내용 등을 저장한 뒤 Message 클래스 객체의 send 메소드를 이용해 문자를 보냅니다.
		
		// String api_key = "발급받은 본인의 API Key";  // 발급받은 본인 API Key
		   String api_key = "NCSUWHU5UV5FIGXI";      // 꺼임
		
		// String api_secret = "발급받은 본인의 API Secret";  // 발급받은 본인 API Secret  
		   String api_secret = "EG0UICYYVP09BPW2ZHLRCO7TBC1IWHEK"; // 꺼임
		   
		   Message coolsms = new Message(api_key, api_secret);
		
		   String mobile = request.getParameter("mobile");
		   String smsContent = request.getParameter("smsContent");
		   String datetime = request.getParameter("datetime");
		   
		   HashMap<String, String> paraMap = new HashMap<>();
		   paraMap.put("to", mobile);  // 수신번호 
		   paraMap.put("from", "01026435268");  // 발신번호 
		   paraMap.put("type", "SMS"); // Message type ( SMS(단문), LMS(장문), MMS, ATA )
		   paraMap.put("text", smsContent);  // 문자내용 
		   
		   if(datetime != null) {
			   paraMap.put("datetime", datetime);          
		   }
		   
		   paraMap.put("app_version", "JAVA SDK v2.2"); // application name and version		
		
		   JSONObject jsonObj = (JSONObject) coolsms.send(paraMap);
	
		   String json = jsonObj.toString();
		   
		   request.setAttribute("json", json);
		   
		// super.setRedirect(false);
		   super.setViewPage("/WEB-INF/jsonview.jsp");
		   
	}

}
