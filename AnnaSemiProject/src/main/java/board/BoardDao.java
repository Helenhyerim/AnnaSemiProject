package board;
import java.util.Date;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import common.controller.JdbcUtil;

public class BoardDao {
	private JdbcUtil ds; 
	
	public BoardDao() {
		ds = JdbcUtil.getInstance(); 
	}
	
	
	public int insert(BoardVo vo) {
		Connection con = null; 
		PreparedStatement pstmt = null;
		
		String query = "insert into \"TBL_QNA\" (\"QNANO\",\"FK_USERID\",\"QUESTIONTITLE\",\"QUESTIONCONTENTS\",\"QUESTIONDATE\",\"ANSWERTITLE\", \"ANSWERCONTENTS\", \"ANSWERDATE\") values (\"TBL_QNA_SEQ\".nextval, ?, ?, ?, sysdate, ?, ?, sysdate) " ;
		
		
		/*
		String sql = "insert into tbl_qna (qnano,fk_userid,questiontitle,questioncontents,questiondate,answertitle,answercontents,answerdate) " 
				+ "values(tbl_qna_seq.nextval, '작성자','제목', '내용', sysdate,'답변제목','답변내용',sysdate)";
		*/
		
		int ret = -1;
			try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, vo.getFk_userid());
			pstmt.setString(2, vo.getQuestiontitle());
			pstmt.setString(3, vo.getQuestioncontents());
			pstmt.setString(4, vo.getAnswertitle());
			pstmt.setString(5, vo.getAnswercontents());
			ret = pstmt.executeUpdate();			
			
			
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println("bb");
			
		}finally {
			if(pstmt != null) {
				try {
					con.close();
				} catch (SQLException e) {
					 
					e.printStackTrace();
					System.out.println("cc");
				} 
			}
		}
			return ret;
	}
	
	
	
	public List<BoardVo> selectAll(){
		Connection con = null;
		Statement stmt = null;
		ResultSet rs = null;
		String query = "select \"QNANO\",\"FK_USERID\",\"QUESTIONTITLE\",\"QUESTIONCONTENTS\",\"QUESTIONDATE\",\"ANSWERTITLE\", \"ANSWERCONTENTS\", \"ANSWERDATE\" from \"TBL_QNA\" " ; 
		ArrayList<BoardVo> ls = new ArrayList<BoardVo>();
		try {
			con = ds.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			while(rs.next()) {
				BoardVo vo = new BoardVo(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						new Date(rs.getDate(5).getTime()),
						rs.getString(6),
						rs.getString(7),
						new Date(rs.getDate(8).getTime()) );
				ls.add(vo);
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
			System.out.println("ee");
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					 
					e.printStackTrace();
					System.out.println("dao-82");
				} 
			}
			
			if(stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					 
					e.printStackTrace();
					System.out.println("dao-92");
				} 
			}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					 
					e.printStackTrace();
					System.out.println("dao-101");
				}
			}
		}
		return ls;
		
	}
	
	
	
	public BoardVo selectOne(int qnano){
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "select \"QNANO\",\"FK_USERID\",\"QUESTIONTITLE\",\"QUESTIONCONTENTS\",\"QUESTIONDATE\",\"ANSWERTITLE\", \"ANSWERCONTENTS\",\"ANSWERDATE\" from \"TBL_QNA\" where \"QNANO\" =? " ; 
		BoardVo vo = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, qnano);
			rs = pstmt.executeQuery();
			if(rs.next()) {
			 vo = new BoardVo(
					    rs.getInt(1),
						rs.getString(2),
						rs.getString(3), 
						rs.getString(4),
				 		new Date(rs.getDate(5).getTime()),
						rs.getString(6),
						rs.getString(7),
						new Date(rs.getDate(8).getTime()) );
				
				
			}
			
		}catch(SQLException e) {
			e.printStackTrace();
		
		} finally {
			if(rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					e.printStackTrace();
				} 
			}
			
			if(pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException e) {
					 
					e.printStackTrace();
				} 
			}
			
			if(con != null) {
				try {
					con.close();
				} catch (SQLException e) {
					 
					e.printStackTrace();
				}
			}
		}
		return vo;
	}
	
}
