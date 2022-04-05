<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
<jsp:include page="header_annadia.jsp"></jsp:include>



 
<div style = "margin: 20% 48%">
    <h1 style= " font-size: 24pt;" >
     	<a href="<%= ctxPath%>/board/list.jsp">qna게시판 진입용 임시버튼</a>
    </h1>
</div>
     
</html>

