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
	
	
	@Override
	public List<QnaVO> selectPagingQna(Map<String, String> paraMap) throws SQLException {
		
		List<QnaVO> qnaList = new ArrayList<>();

		try {
			conn = ds.getConnection();
			
			String sql = " select qnano, fk_userid, questiontitle, questioncontents, questiondate, answertitle, answercontents, answerdate "
					+ " from "
					+ " ( "
					+ " 	select rownum AS rno, qnano, fk_userid, questiontitle, questioncontents, questiondate, answertitle, answercontents, answerdate "
					+ " 	from "
					+ " 	( "
					+ " 		select qnano, fk_userid, questiontitle, questioncontents, questiondate, answertitle, answercontents, answerdate "
					+ " 		from tbl_qna ";
					
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
				
				sql += " and "+colname+" like '%'|| ? ||'%' ";
			
			}
			
			sql += " 		order by qnano desc "
				+ " 	) V "
				+ " ) T "
				+ " where rno between ? and ? ";
			
			
			pstmt = conn.prepareStatement(sql);
			
			int currentShowPageNo = Integer.parseInt(paraMap.get("currentShowPageNo"));
			int sizePerPage = Integer.parseInt(paraMap.get("sizePerPage"));
			
			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
		 		
				pstmt.setString(1, searchWord);						
		 		pstmt.setInt(2, (currentShowPageNo * sizePerPage) -(sizePerPage - 1));
				pstmt.setInt(3, (currentShowPageNo * sizePerPage));
		 	}
		 	else {
		 		pstmt.setInt(1, (currentShowPageNo * sizePerPage) -(sizePerPage - 1));
				pstmt.setInt(2, (currentShowPageNo * sizePerPage));
		 	}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				QnaVO qvo = new QnaVO();
				qvo.setQnaNo(rs.getInt(1));
				qvo.setFk_userId(rs.getString(2));
				qvo.setQuestionTitle(rs.getString(3));
				qvo.setQuestionContents(rs.getString(4));
				qvo.setQuestionDate(rs.getString(5));
				qvo.setAnswerTitle(rs.getString(6));
				qvo.setAnswerContents(rs.getString(7));
				qvo.setAnswerDate(rs.getString(8));				
				
				qnaList.add(qvo);
			}// end of while -----------------------------------------------------
			
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
					   + " from tbl_qna ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
				
				sql += " and "+colname+" like '%'|| ? ||'%' ";
			
			}
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("sizePerPage"));
			
			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
				
				pstmt.setString(2, paraMap.get("searchWord")); // 암호화를 안한 것
				
			}
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalPage = rs.getInt(1);
			
		} finally {
			close();
		}
		
		return totalPage;
	}

	@Override
	public int getEnumOfQna() throws SQLException {

		int qnaNo = 0;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select seq_qnano.nextval "
			 			+ " from dual ";
			 
			 pstmt = conn.prepareStatement(sql);			 
			 
			 rs = pstmt.executeQuery();			 
			 
			 rs.next();
			 qnaNo = rs.getInt(1);
			 
		} finally {
			close();
		}
		
		return qnaNo;
	}

	@Override
	public int questionInsert(QnaVO qvo) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_qna(qnano, fk_userid, questiontitle, questioncontents, questiondate, "
					   + " answertitle, answercontents, answerdate, questionimg, answerimg ) "
					   + " values(?, ?, ?, ?, sysdate, '', '', '', ?, '') ";			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, qvo.getQnaNo());
			pstmt.setString(2, qvo.getFk_userId());
			pstmt.setString(3, qvo.getQuestionTitle());
			pstmt.setString(4, qvo.getQuestionContents());
			pstmt.setString(5, qvo.getQuestionImg());
			
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}
	
	// 조건 조회(R)
		@Override
		public QnaVO selectOne(int qnano) throws SQLException {
				
			QnaVO qna = null;
			
			try {
				conn = ds.getConnection();
				
				String sql = " select qnano, fk_userid, questiontitle, "
						   + " questionContents, questiondate, answertitle, "
						   + " answercontents, answerdate, questionimg, answerimg "
						   + " from tbl_qna where qnano = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, qnano);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					qna = new QnaVO();		
					qna.setQnaNo(rs.getInt(1));
					qna.setFk_userId(rs.getString(2));
					qna.setQuestionTitle(rs.getString(3));
					qna.setQuestionContents(rs.getString(4));
					qna.setQuestionDate(rs.getString(5));
					qna.setAnswerTitle(rs.getString(6));
					qna.setAnswerContents(rs.getString(7));
					qna.setAnswerDate(rs.getString(8));
					qna.setQuestionImg(rs.getString(9));
					qna.setAnswerImg(rs.getString(10));
				}
			} finally {
				close();
			}
			return qna;
		}

		@Override
		public int answerInsert(QnaVO qvo) throws SQLException {
			
			int result = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " update tbl_qna set answertitle = ?, answercontents = ?, answerdate = sysdate, answerimg = ? "
						   + " where qnano = ? ";			
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, qvo.getAnswerTitle());
				pstmt.setString(2, qvo.getAnswerContents());				
				pstmt.setString(3, qvo.getAnswerImg());								
				pstmt.setInt(4, qvo.getQnaNo());
				
				result = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return result;
			
		}

		@Override
		public int questionUpdate(QnaVO qvo) throws SQLException {
			
			int result = 0;
			
			try {
				conn = ds.getConnection();
				
				String sql = " update tbl_qna set questiontitle = ?, questioncontents = ?, questionimg = ?, questiondate = sysdate, "
						   + " answertitle = '', answercontents = '', answerdate = '', answerimg = '' "
						   + " where qnano = ? ";			
				
				pstmt = conn.prepareStatement(sql);
											
				pstmt.setString(1, qvo.getQuestionTitle());
				pstmt.setString(2, qvo.getQuestionContents());
				pstmt.setString(3, qvo.getQuestionImg());
				pstmt.setInt(4, qvo.getQnaNo());
				
				
				result = pstmt.executeUpdate();
				
			} finally {
				close();
			}
			
			return result;
		}
		
		@Override
		public int delete(int qnaNo) throws SQLException {

			int result = 0;
			
			try {                                                                                                                                       
				conn = ds.getConnection();
				
				String sql = " delete from tbl_qna where qnano = ? ";
				
				pstmt = conn.prepareStatement(sql);			
				pstmt.setInt(1, qnaNo);
				result = pstmt.executeUpdate(); // 잘 들어가면 숫자가 바뀔 것이다
			} finally {
				close();
			}
			return result;
		}
}
