package product.controller_lsh;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import common.controller.AbstractController;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;

public class CartDuplicateCheckAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		// 파라미터 받아오기
		String userid = request.getParameter("userid");
		String productnum = request.getParameter("productnum");
		
		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("userid", userid);
		paraMap.put("productnum", productnum);
		
		InterProductDAO pdao = new ProductDAO();
		boolean isExist = pdao.cartDuplicateCheck(paraMap);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isExist", isExist);
		
		String json = jsonObj.toString();
		
		request.setAttribute("json", json);
		
		super.setViewPage("/WEB-INF/jsonview.jsp");
	}

}
