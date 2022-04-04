package myshop.model;

import java.sql.SQLException;
import java.util.*;

public interface InterProductDAO {

	// 시작(메인)페이지에 보여주는 상품이미지파일명을 모두 조회하는 메소드
	// DTO(Data Transfer Object) == VO(Value Object)
	List<ImageVO> imageSelectAll() throws SQLException;
}
