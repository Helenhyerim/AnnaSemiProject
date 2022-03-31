package product.model_lsh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class ProductDAO implements InterProductDAO {

	private DataSource ds;	// DataSource ds는 아파치톰캣이 제공하는 DBCP(DB Connection Pool)이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	
	// 기본생성자
	public ProductDAO() {
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



	// 카테고리 클릭시 카테고리 전체상품 보여주기_유혜림
	@Override
	public List<ProductVO> productSelectAll() throws SQLException {
		List<ProductVO> imgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select productimage1 " + 
					"from tbl_product " + 
					"order by productnum ";
			
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductVO pvo = new ProductVO();
				pvo.setProductimage1(rs.getString(1));
				
				imgList.add(pvo);
			
			}// end of while(rs.next()) -------
			
			System.out.println("~~ 확인용 imgList =>" + imgList);
		} finally {
			close();
		}
		
		return imgList;
	}// end of public List<ProductDAO> productSelectAll()----------
}
