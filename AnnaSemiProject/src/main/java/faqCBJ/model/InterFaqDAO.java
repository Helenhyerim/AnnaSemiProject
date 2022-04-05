package faqCBJ.model;

import java.sql.SQLException;
import java.util.ArrayList;

import noticeCBJ.model.NoticeVO;

public interface InterFaqDAO {

	ArrayList<FaqVO> selectAll() throws SQLException;

	

}
