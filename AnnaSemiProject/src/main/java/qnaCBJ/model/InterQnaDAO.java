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

	//내가 작성한 총작성 페이지 개수 조회하기
	int getMyTotalPage(Map<String, String> paraMap) throws SQLException;

	//내가 작성한 글 조회하기
	List<QnaVO> selectPagingmyQna(Map<String, String> paraMap) throws SQLException;

}
