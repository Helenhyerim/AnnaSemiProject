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



	

	

	

	

	

	

	

	

	

	

	

}
