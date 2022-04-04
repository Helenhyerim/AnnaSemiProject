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

</style>

<script type="text/javascript">

	$(document).ready(function(){

	

	});

</script>

<div class="container">
	<div style=" margin: 20% auto;">
	<h4>이벤트</h4>	  
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
	</div>
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>
