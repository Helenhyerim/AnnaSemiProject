<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="board.*, java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="vo" class="board.BoardVo"/>
<jsp:useBean id="dao" class="board.BoardDao"/>
<jsp:setProperty name="vo" property="*"/> 

<%
	dao.insert(vo); 
	response.sendRedirect(request.getContextPath() + "/board/list.jsp");
%>
<%-- <c:redirect url="${pageContext.request.contextPath}/board/list.jsp "></c:redirect> --%>

<%-- <%
	request.getParameter("title"); 
%> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html> 