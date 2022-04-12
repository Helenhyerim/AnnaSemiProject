package member.controller_DH;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.*;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model_lsh.*;

public class MyPageWishListJSONAction extends AbstractController {
	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		HttpSession session = request.getSession(); 
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");// 로그인 된 유저 가져오기
		
		String userid = loginuser.getUserid(); // 로그인 된 유저의 아이디 가져오기
		String start = request.getParameter("start");	//
		String len = request.getParameter("len");		// 나는 위시리스트를 한번에 4개씩 보여줄 예정이다.
		
		InterProductDAO pdao = new ProductDAO(); // 객체생성
		
		Map<String,String> paraMap = new HashMap<>();
		
		paraMap.put("start", start); // start "1"  "5"  "9"  "13"  "17"
		paraMap.put("userid", userid);
		
		String end = String.valueOf( (Integer.parseInt(start) + Integer.parseInt(len) - 1) );
									 // end => start + len - 1;  
									 // end "4"  "8"  "12"  "16"  "20"
		
		paraMap.put("end", end);
	
		List<ProductVO> productList = pdao.selectByWishList(paraMap);
		
		JSONArray jsonArr = new JSONArray(); // []
		
		if( productList.size() > 0) {
			
			for(ProductVO pvo : productList) {
				
				JSONObject jsonObj = new JSONObject(); // {} {} {} {} {} {} {} {}
													   // {} {} {} {}
				jsonObj.put("productnum", pvo.getProductnum());
				jsonObj.put("categorynum", pvo.getCategorynum());
				jsonObj.put("productname", pvo.getProductname());
				jsonObj.put("productimage1", pvo.getProductimage1());
				jsonObj.put("productqty", pvo.getProductqty());
				jsonObj.put("productprice", pvo.getProductprice());
				jsonObj.put("fk_specnum", pvo.getFk_specnum());
				jsonObj.put("productcontent", pvo.getProductcontent());
				jsonObj.put("point", pvo.getPoint());
				
				// jsonObj ==> {"pnum":1, "pname":"스마트TV", "code":"100000", "pcompany":"삼성",....... "pinputdate":"2021-04-23", "discoutPercent": 15} 
	            // jsonObj ==> {"pnum":2, "pname":"노트북", "code":"100000", "pcompany":"엘지",....... "pinputdate":"2021-04-23", "discoutPercent": 10}
				jsonArr.put(jsonObj);
			
				
			}// end of for -------------------------
			
			String json = jsonArr.toString();// 문자열로 변환
			
			// System.out.println("~~~ 확인용 json => " + json);
		
			request.setAttribute("json", json);
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}//end of if( prodList.size() > 0)-----------------------------------
		
		else {
			// DB에서 조회된 것이 없다라면
			
			String json = jsonArr.toString();// 문자열로 변환
			
			
			// *** 만약에 select 되어진 정보가 없다라면 [] 로 나오므로 null 이 아닌 요소가 없는 빈 배열이다.
			//System.out.println("~~~ 확인용 json => " + json);
			// ~~~ 확인용 json => []
			
			request.setAttribute("json", json);
			
			// super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
			
		}
	}

}

	






	