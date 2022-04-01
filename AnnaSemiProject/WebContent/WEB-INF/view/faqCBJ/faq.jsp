<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="faqCBJ.model.*, java.util.List"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	String ctxPath = request.getContextPath();
%>

<%
	FaqDAO dao = new FaqDAO();
	List<FaqVO> ls = dao.selectAll();
	pageContext.setAttribute("ls", ls);
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

</style>

<script type="text/javascript">

//Collapse로 화면이 펼치기 전에 호출
$('.collapse').on('show.bs.collapse', function () {
	
	// icon을 + 마크로 변경한다.
	var target = $("[href='#"+$(this).prop("id")+"']");
	target.removeClass("fa-plus-square");
	target.addClass("fa-minus-square");
	
});

// Collapse로 화면이 펼친 후에 호출
$('.collapse').on('shown.bs.collapse', function () {
	
	// icon을 + 마크로 변경한다.
	var target = $("[href='#"+$(this).prop("id")+"']");
	target.removeClass("fa-plus-square");
	target.addClass("fa-minus-square");
	
});

// Collapse로 화면에 접기 전에 호출
$('.collapse').on('hide.bs.collapse', function () {
	
	// icon을 - 마크로 변경한다.
	var target = $("[href='#"+$(this).prop("id")+"']");
	target.removeClass("fa-minus-square");
	target.addClass("fa-plus-square");
	
});

// Collapse로 화면에 접고 난 후에 호출
$('.collapse').on('hidden.bs.collapse', function () {
	
	// icon을 - 마크로 변경한다.
	var target = $("[href='#"+$(this).prop("id")+"']");
	target.removeClass("fa-minus-square");
	target.addClass("fa-plus-square");
	
});


</script>

<div class="container">
  <div style="margin: 20% auto;">
  
	<h2 style="color: black; font-weight: bold;">FaQ</h2>
	
		<div>
			<i class="fa fa-plus-square" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample"></i>
			<span style="margin-left:10px;">Click</span>
		</div>
		<div class="collapse" id="collapseExample">
			<div class="well">
				hello world
			</div>
		</div>

		<table>
		<tr>
			<th style="width: 150px; text-align:center;">카테고리</th>
			<th style="width: 1000px;">제목</th>			
		</tr>
		<c:forEach var="faq" items="${ls}">
		<tr>
			<td class="fa fa-plus-square" data-toggle="collapse" href="#collapseExample" aria-expanded="false" aria-controls="collapseExample" style="text-align:center;">${faq.faqRequestType}</td>
			<td><a href="<%= ctxPath%>/faqDetail.an?faqNo=${faq.faqNo}">${faq.faqTitle}</a></td>
		</tr>
		</c:forEach>
		</table>
		
		<nav class="my-5">
			<div style="display: flex; width: 80%;">
				<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
			</div>
		</nav>
		
		<div id="regist">
			<a href="<%= ctxPath%>/noticeRegistForm.an"/><button>글등록</button></a>
		</div>		
  </div>		
</div>



<jsp:include page="../common/footer.jsp"></jsp:include>
