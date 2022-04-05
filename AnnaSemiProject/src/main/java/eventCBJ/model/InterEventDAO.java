package eventCBJ.model;

import java.sql.SQLException;
import java.util.ArrayList;

public interface InterEventDAO {

	ArrayList<EventVO> selectAll() throws SQLException;

	EventVO selectOne(int eventno) throws SQLException;

}
