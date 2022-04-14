<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="qnaCBJ.model.*, java.util.List"%>


<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	String ctxPath = request.getContextPath();
%>

<%
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	QnaVO vo = new QnaDAO().selectOne(qnaNo);
	QnaDAO dao = new QnaDAO();
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
	
	div#qnainfo {
		display: inline-block;
		font-size: 20px;
	}
	
	img {
		width: 100%;
	}
	
	button#modify,#delete,#answer {
		background-color: black;
		color: white;
		border-line: solid 1px black;
		font-size: 14px;
		width: 100px;
	}
</style>

<jsp:include page="../common/header_login.jsp"></jsp:include>

	<div class="container">
	  <div style="margin: 25% auto;">
	  <h2 style="margin: 20px auto; font-weight: bold; color: black;">Qna</h2>	
	  	<div class="topbar">  
			<div id="qnainfo" style="color: black;">
				${vo.questionTitle} 
			</div>
			<div id="qnainfo" style="float: right; ">				
				<div id="qnainfo"  style="font-size: 13px; ">
					${fn:substring(vo.questionDate, 0, 10)}
				</div>
				&nbsp;
				<div id="qnainfo" style="float: right; ">
					<button type="button" id=menu class="btn btn-default btn-lg" aria-label="Left Align" onclick="location.href='<%= ctxPath %>/qna.an'">
						<i class="fas fa-bars"></i>
					</button>
				</div>
			</div>
		</div>
		<br/>
		
		<div style="margin: 20px;">
			${vo.questionContents}
		</div>
		<br/><br/>
				
		<c:if test="${not empty vo.questionImg}">
			<div>
				<img src="<%= ctxPath %>/imagesCBJ/${vo.questionImg}">					
			</div>
		</c:if>
		
		<div style="margin: 20px; float: right; ">
			작성자 : ${vo.fk_userId}
		</div>
		<br/>
		<br/>
		
		<div style="margin: 20px; border-top: solid 1px #ccc; padding-top:20px;">${vo.answerTitle}</div>
		<div style="margin: 20px;">${vo.answerContents}</div>
		<c:if test="${not empty vo.answerImg}">
			<div>
				<img src="<%= ctxPath %>/imagesCBJ/${vo.answerImg}">					
			</div>
		</c:if>
		<div style="margin: 20px; float: right; ">답변작성일 : ${fn:substring(vo.answerDate, 0, 10)}</div><br/><br/><br/>
		
		
		<c:if test="${sessionScope.loginuser.userid eq vo.fk_userId}">
			<div style="float: right; padding: 20px;">
				<a href="<%=ctxPath %>/questionEdit.an?qnaNo=${vo.qnaNo}"><button id="modify">수정</button></a>
				<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="<%=ctxPath %>/questionDelete.an?qnaNo=${vo.qnaNo}"><button id="delete">삭제</button></a>
			</div>
		</c:if>
		
		<c:if test="${sessionScope.loginuser.userid eq 'admin'}">
			<div style="float: right; padding: 20px;">
				<a href="<%=ctxPath %>/answerRegist.an?qnaNo=${vo.qnaNo}"><button id="answer" style="width: 110px;">답변등록/수정</button></a>					
			</div>
		</c:if>
	  </div>		
	</div>

<jsp:include page="../common/footer.jsp"></jsp:include>
