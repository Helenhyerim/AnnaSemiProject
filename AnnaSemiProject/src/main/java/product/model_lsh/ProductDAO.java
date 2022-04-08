package product.model_lsh;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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



	


	// 페이징 처리를 위한 검색이 있는 또는 검색이 없는 전체회원에 대한 총페이지 알아오기_유혜림
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


	// 페이징 처리가 되어진 모든 회원 또는 검색한 회원 목록 보여주기_유혜림
	@Override
	public List<ProductVO> selectPagingProduct(Map<String, String> paraMap) throws SQLException {
		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			// rno 는 빼고 한다.
			String sql = "select productimage1, productname, productprice, productnum "+
					"from "+
					"( "+
					"    select rownum as rno, productimage1, productname, productprice, productnum "+
					"    from "+
					"    ( "+
					"    select productimage1, productname, productprice, productnum "+
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
				pvo.setProductnum(rs.getInt(4));
				
				productList.add(pvo);
			}// end of while()----------
			
		} finally {
			close();
		}
		
		return productList;
	}// end of public List<ProductVO> selectPagingProduct(Map<String, String> paraMap) 


	// 한 상품 클릭시 productnum 을 받아서 해당 상품 디테일을 보여주기_유혜림=>근데 이거 성희가 이어서 하면 좋을듯!
	public ProductVO getProductDetail(String productnum) throws SQLException {
		
		ProductVO pvo = new ProductVO();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select productimage1, productname, productnum, productprice, saleprice, productqty "
					   + "from tbl_product "
					   + "where productnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(productnum));
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			pvo.setProductimage1(rs.getString(1));
			pvo.setProductname(rs.getString(2));
			pvo.setProductnum(rs.getInt(3));
			pvo.setProductprice(rs.getInt(4));
			pvo.setSaleprice(rs.getInt(5));
			pvo.setProductqty(rs.getInt(6));
			
		} finally {
			close();
		}
	
		return pvo;
	}


	// 상품 찜하기 전에 이미 찜한 상품인지 중복 체크하기
	@Override
	public boolean wishDuplicateCheck(Map<String, String> paraMap) throws SQLException {

		boolean isExist = false;
		int productnum = Integer.parseInt(paraMap.get("productnum"));
		
		try {
			conn = ds.getConnection();
			
			String sql = "select * "
					   + "from tbl_dibs "
					   + "where fk_productnum = ? and fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productnum);
			pstmt.setString(2, paraMap.get("userid"));
			
			rs = pstmt.executeQuery();
			
			isExist = rs.next(); // 행이 있으면 true, 없으면 false
			
		} finally {
			close();
		}
		
		return isExist;
	}


	// 상품 찜하기
	@Override
	public int addWishProduct(Map<String, String> paraMap) throws SQLException {
		
		int result = 0;
		int productnum = Integer.parseInt(paraMap.get("productnum"));
		
		try {
			conn = ds.getConnection();
			
			String sql = "insert into tbl_dibs(fk_productnum, fk_userid) "
					   + "values(?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productnum);
			pstmt.setString(2, paraMap.get("userid"));
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}


	// 상품 이미지 조회하기
	@Override
	public List<ProductImageVO> productImageSelectAll(String productnum) throws SQLException {

		List<ProductImageVO> imgList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select imagefilename " +
						 "from " +
						 "( " +
						 "    select productnum, imagefilename " +
						 "    from tbl_product_imagefile I "+
						 "    JOIN tbl_product P "+
						 "    ON I.fk_productnum = P.productnum "+
						 ") V " +
						 "where productnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(productnum));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				ProductImageVO imgvo = new ProductImageVO();
				imgvo.setImagefilename(rs.getString(1));
				
				imgList.add(imgvo);
			}
			
		} finally {
			close();
		}
		
		return imgList;
	}


	// 상품정보 조회하기
	@Override
	public ProductVO productInfo(String productnum) throws SQLException {
		
		ProductVO pvo = new ProductVO();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select productimage1, productname, productnum, productprice, saleprice, productqty "
					   + "from tbl_product "
					   + "where productnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(productnum));
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			pvo.setProductimage1(rs.getString(1));
			pvo.setProductname(rs.getString(2));
			pvo.setProductnum(rs.getInt(3));
			pvo.setProductprice(rs.getInt(4));
			pvo.setSaleprice(rs.getInt(5));
			pvo.setProductqty(rs.getInt(6));
			
		} finally {
			close();
		}
	
		return pvo;
	}


	// 상품 장바구니에 추가하기 전에 이미 추가한 상품인지 중복 체크하기
	@Override
	public boolean cartDuplicateCheck(Map<String, String> paraMap) throws SQLException {

		boolean isExist = false;
		int productnum = Integer.parseInt(paraMap.get("productnum"));
		
		try {
			conn = ds.getConnection();
			
			String sql = "select * "
					   + "from tbl_cart "
					   + "where fk_productnum = ? and fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, productnum);
			pstmt.setString(2, paraMap.get("userid"));
			
			rs = pstmt.executeQuery();
			
			isExist = rs.next(); // 행이 있으면 true, 없으면 false
			
		} finally {
			close();
		}
		
		return isExist;
	}


	// 상품 장바구니에 추가하기
	@Override
	public int addCartProduct(Map<String, String> paraMap) throws SQLException {
		
		int result = 0;
		int productnum = Integer.parseInt(paraMap.get("productnum"));
		int orderqty = Integer.parseInt(paraMap.get("orderqty"));
		
		try {
			conn = ds.getConnection();
			
			String sql = "insert into tbl_cart(cartno, fk_userid, fk_productnum, orderqty) "
					   + "values(seq_cartno.nextval, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setInt(2, productnum);
			pstmt.setInt(3, orderqty);
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}

	// userid 를 받아서 장바구니에 있는 상품 보여주기_유혜림
	@Override
	public List<Map<String, String>> getCartItemsByUserid(String userid) throws SQLException {
		
		List<Map<String, String>> cartProductList = null;
		
		try {
			conn = ds.getConnection();
			
			String sql =" select FK_PRODUCTNUM, ORDERQTY "
					  + " from tbl_product "
					  + " where userid = ";
			
			
			pstmt = conn.prepareStatement(sql);
			
		} finally {
			close();
		}
		
		return cartProductList;
	} // end of public List<Map<String, String>> getCartItemsByUserid(String userid)


	// tbl_category 테이블에서 카테고리 대분류 번호(cnum), 카테고리코드(code), 카테고리명(cname)을 조회해오기 
	// VO 를 사용하지 않고 Map 으로 처리해보겠습니다.	
	@Override
	public List<HashMap<String, String>> getCategoryList() throws SQLException {
		
		List<HashMap<String, String>> categoryList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select categorynum, code, categoryname "
					   + "from tbl_category "
					   + "order by categorynum asc ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				HashMap<String, String> map = new HashMap<>();
				map.put("categorynum", rs.getString(1));
				map.put("code", rs.getString(2));
				map.put("categoryname", rs.getString(3));
				
				categoryList.add(map);
			}
			
		} finally {
			close();
		}
		
		return categoryList;
	}
}