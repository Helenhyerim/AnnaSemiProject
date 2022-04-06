<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="eventCBJ.model.*, java.util.List"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	String ctxPath = request.getContextPath();
%>

<%
	EventDAO dao = new EventDAO();
	List<EventVO> ls = dao.selectAll();
	pageContext.setAttribute("ls", ls);
%>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<style type="text/css">

	img.img-thumbnail {
		border:none;
	}
	img.img-thumbnail:hover {
		opacity: 0.7;
	}

	button#regist {
		background-color: black;
		color: white;
		border-line: solid 1px black;
		font-size: 14px;
		width: 100px;
	}
	
	ul.pagination a {
		border: none;
		font-weight: bold;
	}

</style>

<script type="text/javascript">

	$(document).ready(function(){

		$("select#sizePerPage").val("${requestScope.sizePerPage}");

	});

</script>

<div class="container">
	<div style=" margin: 20% auto;">
	<h2 style="margin: 20px auto; font-weight: bold; color: black;">Event</h2>	
		<!-- 썸네일 시작(이미지에 보더가 생기는 것임) -->
	     <div class="row" >
			<c:forEach var="event" items="${ls}">	     
		     	 <div class="col-sm-4 col-lg-4 mb-3">	     	 
		     	    <div>
		     	    	<a href = "<%= ctxPath %>/eventDetail.an?eventNo=${event.eventNo}">
							<img src="<%= ctxPath %>/imagesCBJ/${event.thumbNail}.jpg" alt="thumbnail" class="img-thumbnail" type="button" width="350">
						</a>
						<div>
							<br/>
							<h6>${event.eventTitle}</h6>							
							<c:if test="${not empty event.eventStartdate}">
								<p style="font-size: 12px;">${fn:substring(event.eventStartdate, 0, 10)} ~ ${fn:substring(event.eventEnddate, 0, 10)}
							</c:if>
							</p>
						</div>
					</div>
		     	 </div>
			</c:forEach>
		</div>
			
		<c:if test="${sessionScope.loginuser.userid eq 'admin'}">
			<div id="regist" style="display:inline-block; float:right; padding:20px;"">
				<a href="<%= ctxPath%>/eventRegistForm.an"/><button id="regist">글등록</button></a>
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
