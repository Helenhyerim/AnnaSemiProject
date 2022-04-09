package eventCBJ.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
	
	@Override
	public int delete(int eventNo) throws SQLException {

		int result = 0;
		
		try {                                                                                                                                       
			conn = ds.getConnection();
			
			String sql = " delete from tbl_event where eventno = ? ";
			
			pstmt = conn.prepareStatement(sql);			
			pstmt.setInt(1, eventNo);
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
					   + " from tbl_event";
			
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
	public List<EventVO> selectPagingEvent(Map<String, String> paraMap) throws SQLException {
		
		List<EventVO> eventList = new ArrayList<>();
		
		try {
			conn = ds.getConnection();
			
			String sql = " select eventno, eventtitle "
						+ " from "
						+ " ( "
						+ "    select rownum AS rno, eventno, eventtitle "
						+ "    from "
						+ "    ( "
						+ "        select eventno, eventtitle "
						+ "        from tbl_event "			
						+ "        order by eventno "
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
				
				EventVO evo = new EventVO();
				evo.setEventNo(rs.getInt(1));
				evo.setEventTitle(rs.getString(1));
				
				eventList.add(evo);
			}// end of while--------------------------------
		
		} finally {
			close();
		}
		
		return eventList;
	}

	@Override
	public int getEnumOfEvent() throws SQLException {

		int eventNo = 0;
		
		try {
			 conn = ds.getConnection();
			 
			 String sql = " select seq_eventno.nextval "
			 			+ " from dual ";
			 
			 pstmt = conn.prepareStatement(sql);			 
			 
			 rs = pstmt.executeQuery();			 
			 
			 rs.next();
			 eventNo = rs.getInt(1);
			 
		} finally {
			close();
		}
		
		return eventNo;
	}

	@Override
	public int eventInsert(EventVO evo) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " insert into tbl_event(eventno, userid, registdate, eventtitle, eventstartdate, eventenddate, eventimg1, eventimg2, thumbnail) "
						+ " values(?, 'admin', sysdate, ?, ?, ?, ?, ?, ?) ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, evo.getEventNo());
			pstmt.setString(2, evo.getEventTitle());
			pstmt.setString(3, evo.getEventStartdate());
			pstmt.setString(4, evo.getEventEnddate());
			pstmt.setString(5, evo.getEventImg1());
			pstmt.setString(6, evo.getEventImg2());
			pstmt.setString(7, evo.getThumbNail());
			
	        result = pstmt.executeUpdate();
	        
		} finally {
			close();
		}
		
		return result;
	}

	@Override
	public int eventUpdate(EventVO evo) throws SQLException {

		int result = 0;
		
		try {
			conn = ds.getConnection();
			
			String sql = " update tbl_event set eventtitle = ?, eventstartdate =  ?, eventenddate = ?, "
					   + " eventimg1 = ?, eventimg2 = ?, thumbnail = ? "
					   + " where eventno = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, evo.getEventTitle());
			pstmt.setString(2, evo.getEventStartdate());
			pstmt.setString(3, evo.getEventEnddate());
			pstmt.setString(4, evo.getEventImg1());
			pstmt.setString(5, evo.getEventImg2());
			pstmt.setString(6, evo.getThumbNail());
			pstmt.setInt(7, evo.getEventNo());
			
	        result = pstmt.executeUpdate();
	        
		} finally {
			close();
		}
		
		return result;
	}
	
	
}
