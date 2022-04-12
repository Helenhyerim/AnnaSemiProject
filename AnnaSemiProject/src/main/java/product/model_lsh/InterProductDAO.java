package product.model_lsh;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterProductDAO {

	// 임성희

	// 상품 찜하기 전에 이미 찜한 상품인지 중복 체크하기
	boolean wishDuplicateCheck(Map<String, String> paraMap) throws SQLException;
	
	// 상품 찜하기
	int addWishProduct(Map<String, String> paraMap) throws SQLException;
	
	
	
	
	
	
	
	
	
	
	
	
	// 유혜림
	
	
	
	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기
	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	// 페이징 처리가 되어진 모든 회원 또는 검색한 회원 목록 보여주기
	List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException;

	// 한 상품 클릭시 productnum 을 받아서 해당 상품 디테일을 보여주기
	ProductVO getProductDetail(String productnum) throws SQLException;

	// userid 를 받아서 장바구니에 있는 상품 보여주기
	List<Map<String, String>> getCartItemsByUserid(String userid) throws SQLException;

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	////////////////////////////////////////////////////////////////////
	// 이두현 찜목록 받아서 보여주기 위한 메소드
	List<ProductVO> selectByWishList(Map<String, String> paraMap) throws SQLException;

	// 이두현 찜목록의 페이징을 위해서 해당유저의 id값을 매개변수로 하여 찜목록의 전체 카운트를 반환받기위한 메소드
	int totalWishListCount(String userid) throws SQLException;

	// 멤버의 위시리스트에서 삭제 버튼을 눌렀을 경우 userid와 productnum을 받아와 위시리스트에서 삭제해주는 메소드
	int removeWishProduct_DH(Map<String, String> paraMap) throws SQLException;

	
	////////////////////////////////////////////////////////////////////
}
