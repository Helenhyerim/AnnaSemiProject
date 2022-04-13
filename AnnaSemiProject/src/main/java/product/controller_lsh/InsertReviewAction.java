package product.controller_lsh;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;

public class InsertReviewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HttpSession session = request.getSession();
		String goBackURL = (String)session.getAttribute("goBackURL");
		
		System.out.println(goBackURL);
		
		String userid = request.getParameter("userid");
		String productnum = request.getParameter("productnum");
		String reviewTitle = request.getParameter("reviewTitle");
		String reviewContents = request.getParameter("reviewContents");

		Map<String, String> paraMap = new HashMap<>();
		
		paraMap.put("userid", userid);
		paraMap.put("productnum", productnum);
		paraMap.put("reviewTitle", reviewTitle);
		paraMap.put("reviewContents", reviewContents);
		
		InterProductDAO pdao = new ProductDAO();
		
		int n = pdao.insertReview(paraMap);

		super.setRedirect(true);
		super.setViewPage(request.getContextPath() + goBackURL);
	}

}
