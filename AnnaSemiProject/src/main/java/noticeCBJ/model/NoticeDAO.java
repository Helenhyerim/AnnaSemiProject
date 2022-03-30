package noticeCBJ.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class NoticeDAO implements InterNoticeDAO {

	private DataSource ds;    // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public NoticeDAO() {
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
	public int insert(NoticeVO vo) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_notice (noticeno, fk_userid, noticedate, noticetitle, noticecontents) "
					+ " values (seq_noticeno.nextval, 'admin', sysdate, ?, ?) ";			
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNoticeTitle());
			pstmt.setString(2, vo.getNoticeContents());			
			
			result = pstmt.executeUpdate(); // 잘 들어가면 숫자가 바뀔 것이다
			
		} finally {
			close();
		}
		
		return result;
	}
	
	// 조회(R)
	@Override
	public ArrayList<NoticeVO> selectAll() throws SQLException {
		
		
		ArrayList<NoticeVO> noticeList = new ArrayList<NoticeVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = "select noticeno, fk_userid, noticedate, noticetitle, noticecontents, cnt from tbl_notice order by noticeno desc ";
		
			pstmt = conn.prepareStatement(sql);			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				NoticeVO notice = new NoticeVO();
				notice.setNoticeNo(rs.getInt(1));
				notice.setFk_userId(rs.getString(2));
				notice.setNoticeDate(rs.getString(3));
				notice.setNoticeTitle(rs.getString(4));
				notice.setNoticeContents(rs.getString(5));
				notice.setCnt(rs.getInt(6));
				noticeList.add(notice);
			}
		} finally {
			close();
		}
		return noticeList;
	}
	/*
	// 수정(U)
	@Override
	public int update(NoticeVO vo) {
		
		int ret = -1; // 예외 발생시 리턴값
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_notice set noticetitle=?, noticecontents=? where noticeno=? ";
		
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNoticeTitle());
			pstmt.setString(2, vo.getNoticeContents());	
			pstmt.setInt(3, vo.getNoticeNo());
			
			ret = pstmt.executeUpdate(); // 잘 들어가면 숫자가 바뀔 것이다
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return ret;
	}*/
	
	/*
	public int update(int noticeNo, String noticeTitle, String noticeContents) {
		
		String sql = " update tbl_notice set noticetitle=?, noticecontents=? where noticeno=? ";
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, noticeTitle);
			pstmt.setString(2, noticeContents);
			pstmt.setInt(3, noticeNo);
			
			return pstmt.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return -1;
		
	}
	*/
	
	@Override
	public int update(int noticeNo, String noticeTitle, String noticeContents) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_notice set noticetitle=?, noticecontents=? where noticeno=? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, noticeTitle);
			pstmt.setString(2, noticeContents);
			pstmt.setInt(3, noticeNo);
			
			result = pstmt.executeUpdate();
		} finally {
			close();
		}
		return result;
		
	}
	
	// 조건 조회(R)
	@Override
	public NoticeVO selectOne(int noticeNo) throws SQLException {
			
		NoticeVO notice = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select noticeno, fk_userid, noticedate, noticetitle, noticecontents, cnt from tbl_notice where noticeno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, noticeNo);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				notice = new NoticeVO();		
				notice.setNoticeNo(rs.getInt(1));
				notice.setFk_userId(rs.getString(2));
				notice.setNoticeDate(rs.getString(3));
				notice.setNoticeTitle(rs.getString(4));
				notice.setNoticeContents(rs.getString(5));
				notice.setCnt(rs.getInt(6));
			}
		} finally {
			close();
		}
		return notice;
	}
	
	// 삭제(D)
	@Override
	public int delete(int noticeNo) throws SQLException {

		int result = 0;
		
		try {                                                                                                                                       
			conn = ds.getConnection();
			
			String sql = " delete from tbl_notice where noticeno = ? ";
			
			pstmt = conn.prepareStatement(sql);			
			pstmt.setInt(1, noticeNo);
			result = pstmt.executeUpdate(); // 잘 들어가면 숫자가 바뀔 것이다
		} finally {
			close();
		}
		return result;
	}
	
	// 조회수 증가
	@Override
	public int updateCnt(int noticeNo) {
		
		int ret = -1; // 예외 발생시 리턴값
		
		try {
			conn = ds.getConnection();
			
			String sql = "update tbl_notice set cnt = cnt + 1 where noticeno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, noticeNo);
			rs = pstmt.executeQuery();
			
			ret = pstmt.executeUpdate();
			
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return ret;
	}
	
}
