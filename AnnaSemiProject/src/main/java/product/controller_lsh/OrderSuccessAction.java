package product.controller_lsh;

import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import member.model.MemberVO;
import product.model_lsh.InterProductDAO;
import product.model_lsh.OrderVO;
import product.model_lsh.ProductDAO;

public class OrderSuccessAction extends AbstractController {
	
	// === 전표(주문코드)를 생성해주는 메소드 생성하기 === //
	private String getOdrcode() throws SQLException {
			
		// 전표(주문코드) 형식 : s+날짜+sequence ==> s20220411-1
		
		// 날짜 생성
		Date now = new Date();
		SimpleDateFormat smdatefm = new SimpleDateFormat("yyyyMMdd"); 
		String today = smdatefm.format(now);
		
		InterProductDAO pdao = new ProductDAO();
		
		int seq = pdao.getSeq_ordernum();
		// pdao.getSeq_ordernum(); 는 시퀀스 seq_ordernum 값을 채번해오는 것.
		
		return "s"+today+"-"+seq;
		
	}// end of private String getOdrcode()---------------

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		// 주문정보
		String orderedname = request.getParameter("orderedname");
		String homenum1 = request.getParameter("homenum1"); // homenum 은 null 일 수 있음
		String homenum2 = request.getParameter("homenum2");
		String homenum3 = request.getParameter("homenum3");
		String hp1 = request.getParameter("hp1");
		String hp2 = request.getParameter("hp2");
		String hp3 = request.getParameter("hp3");
		
		System.out.println("~~~ 확인용 orderedname =>" + orderedname);
		System.out.println("~~~ 확인용 homenum1 =>" + homenum1);
		System.out.println("~~~ 확인용 homenum2 =>" + homenum2);
		System.out.println("~~~ 확인용 homenum3 =>" + homenum3);
		System.out.println("~~~ 확인용 hp1 =>" + hp1);
		System.out.println("~~~ 확인용 hp2 =>" + hp2);
		
		// 배송정보
		String receivedname = request.getParameter("receivedname");
		String postcode = request.getParameter("postcode");
		String address = request.getParameter("address");
		String detailAddress = request.getParameter("detailAddress");
		String D_homenum1 = request.getParameter("D_homenum1"); // D_homenum 은 null 일 수 있음
		String D_homenum2 = request.getParameter("D_homenum2");
		String D_homenum3 = request.getParameter("D_homenum3");
		String D_hp1 = request.getParameter("D_hp1");
		String D_hp2 = request.getParameter("D_hp2");
		String D_hp3 = request.getParameter("D_hp3");
		String deliveryMsg = request.getParameter("deliveryMsg");
		
		System.out.println("~~~ 확인용 receivedname =>" + receivedname);
		System.out.println("~~~ 확인용 postcode =>" + postcode);
		System.out.println("~~~ 확인용 address =>" + address);
		System.out.println("~~~ 확인용 detailAddress =>" + detailAddress);
		System.out.println("~~~ 확인용 deliveryMsg =>" + deliveryMsg);
		// DB 에 필요한 정보
		
		String userid = request.getParameter("userid");
		String pnumjoin = request.getParameter("pnumjoin");
		String oqtyjoin = request.getParameter("oqtyjoin");
		String cartnojoin = request.getParameter("cartnojoin");
		String totalPricejoin = request.getParameter("totalPricejoin");
		
		String sumtotalPrice = request.getParameter("sumtotalPrice");
		String sumtotalPoint = request.getParameter("sumtotalPoint");

		System.out.println("~~~ 확인용 userid =>" + userid);
		System.out.println("~~~ 확인용 pnumjoin =>" + pnumjoin);
		System.out.println("~~~ 확인용 oqtyjoin =>" + oqtyjoin);
		System.out.println("~~~ 확인용 cartnojoin =>" + cartnojoin);
		System.out.println("~~~ 확인용 totalPricejoin =>" + totalPricejoin);
		
		System.out.println("~~~ 확인용 sumtotalPrice =>" + sumtotalPrice);
		System.out.println("~~~ 확인용 sumtotalPoint =>" + sumtotalPoint);
		
		// ===== Transaction 처리하기 ===== // 
	    // 1. 주문 테이블에 입력되어야할 주문전표를 채번(select)하기 
        // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
	    // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
        // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리) 
        
