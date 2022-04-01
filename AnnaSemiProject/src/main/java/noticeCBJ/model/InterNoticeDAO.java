package noticeCBJ.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public interface InterNoticeDAO {

	ArrayList<NoticeVO> selectAll() throws SQLException;

	NoticeVO selectOne(int noticeNo) throws SQLException;

	int insert(NoticeVO vo) throws SQLException;

	int updateCnt(int noticeNo) throws SQLException;

	int delete(int noticeNo) throws SQLException;

	int update(NoticeVO vo) throws SQLException;

	List<NoticeVO> noticeSelectPagingMember(Map<String, String> paraMap) throws SQLException;

	int noticeGetTotalPage(Map<String, String> paraMap) throws SQLException;
}
