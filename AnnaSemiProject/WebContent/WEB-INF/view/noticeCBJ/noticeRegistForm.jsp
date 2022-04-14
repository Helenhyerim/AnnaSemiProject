<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>

<style type="text/css">

	input#regist, input#cancel {
		background-color: black;
		color: white;
		border-line: solid 1px white;
		font-size: 14px;
		width: 100px;
		margin: 5px;
	}
	
	
</style>

<script type="text/javascript">
	
	
	
</script>

<jsp:include page="../common/header_login.jsp"></jsp:include>
	
	<div class="container">
	  <div style="margin: 20% auto;">
		<h2 style="margin: 20px auto; font-weight: bold; color: black;">Notice</h2>
		<form action="<%= ctxPath %>/noticeRegist.an" method="post">
			<input type="text" name="noticeTitle" placeholder="제목" style="width: 100%;" required ><br/><br/>
			<textarea rows="20" cols="20" name="noticeContents" placeholder="내용" style="width: 100%;"></textarea><br/><br/>
			<input id="cancel" style="float:right;" type="button" onclick="location.href='<%= ctxPath %>/notice.an'" value="취소">
			<input id="regist" style="float:right;" type="submit" value="등록">
		</form>
	  </div>		

<jsp:include page="../common/footer.jsp"></jsp:include>