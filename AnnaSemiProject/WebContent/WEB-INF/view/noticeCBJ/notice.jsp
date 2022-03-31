<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<style type="text/css">
 
/* table {
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
} */

	tr.noticeInfo:hover {
		background-color: gray;
		cursor: pointer;
	}
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
	});

</script>

<div class="container">
<div style="margin: 20% auto;">
 
<h2 style="margin: 20px;">::: 공지사항 목록 :::</h2>

	<form name="noticeFrm">
		<select id="searchType" name="searchType">
			<option value="">검색대상</option>
			<option value="noticeTitle">제목</option>
			<option value="noticeContents">내용</option>
		</select>
		<input type="text" id="searchWord" name="searchWord">
		<button type="button" onclick="goSearch();" style="margin-right: 30px">검색</button>
		<span style="color: red; font-weight: bold; font-size: 12pt;">페이지당 회원명수-</span>
		<select id="noitceSizePerPage" name="noitceSizePerPage">
		   <option value="10">10</option>
		   <option value="5">5</option>
		   <option value="3">3</option>
		</select>
	</form>
	<table id="noticeTbl" class="table table-bordered" style="width: 90%; margin-top: 20px;">
	<thead>
	   <tr>
	      <th>번호</th>
	      <th>제목</th>
	      <th>등록일</th>
	      <th>조회수</th>
	   </tr>
	</thead>
	
	<tbody>
		<c:forEach var="nvo" items="${requestScope.noticeList}">
			<tr class="noticeInfo">
			
				<td>${nvo.noticeNo}</td>
				<td><a href="<%= ctxPath%>/noticeDetail.an?noticeNo=${nvo.noticeNo}">${nvo.noticeTitle}</a></td>
				<td>${nvo.noticeDate}</td>
				<td>${nvo.cnt}</td>				
			</tr>
		</c:forEach>
	</tbody>
	</table>
	
	<nav class="my-5">
		<div style="display: flex; width: 80%;">
			<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
		</div>
	</nav>
		
</div>		
</div>



<jsp:include page="../common/footer.jsp"></jsp:include>
