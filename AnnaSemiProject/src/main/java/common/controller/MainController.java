package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class MainController extends AbstractController {

	@Override
	public String toString() {
		return ">>> 확인용 MainController 클래스의 인스턴스 메소드인 toString() 호출함 <<< ";
	}
	
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		/*
			super.setRedirect(true);
			this.setRedirect(true);
			setRedirect(true);
		*/
		super.setRedirect(true);
		super.setViewPage("index.an");  //   /MyMVC/index.up 페이지로 이동한다.
		
	}

}
