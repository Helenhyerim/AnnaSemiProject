package eventCBJ.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import faqCBJ.model.FaqVO;

public interface InterEventDAO {

	ArrayList<EventVO> selectAll() throws SQLException;

	EventVO selectOne(int eventno) throws SQLException;

	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	List<EventVO> selectPagingEvent(Map<String, String> paraMap) throws SQLException;

	int delete(int eventNo) throws SQLException;

	int getEnumOfEvent() throws SQLException;

	int eventInsert(EventVO evo) throws SQLException;

}
