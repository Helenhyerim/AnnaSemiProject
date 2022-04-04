package product.controller_lsh;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;

public class WishDuplicateCheckAction extends AbstractController {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		// 제품코드와 사용자 아이디를 받아와서 DB 연동해주어야 함. (MemberEditEndAction.java 참조)
		// 찜할 상품 중복 체크
		
		// 제품코드와 로그인한 사용자 아이디 받아오기
		String productnum = request.getParameter("productnum");
		String userid = request.getParameter("userid");
		
	//	String productnum = "8";
	//	String userid = "simyj";
		
	//	System.out.println("확인용 productnum, userid => " + productnum + ", " + userid);
		
		// 찜할 상품 중복 체크
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("productnum", productnum);	// 정수 변환 해줘야 함(productDAO)
		paraMap.put("userid", userid);
		
		InterProductDAO pdao = new ProductDAO();
		boolean isExist = pdao.wishDuplicateCheck(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isExist", isExist);
		jsonObj.put("productnum", productnum);
		jsonObj.put("userid", userid);
		
		String json = jsonObj.toString();
		
		request.setAttribute("json", json);
		
		super.setViewPage("/WEB-INF/jsonview.jsp");
	}
}
