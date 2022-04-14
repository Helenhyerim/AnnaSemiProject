package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;



public class IndexController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		InterProductDAO pdao = new ProductDAO();
		int totalBESTCount = pdao.totalPspecCount("1");
		
		// serRedirect 값이 default 로 false 이고, false 는 forward 한다는 뜻이다.
		super.setViewPage("/WEB-INF/view/common/index.jsp");
		
	}

}
