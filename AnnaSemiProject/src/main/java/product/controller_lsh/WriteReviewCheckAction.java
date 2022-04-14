package product.controller_lsh;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;

public class WriteReviewCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 로그인 유무 검사하기
		boolean isLogin = super.checkLogin(request);
		
		if(isLogin) { // 로그인을 한 경우
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) {
				
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
				
				String userid = loginuser.getUserid();
				String productnum = request.getParameter("productnum");
				
				Map<String, String> paraMap = new HashMap<>();
				
				paraMap.put("userid", userid);
				paraMap.put("productnum", productnum);
				
				InterProductDAO pdao = new ProductDAO();
				
				// 구매 이력 조회
				boolean isPurchase = pdao.isPurchaseCheck(paraMap);
				
				// 특정 상품 리뷰 작성 이력 조회
				boolean isWriteReview = pdao.isWriteReviewCheck(paraMap);
				
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("isPurchase", isPurchase);
				jsonObj.put("isWriteReview", isWriteReview);
				
				String json = jsonObj.toString();
				
				request.setAttribute("json", json);
				
				super.setViewPage("/WEB-INF/jsonview.jsp");
			}
			else {
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
