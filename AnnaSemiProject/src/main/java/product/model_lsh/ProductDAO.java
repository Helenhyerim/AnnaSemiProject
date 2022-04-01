package product.model_lsh;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import member.model.MemberVO;


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



	


	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select ceil(count(*)/?) "+
						"from tbl_product ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sizePerPage") );
			
			rs = pstmt.executeQuery();
			
			// 결과는 무조건 나온다. 없으면 0 이라도.
			rs.next();
			
			totalPage = rs.getInt(1);
			
			
		} finally {
			close();
		}
		
		return totalPage;
	}// end of public int getTotalPage(Map<String, String> paraMap)


	// 페이징 처리가 되어진 모든 회원 또는 검색한 회원 목록 보여주기
	@Override
	public List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException {
		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			// rno 는 빼고 한다.
			String sql = "select productimage1, productname, productprice "+
					"from "+
					"( "+
					"    select rownum as rno, productimage1, productname, productprice "+
					"    from "+
					"    ( "+
					"    select productimage1, productname, productprice "+
					"    from tbl_product "+
					"    order by productnum "+
					"    ) V "+
					") T "+
					"where rno between ? and ? ";
			
			
			pstmt = conn.prepareStatement(sql);
			
			// '1' '10' 해도 잘 select 된다. 그러므로 setInt 혹은 setString 으로 해도 된다.
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
			pstmt.setInt(2, (currentShowPageNo * sizePerPage));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductVO pvo = new ProductVO();
				
				pvo.setProductimage1(rs.getString(1));
				pvo.setProductname(rs.getString(2));
				pvo.setProductprice(rs.getInt(3));
				
				productList.add(pvo);
			}// end of while()----------
			
		} finally {
			close();
		}
		
		return productList;
	}// end of public List<ProductVO> selectPagingProduct(Map<String, String> paraMap) 
}
