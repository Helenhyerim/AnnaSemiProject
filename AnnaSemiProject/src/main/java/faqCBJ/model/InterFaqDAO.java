package faqCBJ.model;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import noticeCBJ.model.NoticeVO;

public interface InterFaqDAO {

	ArrayList<FaqVO> selectAll() throws SQLException;

	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	List<FaqVO> selectPagingFaq(Map<String, String> paraMap) throws SQLException;

	int delete(int faqNo) throws SQLException;

	int getFnumOfFaq() throws SQLException;

	int faqInsert(FaqVO evo) throws SQLException;

	List<HashMap<String, String>> getFaqCategoryList() throws SQLException;


}
