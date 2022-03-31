package product.controller_YHL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class MyOrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/view/product_YHL/order_YHL.jsp");

	}

}
