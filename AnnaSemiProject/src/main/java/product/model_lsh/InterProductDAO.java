package product.model_lsh;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {

	// 임성희

	// 상품 찜하기 전에 이미 찜한 상품인지 중복 체크하기
	boolean wishDuplicateCheck(Map<String, String> paraMap) throws SQLException;
	
	// 상품 찜하기
	int addWishProduct(Map<String, String> paraMap) throws SQLException;
	
	// 상품 정보 조회하기
	ProductVO productInfo(String productnum) throws SQLException;
	
	// 상품 이미지 조회하기
	List<ProductImageVO> productImageSelectAll(String productnum) throws SQLException;
	
	// 상품 장바구니에 추가하기 전에 이미 추가한 상품인지 중복 체크하기
	boolean cartDuplicateCheck(Map<String, String> paraMap) throws SQLException;
	
	// 상품 장바구니에 추가하기
	int addCartProduct(Map<String, String> paraMap) throws SQLException;
	
	// tbl_category 테이블에서 카테고리 대분류 번호(cnum), 카테고리코드(code), 카테고리명(cname)을 조회해오기 
	// VO 를 사용하지 않고 Map 으로 처리해보겠습니다.
	List<HashMap<String, String>> getCategoryList() throws SQLException;
	
	// 상품 리뷰 알아오기
	List<PurchaseReviewVO> reviewInfo(String productnum) throws SQLException;
	
	// 사용자 아이디로 최근 주문 번호 알아오기
	String selectRecentOrdernum(String ordernum) throws SQLException;
	
	// 주문번호로 주문 정보 알아오기(orderDetail)
	List<OrderVO> selectOrderInfo(String ordernum) throws SQLException;
	
	// 주문번호로 해당 주문 취소상태로 변경하기(update)
	int cancelOrder(String ordernum) throws SQLException;	
	
	// 페이징 처리가 되어진 모든 리뷰 보여주기
	List<PurchaseReviewVO> selectPagingReview(Map<String, String> paraMap) throws SQLException;
	
	// 구매 이력 조회
	boolean isPurchaseCheck(Map<String, String> paraMap) throws SQLException;
	
	// 특정 상품 리뷰 작성 이력 조회
	boolean isWriteReviewCheck(Map<String, String> paraMap) throws SQLException;
	
	// 특정 상품 리뷰에 대한 총페이지 알아오기
	int getReviewTotalPage(Map<String, String> paraMap) throws SQLException;

	// 리뷰 등록하기(insert)
	int insertReview(Map<String, String> paraMap) throws SQLException;
	
	// tbl_product_option 테이블에서 optionnum, fk_productnum, optionname을 조회해오기
	// VO를 사용하지 않고 Map으로 처리해보겠습니다.
	List<HashMap<String, String>> getOptionList(String productnum) throws SQLException;
	
	// optionnum으로 optionname 알아오기
	List<String> selectOptionName(List<String> optionnumList) throws SQLException;
	
	
	
	// 유혜림
	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리가 되어진 모든 회원 또는 검색한 회원 목록 보여주기
	List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException;

	// 한 상품 클릭시 productnum 을 받아서 해당 상품 디테일을 보여주기
	ProductVO getProductDetail(String productnum) throws SQLException;

	// userid 를 받아서 장바구니에 있는 상품 보여주기
	List<ProductVO> getCartItemsByUserid(String userid) throws SQLException;

	// 장바구니 페이지에서 넘어온 cartno 로 주문페이지에 보여줄 아이템 조회해오기
	ProductVO getOrderItems(String cartno) throws SQLException;

	// 주문한 상품에 대한 총 주문금액과 총포인트 알아오기
	Map<String, Integer> getTotalPricePoint(String cartno) throws SQLException;

	// 주문번호(시퀀스 seq_ordernum 값)을 채번해오는 것이다
	int getSeq_ordernum() throws SQLException;
	
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
	int orderAdd(Map<String, Object> paraMap) throws SQLException;

	// 장바구니 테이블에서 특정제품을 수량을 변경하기
	int updateCart(Map<String, String> paraMap) throws SQLException;

	// index 페이지에서 보여줄 BEST 상품 select 해오기
	List<ProductVO> selectBySpecName(Map<String, String> paraMap) throws SQLException;

	

	

	

	

	

	
	



	

	

	

	

	

	

	

	

	

	

	

}
