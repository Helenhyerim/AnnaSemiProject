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
	
	// 카테고리 클릭시 카테고리 전체상품 보여주기
	List<ProductVO> productSelectAll() throws SQLException;

	

}
