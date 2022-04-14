package product.controller_lsh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;
import product.model_lsh.ProductVO;

public class WriteReviewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그인 유무 검사하기
		boolean isLogin = super.checkLogin(request);
		
		if(isLogin) {
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) { // POST 방식으로 접근한 경우
				String userid = request.getParameter("userid");
				String productnum = request.getParameter("productnum");
				
				InterProductDAO pdao = new ProductDAO();
				
				ProductVO pvo = pdao.productInfo(productnum);
				
				request.setAttribute("userid", userid);
				request.setAttribute("pvo", pvo);
				
			//	super.setRedirect(false);
				super.setViewPage("/WEB-INF/product_lsh/writeReview.jsp");
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
