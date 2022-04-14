package product.controller_YHL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class PayInfoDBAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 결제 되었으므로 db 를 다룬다.
		System.out.println("결제 후 db 다루기");

	}

}
