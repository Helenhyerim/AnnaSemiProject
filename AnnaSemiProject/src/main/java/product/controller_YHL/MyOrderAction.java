package product.controller_YHL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class MyOrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		// form 태그로 넘긴 값
		// 사용자 아이디 : userid
		// 제품 코드 : productnum
		// 상품명 : productname
		// 옵션명(리스트) : opList
		// 옵션별 수량(리스트) : qtyList -> 총 수량은 리스트에 저장된 값 모두 더하기
		// 상품 가격(req, 고정값) : productprice -> 구매는 회원만 이용 가능한 메뉴로 할인가 적용
		// 상품 가격(sel, 고정값) : 선택 옵션은 항목이 하나라서 (상품가격(req) * 총수량) + 상품 가격(sel)로 구하기
		
		// 선택 옵션이 선택된 경우 opList와 qtyList 마지막 인덱스에 각각 '선물용 포장'과 '1'이 넣어지도록 함.
		
		//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/view/product_YHL/order_YHL.jsp");

	}

}
