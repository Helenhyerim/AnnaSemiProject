<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="noticeCBJ.model.*, java.util.List"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	String ctxPath = request.getContextPath();
%>

<%
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	NoticeVO vo = new NoticeDAO().selectOne(noticeNo);
	NoticeDAO dao = new NoticeDAO();
	/* int result = dao.delete(noticeNo); */
	pageContext.setAttribute("vo", vo);
%>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<div class="container">
  <div style="margin: 20% auto;">
	<h3 style="color: black; font-weight: bold;">글 정보</h3>
		<p>번호:${vo.noticeNo}</p>
		<p>제목:${vo.noticeTitle}</p>
		<p>작성자:${vo.fk_userId}</p>
		<p>내용:${vo.noticeContents}</p>
		<p>등록일자:${vo.noticeDate}</p>
		<p>조회수:${vo.cnt}</p>	
		<a href="<%=ctxPath %>/noticeEditForm.an?noticeNo=${vo.noticeNo}"><button>수정</button></a>
		<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="<%=ctxPath %>/noticeDelete.an?noticeNo=${vo.noticeNo}"><button>삭제</button></a>
  </div>		
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>
