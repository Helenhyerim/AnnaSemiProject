package faqCBJ.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import common.controller.AbstractController;
import faqCBJ.model.FaqVO;

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
			
			String sql = "select faqno, fk_userid, faqrequesttype, faqtitle, faqcontents from tbl_faq order by faqno desc ";
			
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
}
