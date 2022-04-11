package product.controller_lsh;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;

public class AddCartAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 로그인 유무 검사하기
		boolean isLogin = super.checkLogin(request);
		
		if(isLogin) {
			
			String method = request.getMethod();
			
			if("POST".equalsIgnoreCase(method)) { // POST 방식으로 접근한 경우
				
				HttpSession session = request.getSession();
				MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
				
				String userid = loginuser.getUserid();
				String productnum = request.getParameter("pnum");
				String productname = request.getParameter("pname");
				String[] opList = request.getParameterValues("opList[]");
				String[] qtyList = request.getParameterValues("qtyList[]");
				String productprice = request.getParameter("pprice");
				
				int orderqty = 0;
				
				for(String qty : qtyList) {
					orderqty = orderqty + Integer.parseInt(qty);
				}
				
				Map<String, String> paraMap = new HashMap<>();
				
				paraMap.put("userid", userid);
				paraMap.put("productnum", productnum);
				paraMap.put("orderqty", String.valueOf(orderqty));
				
				try {
					InterProductDAO pdao = new ProductDAO();
				
					int n = pdao.addCartProduct(paraMap);
				
					if(n == 1) {
						
						request.setAttribute("userid", userid);
						request.setAttribute("productnum", productnum);
						request.setAttribute("productname", productname);
						request.setAttribute("opList", opList);
						request.setAttribute("qtyList", qtyList);
						request.setAttribute("productprice", productprice);
						
					//	super.setRedirect(false);
						super.setViewPage("/WEB-INF/product_lsh/addCart.jsp");	
					}
				} catch(SQLException e) {
					e.printStackTrace();
					
					String message = "SQL구문 에러발생";
					String loc = request.getContextPath() + "/product_lsh/productDetail.an?productnum=" + productnum;
					
					request.setAttribute("message", message);
					request.setAttribute("loc", loc);
					
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
