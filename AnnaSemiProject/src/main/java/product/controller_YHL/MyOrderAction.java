package product.controller_YHL;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class MyOrderAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	
		// 넘겨줄 값
		// 사용자 아이디 : userid[sessionScope.loginuser.userid] -> 메인브랜치에서 개인브랜치로 머지안해서 임시값으로 'hongkd'을 부여함
		// 제품 코드 : productnum[requestScope.pvo.productnum]
		// 상품명 : productname[requestScope.pvo.productname]
		// 옵션명(리스트) : opList
		// 옵션별 수량(리스트) : qtyList -> 총 수량은 리스트에 저장된 값 모두 더하기
		// 상품 가격(req, 고정값) : productprice[requestScope.pvo.saleprice] -> 구매는 회원만 이용 가능한 메뉴로 saleprice를 넘겨준다
		// 상품 가격(sel, 고정값) : 3000 -> selOption은 항목이 하나라서 (상품가격(req) * 총수량) + a로 구해도 상관없음
		
		
		
		//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/view/product_YHL/order_YHL.jsp");

	}

}
