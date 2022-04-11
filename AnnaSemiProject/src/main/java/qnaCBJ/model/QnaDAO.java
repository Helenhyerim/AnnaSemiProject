package qnaCBJ.model;

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

import faqCBJ.model.FaqVO;
import noticeCBJ.model.NoticeVO;
import qnaCBJ.model.QnaVO;
import qnaCBJ.model.QnaVO;

public class QnaDAO implements InterQnaDAO {

	private DataSource ds;    // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public QnaDAO() {
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

	// 삽입(C)
	@Override
	public int insert(QnaVO vo) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_notice (qnano, fk_userid, questiontitle, questioncontents, questiondate, answertitle, answercontents, answerdate) "
					+ " values (seq_noticeno.nextval, ?, ?, ?, sysdate, '', '', '') ";			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getFk_userId());
			pstmt.setString(2, vo.getQuestionTitle());	
			pstmt.setString(3, vo.getQuestionContents());
			
			result = pstmt.executeUpdate(); // 잘 들어가면 숫자가 바뀔 것이다
			
		} finally {
			close();
		}
		
		return result;
	}
	
	
	@Override
	public ArrayList<QnaVO> selectAll() throws SQLException {
		
		
		ArrayList<QnaVO> qnaList = new ArrayList<QnaVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select qnano, fk_userid, questiontitle, questioncontents, questiondate, answertitle, answercontents, answerdate "
						+ " from tbl_qna "
						+ " order by qnano desc ";
			
			pstmt = conn.prepareStatement(sql);			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				QnaVO qna = new QnaVO();
				qna.setQnaNo(rs.getInt(1));
				qna.setFk_userId(rs.getString(2));
				qna.setQuestionTitle(rs.getString(3));
				qna.setQuestionContents(rs.getString(4));
				qna.setQuestionDate(rs.getString(5));
				qna.setAnswerTitle(rs.getString(6));
				qna.setAnswerContents(rs.getString(7));
				qna.setAnswerDate(rs.getString(8));
				
				qnaList.add(qna);
				
			}
		} finally {
			close();
		}
		return qnaList;
	}
	
	
	@Override
	public int getTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil( count(*)/? ) "
					   + " from tbl_qna";
			
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
	public List<QnaVO> selectPagingQna(Map<String, String> paraMap) throws SQLException {
		
		List<QnaVO> qnaList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select qnano, fk_userid, questiontitle, questioncontents, questiondate"
						+ " from "
						+ " ( "
						+ "    select rownum AS rno, qnano, fk_userid, questiontitle, questioncontents, questiondate "
						+ "    from "
						+ "    ( "
						+ "        select qnano, fk_userid, questiontitle, questioncontents, questiondate "
						+ "        from tbl_qna "			
						+ "        order by qnano "
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
				
				QnaVO fvo = new QnaVO();
				fvo.setQnaNo(rs.getInt(1));
				fvo.setFk_userId(rs.getString(2));
				fvo.setQuestionTitle(rs.getString(3));
				fvo.setQuestionContents(rs.getString(4));
				fvo.setQuestionDate(rs.getString(5));
				
				qnaList.add(fvo);
			}// end of while--------------------------------
		
		} finally {
			close();
		}
		
		return qnaList;
	}
}
