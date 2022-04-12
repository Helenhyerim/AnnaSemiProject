package cart.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class CartDAO implements InterCartDAO {
	
	private DataSource ds;	// DataSource ds는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	// 기본생성자
	public CartDAO() {
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/anna_oracle");
			
		} catch(NamingException e) {
			e.printStackTrace();
		}
	}
	
	
	// 자원반납 해주는 메소드
	private void close() {
		try {
			if(rs != null) {rs.close(); rs = null;}
			if(pstmt != null) {pstmt.close(); pstmt = null;}
			if(conn != null) {conn.close(); conn = null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}


	// 장바구니에서 (선택)상품을 삭제하기
	@Override
	public int deleteCartItems(String[] cartno_list) throws SQLException {
		int result = 0;
		
		for( String cartno : cartno_list) {
			
		
			try {
				conn = ds.getConnection();
				
				String sql = " delete from tbl_cart " + 
							 " where cartno = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, cartno);
				result = pstmt.executeUpdate(); // 계속 1이다
				
				
			} finally {
				close();
			}
		}
		return result;
	}// end of public int deleteCartItems(String[] cart_checked_list) -----------

}
