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
		
		$("select#noitceSizePerPage").bind("change", function(){
			const frm = document.noticeFrm;
			frm.action = "notice.an";
			frm.method = "get";
			frm.submit();
		});
		
		$("select#noitceSizePerPage").val("${requestScope.noitceSizePerPage}");
		
		$("form[name='noticeFrm']").submit(function(){
			if($("select#searchType").val() == "") {
				alert("검색대상을 올바르게 선택하세요!!");
				return false; // return false; 는 submit을 하지말라는 것이다.
			}
			
			if($("input#searchWord").val().trim() == "") {
				alert("검색어는 공백만으로는 되지 않습니다.\n검색어를 올바르게 입력하세요!!");
				return false; // return false; 는 submit을 하지말라는 것이다.
			}
		});
		
		$("input#searchWord").bind("keyup", function(event){
			if(event.keyCode == 13) {
				// 검색어에서 엔터를 치면 검색하러 가도록 한다.
				goSearch();
			}
		});
		
		if("${requestScope.searchType}" != "") { 
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
	    }		
		
		
	});

	function goSearch() {
		
		if($("select#searchType").val() == "") {
			alert("검색대상을 올바르게 선택하세요!!");
			return; // return; 는 goSearch() 함수 종료이다.
		}
		
		if($("input#searchWord").val().trim() == "") {
			alert("검색어는 공백만으로는 되지 않습니다.\n검색어를 올바르게 입력하세요!!");
			return; // return; 는 goSearch() 함수 종료이다.
		}
		
		const frm = document.noticeFrm;
		frm.action = "notice.an";
		frm.method = "get";
		frm.submit();
	}

</script>

<div class="container">
<div style="margin: 20% auto;">
 
<h2 style="margin: 20px;">Notice</h2>

	<form name="noticeFrm" action="notice.an" method="get">
		<select id="searchType" name="searchType">
			<option value="">검색대상</option>
			<option value="noticeTitle">제목</option>
			<option value="noticeContents">내용</option>
		</select>
		<input type="text" id="searchWord" name="searchWord">
		
		<input type="text" style="display: none;" />
	<%-- <button type="button" onclick="goSearch();" style="margin-right: 30px">검색</button> --%>
		
		<input type="submit" value="검색" style="margin-right: 30px" /> 
		<span style="color: red; font-weight: bold; font-size: 12pt;">페이지당 공지사항수-</span>
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
			<c:if test="${not empty requestScope.noticeList}">
				<c:forEach var="nvo" items="${requestScope.noticeList}">
					<tr class="noticeInfo">
					
						<td class="noticeno">${nvo.noticeNo}</td>
						<td><a href="<%= ctxPath%>/noticeDetail.an?noticeNo=${nvo.noticeNo}">${nvo.noticeTitle}</a></td>
						<td>${nvo.noticeDate}</td>
						<td>${nvo.cnt}</td>				
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty requestScope.noticeList}">
	           	<tr>
	           		<td colspan="4" style="text-align: center;">검색된 데이터가 존재하지 않습니다.</td>
	           	</tr>
	        </c:if>
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
