package faqCBJ.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
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

import common.controller.AbstractController;
import faqCBJ.model.FaqVO;
import member.model.MemberVO;

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
			
			String sql = "select faqno, fk_userid, faqrequesttype, faqtitle, faqcontents from tbl_faq order by faqno ";
			
			pstmt = conn.prepareStatement(sql);			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FaqVO faq = new FaqVO();
				faq.setFaqNo(rs.getInt(1));
				faq.setFk_userId(rs.getString(2));
				faq.setFaqRequestType(rs.getString(3));
				faq.setFaqTitle(rs.getString(4));
				faq.setFaqContents(rs.getString(5));
				faqList.add(faq);
			}
		} finally {
			close();
		}
		return faqList;
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
	public List<FaqVO> selectPagingFaq(Map<String, String> paraMap) throws SQLException {
		
		List<FaqVO> faqList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select faqno, faqrequesttype, faqtitle, faqcontents "
						+ " from "
						+ " ( "
						+ "    select rownum AS rno, faqno, faqrequesttype, faqtitle, faqcontents "
						+ "    from "
						+ "    ( "
						+ "        select faqno, faqrequesttype, faqtitle, faqcontents "
						+ "        from tbl_faq "			
						+ "        order by faqno "
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
				
				FaqVO fvo = new FaqVO();
				fvo.setFaqNo(rs.getInt(1));
				fvo.setFaqRequestType(rs.getString(2));
				fvo.setFaqTitle(rs.getString(3));
				fvo.setFaqContents(rs.getString(4)); // 복호화
				
				faqList.add(fvo);
			}// end of while--------------------------------
		
		} finally {
			close();
		}
		
		return faqList;
	}

	@Override
	public List<FaqCategoryVO> getfaqCategory(Map<String, String> paraMap) throws SQLException {

		List<FaqCategoryVO> faqCategory = new ArrayList<>();
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select cnum, faqrequesttype "+
					      " from TBL_FAQCATEGORY "+
					      " order by cnum asc ";
			 
			 pstmt = conn.prepareStatement(sql);
			 
			 rs = pstmt.executeQuery();
			 
			 while(rs.next()) {
				 FaqCategoryVO fcvo = new FaqCategoryVO();
				 fcvo.setCnum(rs.getInt(1));
				 fcvo.setFaqrequesttype(rs.getString(2));
				 
				 faqCategory.add(fcvo);
			 }// end of while(rs.next())-------------------------------
			 
		} finally {
			close();
		}
		
		return faqCategory;
		
	}
}
