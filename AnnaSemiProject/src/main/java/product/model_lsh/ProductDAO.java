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
		
		ProductVO pvo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select productimage1, productname, productnum, productprice, saleprice, productqty "
					   + "from tbl_product "
					   + "where productnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(productnum));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String productimage1 = rs.getString(1);
				String productname = rs.getString(2);
				int pnum = rs.getInt(3);
				int productprice = rs.getInt(4);
				int saleprice = rs.getInt(5);
				int productqty = rs.getInt(6);
				
				pvo = new ProductVO();
				
				pvo.setProductimage1(productimage1);
				pvo.setProductname(productname);
				pvo.setProductnum(pnum);
				pvo.setProductprice(productprice);
				pvo.setSaleprice(saleprice);
				pvo.setProductqty(productqty);
			}
			
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
	public List<ProductVO> getCartItemsByUserid(String userid) throws SQLException {
		
		List<ProductVO> productList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql =" select C.FK_PRODUCTNUM, C.ORDERQTY, " + 
					"        P.PRODUCTNAME, P.PRODUCTIMAGE1, P.PRODUCTQTY, P.PRODUCTPRICE, P.SALEPRICE, P.POINT, " +
					"		 C.cartno, C.fk_optionnum " +
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
			//	cvo.setFk_productnum(rs.getInt(10)); 성희랑 cvo 합치고 수정
				pvo.setCvo(cvo); // 장바구니
				
				productList.add(pvo);
			}// end of while(rs.next()) --------
			
		} finally {
			close();
		}
		
		return productList;
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


	// 최근 주문 정보 알아오기
	@Override
	public OrderVO selectRecentOrder(String userid) throws SQLException {

		OrderVO ovo = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select ordernum, ordertotalprice, ordertotalpoint, to_char(orderdate, 'yyyy-mm-dd hh24:mi:ss'), paymethod, name_receiver, zipcode, address "
					   + "from tbl_order "
					   + "where fk_userid = ? "
					   + "order by sysdate desc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String ordernum = rs.getString(1);
				int ordertotalprice = rs.getInt(2);
				int ordertotalpoint = rs.getInt(3);
				String orderdate = rs.getString(4);
				String name_receiver = rs.getString(5);
				String zipcode = rs.getString(6);
				String address = rs.getString(7);
				
				ovo = new OrderVO();
				
				ovo.setOrdernum(ordernum);
				ovo.setOrdertotalprice(ordertotalprice);
				ovo.setOrdertotalpoint(ordertotalpoint);
				ovo.setOrderdate(orderdate);
				ovo.setName_receiver(name_receiver);
				ovo.setZipcode(zipcode);
				ovo.setAddress(address);
			}
			
		} finally {
			close();
		}
		
		return ovo;
	}


	// 상품 리뷰 알아오기
	@Override
	public List<PurchaseReviewVO> reviewInfo(String productnum) throws SQLException {
		
		List<PurchaseReviewVO> reviewList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select review_no, fk_userid, fk_productnum, reviewtitle, reviewcontents, reviewdate "
					   + "from tbl_purchase_reviews "
					   + "where fk_productnum = ? "
					   + "order by review_no desc ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productnum);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				int review_no = rs.getInt(1);				// 리뷰 번호(시퀀스)
				String userid = rs.getString(2);			// 사용자 ID
				int pnum = rs.getInt(3);					// 제품 번호
				String reviewtitle = rs.getString(4);		// 리뷰 제목
				String reviewcontents = rs.getString(5);	// 리뷰 내용
				String reviewdate = rs.getString(6);		// 리뷰 작성일자
				
				PurchaseReviewVO reviewvo = new PurchaseReviewVO();
				reviewvo.setReview_no(review_no);
				reviewvo.setUserid(userid);
				reviewvo.setProductnum(pnum);
				reviewvo.setReviewtitle(reviewtitle);
				reviewvo.setReviewcontents(reviewcontents);
				reviewvo.setReviewdate(reviewdate);
				
				reviewList.add(reviewvo);
			}
			
		} finally {
			close();
		}
		
		return reviewList;
	}


	// 장바구니 페이지에서 넘어온 cartno 로 주문페이지에 보여줄 아이템 조회해오기
	@Override
	public ProductVO getOrderItems(String cartno) throws SQLException {
		
		ProductVO pvo = new ProductVO();
		
		try {
			conn = ds.getConnection();
			
			String sql =" select P.productnum, P.productname, P.productcompany, P.productimage1 " + 
					"     , P.productprice, P.saleprice, P.point  " + 
					"     , C.ORDERQTY, P.productprice*C.ORDERQTY as Totalpricebyproduct , P.point*C.ORDERQTY as Totalpointbyproduct " +
					"	  , C.cartno	" +	
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
				cvo.setTotalpricebyproduct(rs.getInt(9));
				cvo.setTotalpointbyproduct(rs.getInt(10));
				cvo.setCartno(rs.getInt(11));
				
				pvo.setCvo(cvo); // 장바구니
				
						
			}// end of while(rs.next()) --------
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		} 
		
		return pvo;
	}// end of public List<ProductVO> getOrderItems(String cart_checked)----------

	
	// 주문한 상품에 대한 총 주문금액과 총포인트 알아오기
	@Override
	public Map<String, Integer> getTotalPricePoint(String cartno) throws SQLException {
		
		Map<String, Integer> totalpricepointMap = new HashMap<>();
		
		int sumPrice = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql =" select C.orderqty * P.productprice as totalprice " + 
					" from tbl_cart C JOIN tbl_product P " + 
					" on C.fk_productnum = P.productnum " + 
					" where C.cartno = ? ";
			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cartno);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				totalpricepointMap.put("sumPrice", rs.getInt(1));				
				// 포인트도 똑같이 한다
						
			}// end of if(rs.next()) --------
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close();
		} 
		
		return totalpricepointMap;
	}

	// 주문번호(시퀀스 seq_ordernum 값)을 채번해오는 것이다
	@Override
	public int getSeq_ordernum() throws SQLException {
		int seq = 0;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select seq_ordernum.nextval "
			 			+ " from dual " ;
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 rs = pstmt.executeQuery();
			 rs.next();
			 
			 seq = rs.getInt(1);
			 
		} finally {
			close();
		}
		
		return seq;
	}

	
	// ===== Transaction 처리하기 ===== // 
    // 1. 주문 테이블에 입력되어야할 주문전표를 채번(select)하기 
    // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
    // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
    // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리) 
    
	// 5. 장바구니 테이블에서 cartnojoin 값에 해당하는 행들을 삭제(delete OR update)하기(수동커밋처리)
	// >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. << 
    
	// 6. 회원 테이블에서 로그인한 사용자의 coin 액을 sumtotalPrice 만큼 감하고, point 를 sumtotalPoint 만큼 더하기(update)(수동커밋처리) 
    // 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
    // 8. **** SQL 장애 발생시 rollback 하기(rollback) **** 

    // === Transaction 처리가 성공시 세션에 저장되어져 있는 loginuser 정보를 새로이 갱신하기 ===
    // === 주문이 완료되었을시 주문이 완료되었다라는 email 보내주기  === //
	@Override
	public int orderAdd(Map<String, Object> paraMap) throws SQLException {
		int isSuccess = 0;
	      int n1=0, n2=0, n3=0, n4=0, n5=0;
	      
	      try {
	          conn = ds.getConnection();
	          
	          conn.setAutoCommit(false); // 수동커밋
	          
	         // 2. 주문 테이블에 채번해온 주문전표, 로그인한 사용자, 현재시각을 insert 하기(수동커밋처리)
	          String sql = " insert into tbl_order(ordernum, fk_userid, ordertotalprice, ordertotalpoint, orderdate, name_receiver, zipcode, address) "
	                    + " values(?, ?, ?, ?, default, ?, ?, ?) ";
	          
	          pstmt = conn.prepareStatement(sql);
	          pstmt.setString(1, (String)paraMap.get("odrcode") );
	          pstmt.setString(2, (String)paraMap.get("userid"));
	          pstmt.setInt(3,  Integer.parseInt((String)paraMap.get("sumtotalPrice")) );
	          pstmt.setInt(4,  Integer.parseInt((String)paraMap.get("sumtotalPoint")) );
	          pstmt.setString(5, (String)paraMap.get("receivedname") );
	          pstmt.setString(6, (String)paraMap.get("postcode") );
	          pstmt.setString(7, (String)paraMap.get("address") );

	          n1 = pstmt.executeUpdate();
	          System.out.println("~~~~~~~ n1 : " + n1);
	          
	         // 3. 주문상세 테이블에 채번해온 주문전표, 제품번호, 주문량, 주문금액을 insert 하기(수동커밋처리)
	         if(n1 == 1) {
	            
	            String[] pnumArr = (String[]) paraMap.get("pnumArr");
	            String[] oqtyArr = (String[]) paraMap.get("oqtyArr");
	            String[] totalPriceArr = (String[]) paraMap.get("totalPriceArr");
	            
	            int cnt = 0;
	            for(int i=0; i<pnumArr.length; i++) {
	               sql = " insert into tbl_orderdetail(orderseqnum, ordernum, fk_productnum, orderqty, orderprice, deliverstatus ) "
	                  + " values(seq_tbl_orderdetail.nextval, ?, to_number(?), to_number(?), to_number(?), default) "; 
	               
	               pstmt = conn.prepareStatement(sql);
	               pstmt.setString(1, (String)paraMap.get("odrcode"));
	               pstmt.setString(2, pnumArr[i]);
	               pstmt.setString(3, oqtyArr[i]);
	               pstmt.setString(4, totalPriceArr[i]);
	               
	               pstmt.executeUpdate();
	               cnt++;
	            }// end of for--------------------------
	            
	            if(cnt == pnumArr.length) {
	               n2=1;
	            }
	            System.out.println("~~~~~~~ n2 : " + n2);
	            
	         }// end of if(n1 == 1)-------------------------
	          
	         // 4. 제품 테이블에서 제품번호에 해당하는 잔고량을 주문량 만큼 감하기(수동커밋처리) 
	         if(n2==1) {
	            String[] pnumArr = (String[]) paraMap.get("pnumArr");
	            String[] oqtyArr = (String[]) paraMap.get("oqtyArr");
	            
	            int cnt = 0;
	            for(int i=0; i<pnumArr.length; i++) {
	               sql = " update tbl_product set productqty = productqty - ? "
	                  + " where productnum = ? "; 
	               
	               pstmt = conn.prepareStatement(sql);
	               pstmt.setInt(1, Integer.parseInt(oqtyArr[i]));
	               pstmt.setString(2, pnumArr[i]);
	               
	               pstmt.executeUpdate();
	               cnt++;
	            }// end of for--------------------------
	            
	            if(cnt == pnumArr.length) {
	               n3=1;
	            }
	            System.out.println("~~~~~~~ n3 : " + n3);
	         }// end of if(n2==1)---------------------------
	          
	         // 5. 장바구니 테이블에서 cartnojoin 값에 해당하는 행들을 삭제(delete OR update)하기(수동커밋처리) 
	         // >> 장바구니에서 주문을 한 것이 아니라 특정제품을 바로주문하기를 한 경우에는 장바구니 테이블에서 행들을 삭제할 작업은 없다. <<
	         if( paraMap.get("cartnojoin") != null && n3==1 ) {
	            
	            String cartnojoin = (String) paraMap.get("cartnojoin");
	            
	            sql = " delete from tbl_cart "
	               + " where cartno in ("+cartnojoin+") ";
	            
	             //  !!! in 절은 위와 같이 직접 변수로 처리해야 함. !!! 
	            //  in 절에 사용되는 것들은 컬럼의 타입을 웬만하면 number 로 사용하는 것이 좋다. 
	            //  왜냐하면 varchar2 타입으로 되어지면 데이터 값에 앞뒤로 홑따옴표 ' 를 붙여주어야 하는데 이것을 만들수는 있지만 귀찮기 때문이다.    
	            
	            pstmt = conn.prepareStatement(sql);
	            n4 = pstmt.executeUpdate();
	            
	            System.out.println("~~~~~ n4 :" + n4);
	            // 만약에 장바구니 비우기를 할 상품이 3개라면
	            // "~~~~~ n4 : 3이 나올 것이다
	            
	         }// end of if( paraMap.get("cartnojoin") != null && n3==1 ) 
	         
	         if(paraMap.get("cartnojoin") == null && n3 == 1) {
	        	 // "제품 상세 정보" 페이지에서 "바로주문하기"를 한 경우
	        	 // 장바구니 번호인 paraMap.get("cartnojoin")이 없는 것이다.
	        	 
	        	 n4=1;
	        	 System.out.println("~~~~~ 바로주문하기인 경우 n4 :" + n4);
	         }
	         
	         
	         
	     	// 6. 회원 테이블에서 point 를 sumtotalPoint 만큼 더하기(update)(수동커밋처리) 
	         if(n4 > 0) {
	        	 sql = " update tbl_member set point = point + ? "
	                 + " where userid = ? "; 
	    	 
	        	 pstmt = conn.prepareStatement(sql);
	        	 
	        	 pstmt.setInt(1, Integer.parseInt((String) paraMap.get("sumtotalPoint")));
	        	 pstmt.setString(2, (String)paraMap.get("userid"));
	        	 
	        	 n5 = pstmt.executeUpdate();
	        	 System.out.println("~~~~~~~~ n5 :" + n5);
	         }// end of if(n4 > 0) {---------------------------------------
	         
	         
	         // 7. **** 모든처리가 성공되었을시 commit 하기(commit) **** 
	         if(n1*n2*n3*n4*n5 != 0) {
	        	 
	        	 conn.commit(); // 커밋
	        	 conn.setAutoCommit(false); // 자동커밋으로 전환
	        	 
	        	 isSuccess = 1;
	        	 System.out.println("~~~~ 확인용 n1*n2*n3*n4*n5 =>" + (n1*n2*n3*n4*n5));
	         }
	         
	         
	      } catch (SQLException e) {
	    	  e.printStackTrace();
	    	  
	         // 8. **** SQL 장애 발생시 rollback 하기(rollback) ****
	         conn.rollback();
	         conn.setAutoCommit(false); // 자동커밋으로 전환 
	         
	      } finally {
	         close();
	      }
	      
	      return isSuccess;
	}
	
}
