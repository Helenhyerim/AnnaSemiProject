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

import cart.model.CartVO;
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
			
			// rno와 categorynum는 빼고 select 한다.
		/*	
			String sql = "select productimage1, productname, productprice, productnum "+
					"from "+
					"( "+
					"    select rownum as rno, productimage1, productname, productprice, productnum, categorynum "+
					"    from "+
					"    ( "+
					"    select productimage1, productname, productprice, productnum, categorynum "+
					"    from tbl_product "+
					"    order by ? "+
					"    ) V "+
					") T "+
					"where rno between ? and ? and categorynum = ? ";
		*/
			String orderby = "";
			switch (paraMap.get("sort")) {
				case "1":
					orderby = " productinputdate asc ";
					break;
					
				case "2":
					orderby = " productprice desc ";
					break;	
				
				case "3":
					orderby = " productprice asc ";
					break;	
			};
			
			String sql = "select productimage1, productname, productprice, productnum "+
					"from "+
					"( "+
					"    select rownum as rno, productimage1, productname, productprice, productnum, categorynum "+
					"    from "+
					"    ( "+
					"    select productimage1, productname, productprice, productnum, categorynum "+
					"    from tbl_product "
					+ "  order by " + orderby;
			
			sql += "    ) V "+
					") T "+
					"where rno between ? and ? and categorynum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			// '1' '10' 해도 잘 select 된다. 그러므로 setInt 혹은 setString 으로 해도 된다.
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
		//	System.out.println(" paraMap.get(\"sort\") => " + paraMap.get("sort"));
		//	pstmt.setString(1, paraMap.get("sort"));
			pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
			pstmt.setInt(2, (currentShowPageNo * sizePerPage));
			pstmt.setString(3, paraMap.get("categorynum"));
			
			System.out.println("~~~ 확인용 categorynum=> " + paraMap.get("categorynum") );
			
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
	public List<ProductVO> getCartItemsByUserid(String userid) throws SQLException {
		
		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql =" select C.FK_PRODUCTNUM, C.ORDERQTY, " + 
					"        P.PRODUCTNAME, P.PRODUCTIMAGE1, P.PRODUCTQTY, P.PRODUCTPRICE, P.SALEPRICE, P.POINT, " +
					"		 C.cartno " +
					" from tbl_product P " + 
					" JOIN tbl_cart C " + 
					" ON P.productnum = C.fk_productnum " + 
					" JOIN tbl_member M " + 
					" ON M.userid = C.fk_userid " + 
					" where M.userid = ? " + 
					" order by C.fk_productnum asc ";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				CartVO cvo = new CartVO();
								
				cvo.setFk_productnum(rs.getInt(1));
				cvo.setOrderqty(rs.getInt(2));
				
				ProductVO pvo = new ProductVO();
				
				pvo.setProductname(rs.getString(3));
				pvo.setProductimage1(rs.getString(4));
				pvo.setProductqty(rs.getInt(5));
				pvo.setProductprice(rs.getInt(6));
				pvo.setSaleprice(rs.getInt(7));
				pvo.setPoint(rs.getInt(8));
								
				cvo.setCartno(rs.getInt(9));
				pvo.setCvo(cvo); // 장바구니
				
				productList.add(pvo);
			}// end of while(rs.next()) --------
			
		} finally {
			close();
		}
		
		return productList;
	}// end of public List<Map<String, String>> getCartItemsByUserid(String userid)


	// 장바구니 페이지에서 넘어온 cartno 로 주문페이지에 보여줄 아이템 조회해오기
	@Override
	public ProductVO getOrderItems(String cartno) throws SQLException {
		
		ProductVO pvo = new ProductVO();
		
		try {
			conn = ds.getConnection();
			
			String sql =" select P.productnum, P.productname, P.productcompany, P.productimage1 " + 
					"     , P.productprice, P.saleprice, P.point  " + 
					"     , C.ORDERQTY " + 
					" from tbl_product P JOIN tbl_cart C " + 
					" ON P.productnum = C.fk_productnum " + 
					" where C.cartno = ? ";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cartno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
								
				pvo.setProductnum(Integer.parseInt(rs.getString(1)));
				pvo.setProductname(rs.getString(2));
				pvo.setProductcompany(rs.getString(3));
				pvo.setProductimage1(rs.getString(4));
				pvo.setProductprice(rs.getInt(5));
				pvo.setSaleprice(rs.getInt(6));
				pvo.setPoint(rs.getInt(7));
								
				CartVO cvo = new CartVO();
				cvo.setOrderqty(rs.getInt(8));
				
				pvo.setCvo(cvo); // 장바구니
				
						
			}// end of while(rs.next()) --------
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		} 
		
		return pvo;
	}// end of public List<ProductVO> getOrderItems(String cart_checked)----------
	
	
}
