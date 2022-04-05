package eventCBJ.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import faqCBJ.model.FaqVO;
import noticeCBJ.model.NoticeVO;

public class EventDAO implements InterEventDAO {

	private DataSource ds;    // DataSource ds 는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public EventDAO() {
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
	public ArrayList<EventVO> selectAll() throws SQLException {
		
		ArrayList<EventVO> eventList = new ArrayList<EventVO>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select eventno, userid, registdate, eventtitle, eventstartdate, eventenddate, eventimg1, eventimg2, thumbnail from tbl_event order by eventno ";
			
			pstmt = conn.prepareStatement(sql);			
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				EventVO event = new EventVO();
				event.setEventNo(rs.getInt(1));
				event.setUserId(rs.getString(2));
				event.setRegistDate(rs.getString(3));
				event.setEventTitle(rs.getString(4));
				event.setEventStartdate(rs.getString(5));
				event.setEventEnddate(rs.getString(6));
				event.setEventImg1(rs.getString(7));
				event.setEventImg2(rs.getString(8));
				event.setThumbNail(rs.getString(9));
				eventList.add(event);
			}
		} finally {
			close();
		}
		return eventList;
	}
	
	// 조건 조회(R)
	@Override
	public EventVO selectOne(int eventno) throws SQLException {
			
		EventVO event = null;
		
		try {
			conn = ds.getConnection();
			
			String sql = "select eventno, userid, registdate, eventtitle, eventstartdate, eventenddate, eventimg1, eventimg2, thumbnail from tbl_event where eventno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, eventno);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				event = new EventVO();		
				event.setEventNo(rs.getInt(1));
				event.setUserId(rs.getString(2));
				event.setRegistDate(rs.getString(3));
				event.setEventTitle(rs.getString(4));
				event.setEventStartdate(rs.getString(5));
				event.setEventEnddate(rs.getString(6));
				event.setEventImg1(rs.getString(7));
				event.setEventImg2(rs.getString(8));
				event.setThumbNail(rs.getString(9));
			}
		} finally {
			close();
		}
		return event;
	}
}
