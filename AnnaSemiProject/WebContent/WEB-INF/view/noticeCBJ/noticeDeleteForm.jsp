<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>
    
<jsp:include page="../common/header_login.jsp"></jsp:include>

	<div class="container">
	  <div style="width: 80%; margin: 20%; auto;">
		<title>글 삭제</title>				
		<form action="<%= ctxPath %>/noticeRegist.an" method="post">
			<input type="text" name="noticeTitle" placeholder="제목" required><br>
			<textarea rows="4" cols="20" name="noticeContents" placeholder="내용"></textarea><br>
			<input type="submit" value="등록">
		</form>
	  </div>

<jsp:include page="../common/footer.jsp"></jsp:include>