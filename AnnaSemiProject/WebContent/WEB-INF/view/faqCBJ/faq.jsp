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

button#modify,#delete {
	background-color: black;
	color: white;
	border-line: solid 1px black;
	font-size: 14px;
	width: 100px;
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
	  	<jsp:include page="faqCategoryList.jsp"></jsp:include><br/><br/>
		
		
			<c:forEach var="faq" items="${requestScope.faqList}">
				<div class="accordion" id="accordion">
					<div class="card" style="border-left: none; border-right: none; " >
					  <div class="card-header" id="heading${faq.faqno}">
					    <h2 class="accordion-header" >
					      <button class="accordion" type="button" data-toggle="collapse" data-target="#panel${faq.faqno}" aria-expanded="true" aria-controls="panel${faq.faqno}">
					        <div id=contents style="width: 100px; font-weight: bold;">${faq.cname}</div>
					        <div id=contents style="width: 800px;">&emsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${faq.faqtitle}</div>
					      </button>
					    </h2>
					</div>
				    <div id="panel${faq.faqno}" class="accordion-collapse collapse" aria-labelledby="headingOne${faq.faqno}" data-parent="#accordion">
				      <div class="accordion-body">
				        <img src="/AnnaSemiProject/imagesCBJ/${faq.faqimg}"/>
				        <c:if test="${sessionScope.loginuser.userid eq 'admin'}">
							<div style="float: right; padding: 20px;">
								<a href="<%=ctxPath %>/faqEditForm.an?faqNo=${faq.faqimg}"><button id="modify">??????</button></a>
								<a onclick="return confirm('????????? ?????????????????????????')" href="<%=ctxPath %>/faqDelete.an?faqNo=${faq.faqno}"><button id="delete">??????</button></a>
							</div> 
						</c:if>
				      </div>
				    </div>
				  </div>
			</c:forEach>
		
		<c:if test="${sessionScope.loginuser.userid eq 'admin'}">
			<div id="regist" style="display:inline-block; float:right; padding:20px;"">
				<a href="<%= ctxPath%>/faqRegistForm.an"/><button id="regist">?????????</button></a>
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