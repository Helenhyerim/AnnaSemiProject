package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class IndexController extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// serRedirect 값이 default 로 false 이고, false 는 forward 한다는 뜻이다.
		super.setViewPage("/WEB-INF/view/common/index.jsp");
		
	}

}
