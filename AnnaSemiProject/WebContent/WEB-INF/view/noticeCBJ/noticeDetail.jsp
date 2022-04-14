<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="noticeCBJ.model.*, java.util.List"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	String ctxPath = request.getContextPath();
%>

<%
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	NoticeVO vo = new NoticeDAO().selectOne(noticeNo);
	NoticeDAO dao = new NoticeDAO();
	/* int result = dao.delete(noticeNo); */
	pageContext.setAttribute("vo", vo);
	
%>

<style type="text/css">
	div.topbar {
		border: solid 1px #ccc;
		border-right: none;
		border-left: none;
		padding-top: 10px;
		padding-bottom: 10px;
		display: inline-block;
		width: 100%;			
	}
	div#noitceinfo {
		display: inline-block;
		font-size: 20px;
	}
	
	div {
		color: black;
	}
	
	button#modify,#delete {
		background-color: black;
		color: white;
		border-line: solid 1px black;
		font-size: 14px;
		width: 100px;
	}
	
	button#delete:hover {
		opacity : 0.7;
	}
	
	button#modify:hover {
		opacity : 0.7;
	}
</style>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<div class="container">
  <div style="margin: 20% auto;">
	<h2 style="margin: 20px auto; font-weight: bold; color: black;">Notice</h2>
		<div class="topbar">
			<div id="noitceinfo">
				${vo.noticeTitle}
			</div>
			<div id="noitceinfo" style="float: right; ">
				<div id="noitceinfo"  style="font-size: 13px; ">
					${fn:substring(vo.noticeDate, 0, 10)}
				</div>
				&nbsp;				
				<div id="noitceinfo" style="float: right; ">
					<button type="button" id=menu class="btn btn-default btn-lg" 
							aria-label="Left Align" 
							onclick="location.href='<%= ctxPath %>/notice.an'">
						<i class="fas fa-bars"></i>
					</button>
				</div>
				
			</div>
		</div>
		<div style="padding: 20px;">
			${vo.noticeContents}
		</div>
		
		<c:if test="${sessionScope.loginuser.userid eq 'admin'}">
			<div style="float: right; padding: 20px;">
				<a href="<%=ctxPath %>/noticeEditForm.an?noticeNo=${vo.noticeNo}"><button id="modify">수정</button></a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="<%=ctxPath %>/noticeDelete.an?noticeNo=${vo.noticeNo}">
					<button id="delete">삭제</button>
				</a>
			</div>
		</c:if>
	</div>		
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>
