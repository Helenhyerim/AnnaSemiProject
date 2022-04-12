package product.controller_lsh;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;

public class OrderCancelAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그인 유무 검사하기
		boolean isLogin = super.checkLogin(request);
		
		if(isLogin) {
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) { // POST 방식으로 접근한 경우
				
				String ordernum = request.getParameter("ordernum");
				
				InterProductDAO pdao = new ProductDAO();
				
				// 주문번호로 해당 주문을 취소하기(update)
				int n = pdao.cancelOrder(ordernum);
				
				boolean isCancel = false;
				if(n == 1) {
					isCancel = true;
				}
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("isCancel", isCancel);
				
				String json = jsonObj.toString();
				
				request.setAttribute("json", json);
				
				super.setViewPage("/WEB-INF/jsonview.jsp");
				
			}
			else { // GET 방식으로 접근한 경우
				String message = "잘못된 접근 경로입니다.";
	            String loc = "javascript:history.back()";
	               
	            request.setAttribute("message", message);
	            request.setAttribute("loc", loc);
	              
	        //  super.setRedirect(false);   
	            super.setViewPage("/WEB-INF/msg.jsp");
			}
		}
		else { // 로그인을 하지 않은 경우
			request.setAttribute("message", "로그인 후 이용할 수 있습니다.");
			request.setAttribute("loc", request.getContextPath() + "/login/login.an");
			
		//	super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
					
			return;
		}
		
	}

}
