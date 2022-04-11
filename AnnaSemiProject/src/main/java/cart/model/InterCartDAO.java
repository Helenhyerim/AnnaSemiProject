package cart.model;

import java.sql.SQLException;

public interface InterCartDAO {
	// 장바구니에서 (선택)상품을 삭제하기
	int deleteCartItems(String[] cartno_list) throws SQLException;

}
