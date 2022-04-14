package product.controller_YHL;

import java.util.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.*;

import common.controller.AbstractController;
import myshop.model.*;
import product.model_lsh.InterProductDAO;
import product.model_lsh.ProductDAO;
import product.model_lsh.ProductVO;

public class ShowIndexProductJSONAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		String snum = request.getParameter("snum");	// 2
		String start = request.getParameter("start");
		String len = request.getParameter("len");
	/*
	        맨 처음에는 sname("HIT")상품을  start("1") 부터 len("8")개를 보여준다.
	        더보기... 버튼을 클릭하면  sname("HIT")상품을  start("9") 부터 len("8")개를 보여준다.
	        또  더보기... 버튼을 클릭하면  sname("HIT")상품을  start("17") 부터 len("8")개를 보여준다.      
	*/
		InterProductDAO pdao = new ProductDAO();
		
		Map<String, String> paraMap = new HashMap<>();
		paraMap.put("snum",snum);	// 2
		paraMap.put("start",start); // start "1"  "9"  "17"  "25"  "33"
		
		String end = String.valueOf( Integer.parseInt(start) + Integer.parseInt(len) -1 );
									// end = start + len -1;
									// end   "8"  "16"  "24"  "32"  "40"
		paraMap.put("end", end);
		
		List<ProductVO> prodList = pdao.selectBySpecName(paraMap);
		
		JSONArray jsonArr = new JSONArray();// org.json 으로 import
		
		if(prodList.size() > 0) {
			
			for(ProductVO pvo : prodList) {
				
				JSONObject jsonObj = new JSONObject(); // {} {} {} {} {} {} {} {} -- 8개 ...
													   // {} {} {} {} 
				
				jsonObj.put("productnum", pvo.getProductnum());
				jsonObj.put("productname", pvo.getProductname());
				jsonObj.put("productimage1", pvo.getProductimage1());
				jsonObj.put("productprice", pvo.getProductprice());
				jsonObj.put("point", pvo.getPoint());
				
	            
	            // jsonObj ==> {"pnum":1, "pname":"스마트TV", "code":"100000", "pcompany":"삼성",....... "pinputdate":"2021-04-23", "discoutPercent":15} 
	            // jsonObj ==> {"pnum":2, "pname":"노트북", "code":"100000", "pcompany":"엘지",....... "pinputdate":"2021-04-23", "discoutPercent":10}
	            
	            jsonArr.put(jsonObj);
	            /*
	               [ {"pnum":1, "pname":"스마트TV", "code":"100000", "pcompany":"삼성",....... "pinputdate":"2021-04-23", "discoutPercent":15} 
	                ,{"pnum":2, "pname":"노트북", "code":"100000", "pcompany":"엘지",....... "pinputdate":"2021-04-23", "discoutPercent":10} 
	                ,{....}
	                ,{....}
	                , .....
	                ,{....} 
	               ] 
	            */
				
			}// end of for ------
			
			String json = jsonArr.toString(); // 문자열로 변환
			
			System.out.println("~~~ 확인용 json =>" + json);
			/* ~~~ 확인용 json =>
			[
				{"pnum":36,"code":"100000","discountPercent":17,"pname":"노트북30","pcompany":"삼성전자","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"59.jpg","pqty":100,"pimage2":"60.jpg","pcontent":"30번 노트북","price":1200000,"sname":"HIT"}
				,{"pnum":35,"code":"100000","discountPercent":17,"pname":"노트북29","pcompany":"레노버","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"57.jpg","pqty":100,"pimage2":"58.jpg","pcontent":"29번 노트북","price":1200000,"sname":"HIT"}
				,{"pnum":34,"code":"100000","discountPercent":17,"pname":"노트북28","pcompany":"아수스","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"55.jpg","pqty":100,"pimage2":"56.jpg","pcontent":"28번 노트북","price":1200000,"sname":"HIT"}
				,{"pnum":33,"code":"100000","discountPercent":17,"pname":"노트북27","pcompany":"애플","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"53.jpg","pqty":100,"pimage2":"54.jpg","pcontent":"27번 노트북","price":1200000,"sname":"HIT"}
				,{"pnum":32,"code":"100000","discountPercent":17,"pname":"노트북26","pcompany":"MSI","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"51.jpg","pqty":100,"pimage2":"52.jpg","pcontent":"26번 노트북","price":1200000,"sname":"HIT"}
				,{"pnum":31,"code":"100000","discountPercent":17,"pname":"노트북25","pcompany":"삼성전자","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"49.jpg","pqty":100,"pimage2":"50.jpg","pcontent":"25번 노트북","price":1200000,"sname":"HIT"}
				,{"pnum":30,"code":"100000","discountPercent":17,"pname":"노트북24","pcompany":"한성컴퓨터","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"47.jpg","pqty":100,"pimage2":"48.jpg","pcontent":"24번 노트북","price":1200000,"sname":"HIT"}
				,{"pnum":29,"code":"100000","discountPercent":17,"pname":"노트북23","pcompany":"DELL","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"45.jpg","pqty":100,"pimage2":"46.jpg","pcontent":"23번 노트북","price":1200000,"sname":"HIT"}
			]
			*/
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");

		}// end of if --------------
		else {
			// DB 에서 조회된 것이 없다면
			
			String json = jsonArr.toString(); // 문자열로 변환
		// *** 만약에 select 되어진 정보가 없다면 [] 로 나오므로 null 이 아닌 요소가 없는 빈배열이다. 	
		//	System.out.println("~~~ 확인용 json =>" + json);
		// ~~~ 확인용 json =>[]
			
			request.setAttribute("json", json);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/jsonview.jsp");
		}
	}

}
