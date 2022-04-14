package product.controller_lsh;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;

public class InsertReviewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		
		// 로그인 유무 검사하기
		boolean isLogin = super.checkLogin(request);
		
		if(isLogin) {
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) { // POST 방식으로 접근한 경우
				
				HttpSession session = request.getSession();
				String goBackURL = (String)session.getAttribute("goBackURL");
				
				String userid = request.getParameter("userid");
				String productnum = request.getParameter("productnum");
				
				// !!! 크로스 사이트 스크립트 공격에 대응하는 안전한 코드(시큐어코드) 작성하기 !!! //
				String reviewTitle = request.getParameter("reviewTitle");
				String reviewContents = request.getParameter("reviewContents");
				
				reviewTitle = reviewTitle.replaceAll("<", "&lt;");
				reviewTitle = reviewTitle.replaceAll(">", "&gt;");
				reviewTitle = reviewTitle.replaceAll("\r\n", "<br>");
				reviewContents = reviewContents.replaceAll("<", "&lt;");
				reviewContents = reviewContents.replaceAll(">", "&gt;");
				reviewContents = reviewContents.replaceAll("\r\n", "<br>");
				
				Map<String, String> paraMap = new HashMap<>();
				
				paraMap.put("userid", userid);
				paraMap.put("productnum", productnum);
				paraMap.put("reviewTitle", reviewTitle);
				paraMap.put("reviewContents", reviewContents);
				
				InterProductDAO pdao = new ProductDAO();
				
				int n = pdao.insertReview(paraMap);
				
				if(n == 1) {
					request.setAttribute("message", "리뷰가 등록되었습니다.");
					request.setAttribute("loc", request.getContextPath() + goBackURL);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
				else {
					request.setAttribute("message", "리뷰 등록에 실패했습니다.");
					request.setAttribute("loc", request.getContextPath() + goBackURL);
					
				//	super.setRedirect(false);
					super.setViewPage("/WEB-INF/msg.jsp");
				}
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
