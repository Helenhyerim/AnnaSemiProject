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
			
			String sql =" select * "
					  + " from tbl_product ";
			
			
		} finally {
			close();
		}
		
		
		return pvo;
	}


	// 상품 찜하기 전에 이미 찜한 상품인지 중복 체크하기_임성희
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


	// 상품 찜하기_임성희
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
	}// end of public List<Map<String, String>> getCartItemsByUserid(String userid)

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	////////////////////////////////////////////////////////////////////////
	
	// 이두현 찜목록 받아서 보여주기 위한 메소드 찜List를 반환해서 보여줄거
	// 
	@Override
	public List<ProductVO> selectByWishList(Map<String, String> paraMap) throws SQLException {
		
		List<ProductVO> productList = new ArrayList<>(); // ProductVO타입의 리스트 생성
		
		try {
			conn = ds.getConnection();
			
			String sql = " select productnum, categorynum, productname, productimage1, productqty, " +
			
					     " productprice, fk_specnum, productcontent, point, userid "+
						 " from "+
						 " ( "+
						 "    select row_number() over(order by P.productnum desc)as RNO, productnum, " +
						 "	  categorynum, productname, productimage1, productqty, productprice, fk_specnum, " +
						 "    productcontent, point, D.fk_userid as userid "+
						 
					 	 "    from tbl_product P "+
						 "    JOIN tbl_dibs D "+
						 "    ON P.productnum = D.fk_productnum "+
						 "    where D.fk_userid = ? "+
						 " ) V "+
						 " where V.RNO between ? and ? ";

			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("userid"));
			pstmt.setString(2, paraMap.get("start"));
			pstmt.setString(3, paraMap.get("end"));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductVO pvo = new ProductVO();
				
				pvo.setProductnum(rs.getInt(1));
				pvo.setCategorynum(rs.getInt(2));
				pvo.setProductname(rs.getString(3));
				pvo.setProductimage1(rs.getString(4));
				pvo.setProductqty(rs.getInt(5));
				pvo.setProductprice(rs.getInt(6));
				pvo.setFk_specnum(rs.getInt(7));
				pvo.setProductcontent(rs.getString(8));
				pvo.setPoint(rs.getInt(9));
				
				productList.add(pvo);
				
			}// end of while-----------------
			
			
			
		} finally {
			close();
		}
		
		return productList;
	}

	// 이두현 찜목록의 페이징을 위해서 해당유저의 id값을 매개변수로 하여 찜목록의 전체 카운트를 반환받기위한 메소드
	@Override
	public int totalWishListCount(String userid) throws SQLException {
		
		int result = 0;
		
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select count(*) "
					   + " from tbl_dibs "
					   + " where fk_userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt(1);
			}
			
			
		} finally {
			close();
		}
		
		return result;
	}

	// 멤버의 위시리스트에서 삭제 버튼을 눌렀을 경우 userid와 productnum을 받아와 위시리스트에서 삭제해주는 메소드
	@Override
	public int removeWishProduct_DH(Map<String, String> paraMap) throws SQLException {
		int result = 0;
		
		
		try {

			conn = ds.getConnection();
			
			String productnum = paraMap.get("productnum");
			String userid = paraMap.get("userid");
			
			String sql = " delete "+
					     " from tbl_dibs "+
					     " where fk_userid = ? and fk_productnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			pstmt.setString(2, productnum);
			
			result = pstmt.executeUpdate();
			
	
		} finally {
			close();
		}
		

		return result;
	}
}
