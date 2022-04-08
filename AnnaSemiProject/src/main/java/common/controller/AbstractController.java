package common.controller;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import my.util.MyUtil;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;

public abstract class AbstractController implements InterCommand {
// AbstractController 클래스는 미완성(추상) 부모클래스로 사용된다. 
	
	// 각각의 다른 페이지를 보여주는 클래스에서 execute 를 자기에 맞게 재정의 해야하기때문에 여기서는 재정의 하지 않는다.
	// 그래서 abstract 클래스로 만든다. 
	/*
	 * @Override public void execute(HttpServletRequest request, HttpServletResponse
	 * response) throws Exception { // TODO Auto-generated method stub
	 * }
	 */
	
	/*
    === 다음의 나오는 것은 우리끼리한 약속이다. ===

    	※ view 단 페이지(.jsp)로 이동시 forward 방법(dispatcher)으로 이동시키고자 한다라면 
       	   자식클래스에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 하면 되게끔 한다.
     
	    super.setRedirect(false); 
	    super.setViewPage("/WEB-INF/index.jsp");
    
    
	          ※ URL 주소를 변경하여 페이지 이동시키고자 한다라면
	          즉, sendRedirect 를 하고자 한다라면    
	          자식클래스에서는 부모클래스에서 생성해둔 메소드 호출시 아래와 같이 하면 되게끔 한다.
          
	    super.setRedirect(true);
	    super.setViewPage("registerMember.up");               
*/
	
	private boolean isRedirect = false;
	// isRedirect 변수의 값이 false 이라면 view단 페이지(.jsp)로  forward 방법(dispatcher)으로 이동시키겠다. 
	// isRedirect 변수의 값이 true 이라면 sendRedirect 로 페이지이동을 시키겠다.
	
	private String viewPage;
	// viewPage 는 isRedirect 값이 false 이라면 view단 페이지(.jsp)의 경로명 이고,
	// isRedirect 값이 true 이라면 이동해야할 페이지 URL 주소(.an) 이다.

	
	public boolean isRedirect() {
		return isRedirect;
	}

	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}

	public String getViewPage() {
		return viewPage;
	}

	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}
	
	///////////////////////////////////////////////////////////////////
		
	// *** 제품목록(Category)을 보여줄 메소드 생성하기 *** //
	// VO를 사용하지 않고 Map으로 처리해보겠습니다.
	public void getCategoryList(HttpServletRequest request) throws SQLException {
	
		InterProductDAO pdao = new ProductDAO();
		List<HashMap<String, String>> categoryList = pdao.getCategoryList();
	
		request.setAttribute("categoryList", categoryList);
	}
	
	
	// 로그인 또는 로그아웃을 하면 시작페이지로 가는 것이 아니라 방금 보았던 그 페이지로 그대로 가기 위한 것임.
	public void goBackURL(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.setAttribute("goBackURL", MyUtil.getCurrentURL(request));
	}
	
}
