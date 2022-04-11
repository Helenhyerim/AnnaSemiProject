package qnaCBJ.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import faqCBJ.model.FaqVO;

public interface InterQnaDAO {

	int getTotalPage(Map<String, String> paraMap) throws SQLException;


	List<QnaVO> selectPagingQna(Map<String, String> paraMap) throws SQLException;


	ArrayList<QnaVO> selectAll() throws SQLException;


	int insert(QnaVO vo) throws SQLException;


}
