<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<style type="text/css">

button.accordion {
	background-color: white;
	border:none;
	width: 100%;
	font-size:14px; 
	transition: 0.5s;
	vertical-align: top;
	
}

button.accordion.active{
	font-weight:bold;
	color : #000;
	
}


div.card-header {
	background-color : white;
	height:50px;
	
}

button.accordion:hover {    
    font-weight: bold;
    
}

div#contents {
	float:left; 
	text-align: left; 
	color: black;
	transition: ease-out;
}
	
button#regist {
	background-color: black;
	color: white;
	border-line: solid 1px black;
	font-size: 14px;
	width: 100px;
}
	
a {
	padding-right: 10px;
	padding-left: 10px;
}

ul.pagination a {
	border: none;
	font-weight: bold;
}

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("select#sizePerPage").val("${requestScope.sizePerPage}");
		
	});// end of $(document).ready(function(){})-----------------------------

</script>

<div class="container">
  <div style="margin: 20% auto;">
  
	<h2 style="color: black; font-weight: bold;">FaQ</h2>
		<div class="board_tab" style="margin: 20px auto;">			
			<a>전체</a>&#124;
			<a>사이즈가이드</a>&#124;
			<a>상품문의</a>&#124;
			<a>배송문의</a>&#124;
			<a>주문/결제</a>&#124;
			<a>교환/반품</a>&#124;
			<a>AS문의</a>	&#124;
			<a>회원관련</a>					
		</div>
		
		<table>
			<tr>
				<th style="width: 150px; text-align:center; color: black;">카테고리</th>
				<th style="width: 1000px; color: black;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목</th>			
			</tr>
		</table>
			<c:forEach var="faq" items="${requestScope.faqList}">
				<div class="accordion" id="accordion">
					<div class="card" style="border-left: none; border-right: none; " >
					  <div class="card-header" id="heading${faq.faqNo}">
					    <h2 class="accordion-header" >
					      <button class="accordion" type="button" data-toggle="collapse" data-target="#panel${faq.faqNo}" aria-expanded="true" aria-controls="panel${faq.faqNo}">
					        <div id=contents style="width: 100px; font-weight: bold;">${faq.faqRequestType}</div>
					        <div id=contents style="width: 800px;">&emsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${faq.faqTitle}</div>
					      </button>
					    </h2>
					</div>
				    <div id="panel${faq.faqNo}" class="accordion-collapse collapse" aria-labelledby="headingOne${faq.faqNo}" data-parent="#accordion">
				      <div class="accordion-body">
				        <img src="<%= ctxPath %>/imagesCBJ/${faq.faqNo}.png"/>
				      </div>
				    </div>
				  </div>
			</c:forEach>
		
		<c:if test="${sessionScope.loginuser.userid eq 'admin'}">
			<div id="regist" style="display:inline-block; float:right; padding:20px;"">
				<a href="<%= ctxPath%>/faqRegistForm.an"/><button id="regist">글등록</button></a>
			</div>
		</c:if>
		
		<nav class="my-5">
			<div style="display: flex; width: 100%;">
				<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
			</div>
		</nav>
		
  </div>		
</div>



<jsp:include page="../common/footer.jsp"></jsp:include>
