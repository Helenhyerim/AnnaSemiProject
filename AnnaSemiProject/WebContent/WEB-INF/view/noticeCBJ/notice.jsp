<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="noticeCBJ.model.*, java.util.List"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	String ctxPath = request.getContextPath();
%>

<%
	NoticeDAO dao = new NoticeDAO();
	List<NoticeVO> ls = dao.selectAll();
	pageContext.setAttribute("ls", ls);
%>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<style type="text/css">
 
table {
	font-size : 14px;
} 

td, th {
	border-left:none;
	border-right:none;
	border-top: solid 1px gray;
	border-bottom: solid 1px gray;
	padding-right: 30px;
	padding-top: 20px;
	padding-bottom: 20px;
	color: gray;
}

div#regist {
	padding-top: 10px;
	float: right;

}

div#searchForm {
	padding-top: 10px;
}

button {
	background-color: black;
	color: white;
	border-line: solid 1px black;
	font-size: 14px;
	width: 100px;

}
button:hover {
	opacity: 0.7;
}

</style>

	<div class="container">
	  <div style="margin: 20% auto;">
		<h2 style="color: black; font-weight: bold;">Notice</h2>
			<table>
			<tr>
				<th style="width: 150px; text-align:center;">번호</th>
				<th style="width: 1000px;">제목</th>
				<th style="width: 300px; text-align:center;">등록일</th>
				<th style="width: 150px; text-align:center;">조회수</th>
			</tr>
			<c:forEach var="notice" items="${ls}">
			<tr>
				<td style="text-align:center;">${notice.noticeNo}</td>
				<td><a href="<%= ctxPath%>/noticeDetail.an?noticeNo=${notice.noticeNo}">${notice.noticeTitle}</a></td>
				<td style="text-align:center;">${ fn:substring(notice.noticeDate, 0, 10)}</td>
				<td style="text-align:center;">${notice.cnt}</td>
			</tr>
			</c:forEach>
			</table>
			<div id="regist">
				<a href="<%= ctxPath%>/noticeRegistForm.an"/><button>글등록</button></a>
			</div>
			<div id="searchForm">
				<form>
					<select name="option">
						<option value="0">제목</option>
						<option value="1">내용</option>
					</select>
					<input type="text" size="20" name="condition"/>&nbsp;
					<input type="submit" value="검색"/>
				</form>
			</div>
	  </div>		
	</div>



<jsp:include page="../common/footer.jsp"></jsp:include>
