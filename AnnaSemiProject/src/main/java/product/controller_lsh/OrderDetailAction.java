package product.controller_lsh;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import product.model_lsh.InterProductDAO;
import product.model_lsh.OrderVO;
import product.model_lsh.ProductDAO;

public class OrderDetailAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String userid = request.getParameter("userid");
		
		// 최근 주문 정보 알아오기
		InterProductDAO pdao = new ProductDAO();
	
		OrderVO ovo = pdao.selectRecentOrder(userid);
		
		request.setAttribute("ovo", ovo);
		
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/product_lsh/orderDetail.jsp");
	}

}