		// 5. 장바구니 테이블에서 cartnojoin 값에 해당하는 행들을 삭제(delete OR update)하기(수동커밋처리)
		// >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. << 
        
		// 6. 회원 테이블에서 로그인한 사용자의 coin 액을 sumtotalPrice 만큼 감하고, point 를 sumtotalPoint 만큼 더하기(update)(수동커밋처리) 
	    // 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
	    // 8. **** SQL 장애 발생시 rollback 하기(rollback) **** 
	
	    // === Transaction 처리가 성공시 세션에 저장되어져 있는 loginuser 정보를 새로이 갱신하기 ===
	    // === 주문이 완료되었을시 주문이 완료되었다라는 email 보내주기  === //

		InterProductDAO pdao = new ProductDAO();
		
		Map<String, Object> paraMap = new HashMap<>();
		
		// ====== 주문 테이블에 insert ====== //
		// 1. 전표(주문코드)를 가져오기
		String odrcode = getOdrcode();
		paraMap.put("odrcode", odrcode);
		
		// 2. 회원아이디
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		paraMap.put("userid", loginuser.getUserid());
		
		// 3. 주문총액 및 주문총포인트
		paraMap.put("sumtotalPrice", sumtotalPrice);
		paraMap.put("sumtotalPoint", sumtotalPoint);
		
		// 4. 받으시는 분 이름
		paraMap.put("receivedname", receivedname);
		
		// 5. 배송주소의 우편번호
		paraMap.put("postcode", postcode);
		
		// 6. 배송주소의 배송지주소(기본주소+상세주소)
		paraMap.put("address", address +","+ detailAddress);	
		
		// ====== 주문상세 테이블에 insert ====== //
		// 1. 전표(주문코드)를 가져오기는 위에서 만들어서 맵에 넣어둠.
		// 2. 제품번호
		String[] pnumArr = pnumjoin.split(",");  // 장바구니에서 여러개 제품을 주문한 경우    ex) "5,3,60"  ==> ["5","3","60"] 
		                                         // 장바구니에서 제품 1개만 주문한 경우      ex) "5"       ==> ["5"]
		                                         // 특정제품을 바로주문하기를 한 경우        ex) "60"      ==> ["60"] 

		// 3. 주문량
		String[] oqtyArr = oqtyjoin.split(",");
		
		// 4. 주문가격
		String[] totalPriceArr = totalPricejoin.split(",");
		
		paraMap.put("pnumArr", pnumArr);
		paraMap.put("oqtyArr", oqtyArr);
		paraMap.put("totalPriceArr", totalPriceArr);
		
		// ====== 제품 테이블 update 하기 ======= //
		// 1. 제품 테이블의 잔고량 컬럼의 값은 주문량 만큼 감해야 하는데 이미 위에서 주문량을 구해서 맵에 넣어둠.
		
		
		// ====== 장바구니 테이블에서 delete 하기 ====== //
        // 1. 장바구니 번호
        paraMap.put("cartnojoin", cartnojoin);  // 장바구니에서 여러개 제품을 주문한 경우    ex) "6,3,1"
                                             	// 장바구니에서 제품 1개만 주문한 경우      ex) "6"
                                              	// 특정제품을 바로주문하기를 한 경우        ex) null 
        // 특정제품을 바로주문하기를 한 경우라면 cartnojoin 의 값은 null 이다.
		
	      
		
		// ====== 회원 테이블에서 로그인한 사용자의 coin 금액과 point 를 update 하기 ====== //
		// 1. 로그인한 사용자는 이미 위에서 맵에 넣어둠.
		// 2. coin 금액과 point 를 update 하기 위한 것은 이미 위에서 sumtotalPrice 와 sumtotalPoint 을 맵에 넣어둠.
		
		// **** Transaction 처리를 해주는 메소드 호출하기 **** //
		int isSuccess = pdao.orderAdd(paraMap); 
		
		
		
		
		
		// 주문 번호로 주문 상세 정보 알아오기
	//	InterProductDAO pdao = new ProductDAO();
	
		OrderVO ovo = pdao.selectRecentOrder(userid);
		
		request.setAttribute("ovo", ovo);
	
	//	super.setRedirect(false);
		super.setViewPage("/WEB-INF/product_lsh/orderSuccess.jsp");
	}

}
