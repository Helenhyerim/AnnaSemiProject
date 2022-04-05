<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="board.*, java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% 
	  BoardDao dao = new BoardDao();  
	 List<BoardVo> ls = dao.selectAll();  
	 pageContext.setAttribute("ls",ls); 
%>

<%
	String ctxPath = request.getContextPath();
   
%>
<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Insert title here</title>

<style type="text/css">

    div#container {
    
    	width: 70%;
    	margin: 50px auto;
    } 

    div#container > table {
    	width: 100%;
    }

	table, th, td {
		border: solid 1px gray;
		border-collapse: collapse;
	}
	
	th {
		height: 80px;
		background-color: #ccc;
	}
	
	td {
		height: 100px;
	}
	
	td.mycenter {
		text-align: left;
	}
	
	td.myright {
		text-align: right;
	}

</style>

</head>

<body>

<jsp:include page="../header_annadia.jsp"/>

<div style = "margin: 24% 48% 0% 48%">
     <h1 style= " font-size: 24pt;" >
     QNA
     </h1>
     </div>
  


<!-- <html> -->
<head>
<meta charset="UTF-8">
<title>목록</title>
</head>
<body>


<div style = "margin: 1% 20%;">

<table width="100%">
<tr>

	<!-- <th>번호</th>
	<th>작성자</th>
	<th>문의제목</th>
	<th>문의내용</th>
	<th>문의날짜</th>
	<th>답변제목</th>
	<th>답변내용</th>
	<th>답변날짜</th>
	</tr>
	 -->
	<th width="50">번호</th>
	<th>제목</th>
	<th width="100">작성자</th>
	<th width="100">작성일</th>
	<th width="100">조회수</th>
	
	</tr>
   

<c:forEach var="TBL_QNA" items="${ls}">


<%-- <tr>
	<td>${TBL_QNA.qnano}</td>
	<td>${TBL_QNA.fk_userid} </td>
	<td> <a href="<%= ctxPath%>/board/boardDetail.jsp?qnano=${TBL_QNA.qnano}">${TBL_QNA.questiontitle}</a></td>
	<td>${TBL_QNA.questioncontents}</td>
	<td>${TBL_QNA.questiondate}</td> 
	<td>${TBL_QNA.answertitle}</td>
	<td>${TBL_QNA.answercontents}</td>
	<td>${TBL_QNA.answerdate}</td>
</tr>
 --%>
 
<tr>
	<td>${TBL_QNA.qnano}</td>
	<td> <a href="<%= ctxPath%>/board/boardDetail.jsp?qnano=${TBL_QNA.qnano}">${TBL_QNA.questiontitle}</a></td>
	<td>${TBL_QNA.fk_userid} </td>
	<td>${TBL_QNA.questiondate}</td> 
	<td>조회수(칼럼이아직없음)</td>
</tr>


</c:forEach>
</table>
</div>
<a href="<c:url value="registForm.jsp"/>"><button>글등록</button></a>


</body>

</html>