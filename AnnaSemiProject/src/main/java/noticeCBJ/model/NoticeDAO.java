package noticeCBJ.model;

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

	// 수정(U)
	@Override
	public int update(NoticeVO vo) throws SQLException {
		
		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_notice set noticetitle = ?, noticecontents = ? where noticeno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, vo.getNoticeTitle());
			pstmt.setString(2, vo.getNoticeContents());
			pstmt.setInt(3, vo.getNoticeNo());
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

	@Override
	public List<NoticeVO> noticeSelectPagingMember(Map<String, String> paraMap) throws SQLException {
		
		List<NoticeVO> noticeList = new ArrayList<>();

		try {
			conn = ds.getConnection();
			
			String sql = " select noticeno, noticedate, noticetitle, cnt "
					+ " from "
					+ " ("
					+ " 	select rownum AS rno, noticeno, noticedate, noticetitle, cnt "
					+ " 	from "
					+ " 	( "
					+ " 		select noticeno, noticedate, noticetitle, cnt "
					+ " 		from tbl_notice "
					+ " 		where fk_userid = 'admin' ";
					
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
				sql += " and "+colname+" like '%'|| ? ||'%' ";
			/*  
			    위치홀더(?) 에 들어오는 값은 데이터값만 들어올 수 있는 것이지
			    위치홀더(?) 에 컬럼명이나 테이블명이 들어오면 오류가 발생한다.
			    그러므로 컬럼명이나 테이블명이 변수로 사용할때는 위치홀더(?)가 아닌 변수로 처리해야 한다.  	
			*/
			}
			
			sql += " 		order by noticedate desc "
				+ " 	) V "
				+ " ) T "
				+ " where rno between ? and ? ";
			
			
			pstmt = conn.prepareStatement(sql);
			
			int noticeCurrentShowPageNo = Integer.parseInt(paraMap.get("noticeCurrentShowPageNo"));
			int noticeSizePerPage = Integer.parseInt(paraMap.get("noticeSizePerPage"));
			
			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
		 		
				pstmt.setString(1, searchWord);						
		 		pstmt.setInt(2, (noticeCurrentShowPageNo * noticeSizePerPage) -(noticeSizePerPage - 1));
				pstmt.setInt(3, (noticeCurrentShowPageNo * noticeSizePerPage));
		 	}
		 	else {
		 		pstmt.setInt(1, (noticeCurrentShowPageNo * noticeSizePerPage) -(noticeSizePerPage - 1));
				pstmt.setInt(2, (noticeCurrentShowPageNo * noticeSizePerPage));
		 	}
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
				NoticeVO nvo = new NoticeVO();
				nvo.setNoticeNo(rs.getInt(1));
				nvo.setNoticeDate(rs.getString(2));
				nvo.setNoticeTitle(rs.getString(3));
				nvo.setCnt(rs.getInt(4));
				
				noticeList.add(nvo);
			}// end of while -----------------------------------------------------
			
		} finally {
			close();
		}
		
		return noticeList;
	}

	@Override
	public int noticeGetTotalPage(Map<String, String> paraMap) throws SQLException {
		
		int totalPage = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " select ceil( count(*)/? ) "
					   + " from tbl_notice "
					   + " where fk_userid = 'admin' ";
			
			String colname = paraMap.get("searchType");
			String searchWord = paraMap.get("searchWord");
			
			if(colname != null && !"".equals(colname) && searchWord != null && !"".equals(searchWord)) {
				
				sql += " and "+colname+" like '%'|| ? ||'%' ";
			
			}
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, paraMap.get("noticeSizePerPage"));
			
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

	
	
}
