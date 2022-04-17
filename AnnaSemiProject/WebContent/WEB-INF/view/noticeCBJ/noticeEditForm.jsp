<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="noticeCBJ.model.*"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
	String ctxPath = request.getContextPath();
%>

<%-- <jsp:useBean id="dao" class="noticeCBJ.model.NoticeDAO"/> --%>

<%
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	NoticeDAO dao = new NoticeDAO();
	NoticeVO vo = dao.selectOne(noticeNo);
	pageContext.setAttribute("vo", vo);		
%>

<style type="text/css">

	input#modify, input#cancel {
		background-color: black;
		color: white;
		border-line: solid 1px black;
		font-size: 14px;
		width: 100px;
		margin: 5px;
	}
	
</style>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<script type="text/javascript">

</script>

<div class="container">
  <div style="margin: 20% auto;">
	<h2 style="margin: 20px auto; font-weight: bold; color: black;">Notice</h2>
	<form action="<%=ctxPath %>/noticeEdit.an" method="post" name="noticeUpdateFrm">
		<input type="hidden" name="noticeNo" value="${vo.noticeNo}" />
		<input type="text" name="noticeTitle" value="${vo.noticeTitle}" style="width: 100%;" required /><br/><br/>
		<textarea rows="20" cols="20" name="noticeContents" placeholder="내용" style="width: 100%;">${vo.noticeContents}</textarea><br/><br/>
		<input id="cancel" style="float:right;" type="button" onclick="location.href='<%=ctxPath %>/noticeDetail.an?noticeNo=${vo.noticeNo}'" value="취소">
		<input id="modify" style="float:right;" type="submit" value="수정">
	</form>

<jsp:include page="../common/footer.jsp"></jsp:include>