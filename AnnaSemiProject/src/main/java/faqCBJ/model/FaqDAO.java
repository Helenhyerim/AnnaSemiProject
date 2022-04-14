package faqCBJ.model;

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

import eventCBJ.model.EventVO;

public class FaqDAO implements InterFaqDAO {

	private DataSource ds;    // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public FaqDAO() {
		try {
			Context initContext = new InitialContext();
		    Context envContext  = (Context)initContext.lookup("java:/comp/env");
		    ds = (DataSource)envContext.lookup("jdbc/anna_oracle");
		  
		} catch(NamingException e) {
			e.printStackTrace();
		} 
	}
	
	private void close() {
		try {
			if(rs != null)    {rs.close();	  rs = null;}
			if(pstmt != null) {pstmt.close(); pstmt = null;}
			if(conn != null)  {conn.close();  conn = null;}
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 조회(R)
	@Override
	public ArrayList<FaqVO> selectAll() throws SQLException {
		
		
		ArrayList<FaqVO> faqList = new ArrayList<FaqVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select faqno, fk_userid, faqrequesttype, faqtitle, faqimg, fk_cnum, cname "
						+ " from tbl_faq join tbl_faqcategory on fk_cnum = cnum "
						+ " order by faqno ";
			
			pstmt = conn.prepareStatement(sql);			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FaqVO faq = new FaqVO();
				faq.setFaqNo(rs.getInt(1));
				faq.setFk_userId(rs.getString(2));
				faq.setFaqRequestType(rs.getString(3));
				faq.setFaqTitle(rs.getString(4));
				faq.setFaqImg(rs.getString(5));
				faq.setFk_cnum(rs.getInt(6));

				FaqCategoryVO faqcategvo = new FaqCategoryVO();
				faqcategvo.setCname(rs.getString(7));
				
				faq.setFaqcategvo(faqcategvo);
				
				faqList.add(faq);
				
			}
		} finally {
			close();
		}
		return faqList;	
	}

	// 조건 조회(R)
	@Override
	public FaqVO selectOne(int faqNo) throws SQLException {
			
		FaqVO faq = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select faqno, fk_userid, faqrequesttype, faqtitle, faqimg, fk_cnum "
					   + " from tbl_faq where faqno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, faqNo);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				faq = new FaqVO();		
				faq.setFaqNo(rs.getInt(1));
				faq.setFk_userId(rs.getString(2));
				faq.setFaqRequestType(rs.getString(3));
				faq.setFaqTitle(rs.getString(4));
				faq.setFaqImg(rs.getString(5));
				faq.setFk_cnum(rs.getInt(6));
			}
		} finally {
			close();
		}
		return faq;
	}
	
	// 삭제(D)
	@Override
	public int delete(int faqNo) throws SQLException {

		int result = 0;
		
		try {                                                                                                                                       
			conn = ds.getConnection();
			
			String sql = " delete from tbl_faq where faqno = ? ";
			
			pstmt = conn.prepareStatement(sql);			
			pstmt.setInt(1, faqNo);
			result = pstmt.executeUpdate(); // 잘 들어가면 숫자가 바뀔 것이다
		} finally {
			close();
		}
		return result;
	}
	
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {

		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil( count(*)/? ) "
					   + " from tbl_faq";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sizePerPage"));
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);							
			
		} finally {
			close();
		}
		
		return totalPage;
		
	}

	@Override
	public List<Object> selectPagingFaq(Map<String, String> paraMap) throws SQLException {
		
		List<Object> faqList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select faqno, faqrequesttype, faqtitle, faqimg, fk_cnum, cname "
						+ " from "
						+ " ( "
						+ "    select rownum AS rno, faqno, faqrequesttype, faqtitle, faqimg, fk_cnum, cname "
						+ "    from "
						+ "    ( "
						+ "        select faqno, faqrequesttype, faqtitle, faqimg, fk_cnum, cname "
						+ "        from tbl_faq join tbl_faqcategory on fk_cnum = cnum "			
						+ "        order by cname "
						+ "    ) V "
						+ " ) T "
						+ " where rno between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
		 	int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
		 	pstmt.setInt(1, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
			pstmt.setInt(2, (currentShowPageNo * sizePerPage));	
		 	
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				Map<String, String> map = new HashMap<>();
				map.put("faqno", Integer.toString(rs.getInt("faqno")));
				map.put("faqrequesttype", rs.getString("faqrequesttype"));
				map.put("faqtitle", rs.getString("faqtitle"));
				map.put("faqimg", rs.getString("faqimg"));
				map.put("fk_cnum", Integer.toString(rs.getInt("fk_cnum")));
				map.put("cname", rs.getString("cname"));
				
				faqList.add(map);
			}// end of while--------------------------------
		
		} finally {
			close();
		}
		
		return faqList;
	}	

	@Override
	public int getFnumOfFaq() throws SQLException {
		
		int fqaNo = 0;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select seq_faqno.nextval "
			 			+ " from dual ";
			 
			 pstmt = conn.prepareStatement(sql);			 
			 
			 rs = pstmt.executeQuery();			 
			 
			 rs.next();
			 fqaNo = rs.getInt(1);
			 
		} finally {
			close();
		}
		
		return fqaNo;
		
	}
	

	@Override
	public int faqInsert(FaqVO evo) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_faq(faqno, fk_userid, faqrequesttype, faqtitle, faqimg, fk_cnum) "
						+ " values(?, 'admin', ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, evo.getFaqNo());
			pstmt.setString(2, evo.getFaqRequestType());
			pstmt.setString(3, evo.getFaqTitle());
			pstmt.setString(4, evo.getFaqImg());
			pstmt.setInt(5, evo.getFk_cnum());
			
	        result = pstmt.executeUpdate();
	        
		} finally {
			close();
		}
		
		return result;
	}

	
	@Override
	public int faqUpdate(FaqVO fvo) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_faq set faqtitle = ?, faqimg = ? "
						+ " where faqno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, fvo.getFaqTitle());
			pstmt.setString(2, fvo.getFaqImg());
			pstmt.setInt(3, fvo.getFaqNo());
			
	        result = pstmt.executeUpdate();
	        
		} finally {
			close();		
		}
		return result;
	}

	@Override
	public List<Object> selectFaqByCategory(Map<String, String> paraMap) throws SQLException {

		List<Object> faqList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select cname, faqno, fk_userid, faqtitle, faqimg, fk_cnum "
					   + " from "
					   + " ( "
					   + "    select rownum as rno, cname, faqno, fk_userid, faqtitle, faqimg, fk_cnum "
					   + "    from "
					   + "    ( "
					   + "        select c.cname, faqno, fk_userid, faqtitle, faqimg, fk_cnum "
					   + "        from "
					   + "        ( "
					   + "            select faqno, fk_userid, faqtitle, faqimg, fk_cnum "
					   + "            from tbl_faq "
					   + "            where fk_cnum = ? "
					   + "            order by faqno desc "
					   + "        ) F "
					   + "        join tbl_faqcategory C "
					   + "        on f.fk_cnum = c.cnum "
					   + "    ) V "
					   + " ) T "
					   + " where T.rno between ? and ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = 10;
			
			pstmt.setString(1, paraMap.get("cnum"));
			pstmt.setInt(2, (currentShowPageNo * sizePerPage) - (sizePerPage - 1));
			pstmt.setInt(3, (currentShowPageNo * sizePerPage));
			
			rs = pstmt.executeQuery();
			
			while( rs.next() ) {
				
				Map<String, String> map = new HashMap<>();
				map.put("faqno", Integer.toString(rs.getInt("faqno")));
				map.put("faqtitle", rs.getString("faqtitle"));
				map.put("faqimg", rs.getString("faqimg"));
				map.put("fk_cnum", Integer.toString(rs.getInt("fk_cnum")));
				map.put("cname", rs.getString("cname"));
				
				faqList.add(map);
				
			}
		} finally {
			close();
		}
		
		return faqList;
		
	}

	@Override
	public List<HashMap<String, String>> getFaqCategoryList() throws SQLException {

		List<HashMap<String, String>> faqCategoryList = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select cnum, cname "+
					      " from tbl_faqcategory "+
					      " order by cnum asc ";
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 rs = pstmt.executeQuery();
			 
			 while(rs.next()) {
				 HashMap<String, String> map = new HashMap<>();
				 map.put("cnum", rs.getString(1));
				 map.put("cname", rs.getString(2));
				 
				 faqCategoryList.add(map);
			 }// end of while(rs.next())-------------------------------
			 
		} finally {
			close();
		}
		
		return faqCategoryList;
	}

	@Override
	public int getTotalPage(String cnum) throws SQLException {

		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil( count(*)/10 ) "
					   + " from tbl_faq "
					   + " where fk_cnum = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, cnum);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);							
			
		} finally {
			close();
		}
		
		return totalPage;
	}
}