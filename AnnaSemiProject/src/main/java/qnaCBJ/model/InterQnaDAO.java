package qnaCBJ.model;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

public interface InterQnaDAO {


	List<QnaVO> selectPagingQna(Map<String, String> paraMap) throws SQLException;

	int getTotalPage(Map<String, String> paraMap) throws SQLException;

	int getEnumOfQna() throws SQLException;

	int questionInsert(QnaVO qvo) throws SQLException;

	QnaVO selectOne(int qnano) throws SQLException;

	int answerInsert(QnaVO qvo) throws SQLException;

	int questionUpdate(QnaVO qvo) throws SQLException;

	int delete(int qnaNo) throws SQLException;

}
