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

button.accordion {
	background-color: white;
	border:none;
	width: 100%;
	font-size:14px; 
	transition: 0.5s;
	vertical-align: top
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

</style>

<script type="text/javascript">

</script>

<div class="container">
  <div style="margin: 20% auto;">
  
	<h2 style="color: black; font-weight: bold;">FaQ</h2>		
		<table>
			<tr>
				<th style="width: 150px; text-align:center; color: black;">카테고리</th>
				<th style="width: 1000px; color: black;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;제목</th>			
			</tr>
		</table>
			<c:forEach var="faq" items="${ls}">
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
