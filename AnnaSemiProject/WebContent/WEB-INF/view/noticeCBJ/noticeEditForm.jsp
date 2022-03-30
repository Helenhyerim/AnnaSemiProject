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
	NoticeVO vo = new NoticeVO();
	vo = dao.selectOne(noticeNo);
	pageContext.setAttribute("vo", vo);		
%>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<script type="text/javascript">

	$("submit").click(function(){
		const frm = document.noticeUpdateFrm;
		frm.action="<%=ctxPath %>/noticeEditForm.an";
		frm.method="post";
		frm.submit()
	});

</script>

<div class="container">
  <div style="width: 80%; margin: 20%; auto;">
	<title>글 수정</title>
	<h3>수정하기</h3>
	<form name="noticeUpdateFrm">
		<input type="hidden" name="noticeno" value="${vo.noticeNo}" />
		<input type="text" name="noticetitle" value="${vo.noticeTitle}" required /><br>	
		<textarea rows="4" cols="20" name="content" placeholder="내용">${vo.noticeContents}</textarea><br>
		<button type="button" id="btnUpdate">수정</button>
	</form>

<jsp:include page="../common/footer.jsp"></jsp:include>