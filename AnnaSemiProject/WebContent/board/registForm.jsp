<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String ctxPath = request.getContextPath();
    
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<jsp:include page="../header_annadia.jsp"/>

<div style = "margin: 17% 24%">
<form action="regist.jsp" method="post"> 
	<input type="text" name="questiontitle" placeholder="제목" required><br>
	<!-- <input type="text" name="fk_userid" placeholder="작성자" required><br> -->
	<textarea rows="40" cols="80" name="questioncontents" placeholder="내용"></textarea><br>
	<input type="submit" value="등록">
	
	
	<div style="padding: 0 47%;">

<%-- <%= ctxPath%> --%>
    <a href="list.jsp">
        <input type="button" value="글 목록">
    </a>
    </div>
</form>	
</div>
</body>

</html>