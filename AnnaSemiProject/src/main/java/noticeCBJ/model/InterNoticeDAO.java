package noticeCBJ.model;

import java.sql.SQLException;
import java.util.ArrayList;

public interface InterNoticeDAO {

	ArrayList<NoticeVO> selectAll() throws SQLException;

	NoticeVO selectOne(int noticeNo) throws SQLException;

	int insert(NoticeVO vo) throws SQLException;

	int updateCnt(int noticeNo) throws SQLException;

//	int update(int noticeNo) throws SQLException;

	int update(int noticeNo, String noticeTitle, String noticeContents) throws SQLException;

	int delete(int noticeNo) throws SQLException;

//	int update(NoticeVO vo)  throws SQLException;

//	int update(int noticeNo, String noticeTitle, String noticeContents) throws SQLException;
}
