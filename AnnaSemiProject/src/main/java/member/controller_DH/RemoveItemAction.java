package member.controller_DH;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model_lsh.*;

public class RemoveItemAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
			
		String method = request.getMethod();
		String message = "";
		String loc = "";
		
		if(!"POST".equalsIgnoreCase(method)) {
			// POST 방식이 아닐경우
			message = "잘못된 경로입니다 로그인을 먼저 해주세요";
			loc = request.getContextPath() + "/login/login.an";
			
			request.setAttribute("message", message);
			request.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
		}
		else {
			// "POST"방식일 경우
			
			String productnum = request.getParameter("productnum");
			String userid = request.getParameter("userid");
			
			HttpSession session = request.getSession();
			MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
			
			
			if(loginuser.getUserid().equals(userid)) {
				InterProductDAO pdao = new ProductDAO();
				
				Map<String, String> paraMap = new HashMap<>();
				
				paraMap.put("productnum", productnum);
				paraMap.put("userid", userid);
				
				int n = pdao.removeWishProduct_DH(paraMap);
				
				JSONObject jsobj = new JSONObject();
				jsobj.put("n", n);
				
				String json = jsobj.toString();
				
				request.setAttribute("json", json);
				
				super.setRedirect(false);
				super.setViewPage("/WEB-INF/jsonview.jsp");
			}
			
			
		
			
			
		}
		

	}

}
