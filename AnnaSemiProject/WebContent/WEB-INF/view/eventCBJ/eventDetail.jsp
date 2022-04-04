<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="eventCBJ.model.*, java.util.List"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	String ctxPath = request.getContextPath();
%>

<%
	int eventNo = Integer.parseInt(request.getParameter("eventNo"));
	EventVO vo = new EventDAO().selectOne(eventNo);
	EventDAO dao = new EventDAO();
	pageContext.setAttribute("vo", vo);
%>
  
<style type="text/css">
	div.card {
		border-right: none;
		border-left: none;
		padding-top: 15px;
		padding-bottom: 15px;
		display: inline-block;
		width: 100%;
	}
	
	div#eventinfo {
		display: inline-block;
		font-size: 20px;
	}
	img {
		width: 100%;
	}
	
</style>

<jsp:include page="../common/header_login.jsp"></jsp:include>

	<div class="container">
	  <div style="margin: 20% auto;">
	  <h4 style="text-align: center; color: black;">이벤트</h4>	
	  	<div class="card">  
			<div id="eventinfo" style="color: black;">
				${vo.eventTitle} 
			</div>
			<div id="eventinfo" style="float: right; ">
				<c:if test="${not empty vo.eventStartdate}">
					<div id="eventinfo"  style="font-size: 13px; ">
						${fn:substring(vo.eventStartdate, 0, 10)} ~ ${fn:substring(vo.eventEnddate, 0, 10)}
					</div>
				</c:if>
				&nbsp;
				<div id="eventinfo" style="float: right; ">
					<button type="button" id=menu class="btn btn-default btn-lg" aria-label="Left Align" onclick="location.href='<%= ctxPath %>/event.an'">
						<i class="fas fa-bars"></i>
					</button>
				</div>
			</div>
		</div>
		<br/>
		
			<br/><br/>
			<c:if test="${empty vo.eventImg2}">
				<div>
					<img src="<%= ctxPath %>/imagesCBJ/${vo.eventImg1}">					
				</div>
			</c:if>
			<c:if test="${not empty vo.eventImg2}">
				<div>
					<img src="<%= ctxPath %>/imagesCBJ/${vo.eventImg1}">
					<img src="<%= ctxPath %>/imagesCBJ/${vo.eventImg2}">
				</div>
			</c:if>
	  </div>		
	</div>

<jsp:include page="../common/footer.jsp"></jsp:include>
