<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="qnaCBJ.model.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<style type="text/css">

	table#tblQnaInput {border: solid gray 1px;
                       border-collapse: collapse; }
                       
	table#tblQnaInput td {border: solid gray 1px;
                          padding-left: 10px;
                          height: 70px; }
                          
	.qnaInputName {background-color: #ddd;
                    font-weight: bold; }
   
	.error {color: red; font-weight: bold; font-size: 9pt;}

	input#btnRegister, input#btnCancel {
		background-color: black;
		color: white;
		border-line: solid 1px black;
		font-size: 14px;
		width: 100px;
	}
</style>

<%
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	QnaDAO dao = new QnaDAO();
	QnaVO vo = dao.selectOne(qnaNo);
	pageContext.setAttribute("vo", vo);		
%>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.error").hide();
		
		// 제품등록하기
		$("input#btnRegister").click(function(){
						
			let flag = false;
			
			$(".infoData").each(function(index, item){
				const val = $(item).val().trim();
				if(val == "") {
					$(item).next().show();
					flag = true;
					return false;
				}
			});
			
			if(!flag) {
				var frm = document.qnaInputFrm;
				frm.submit();
			}
			
		});
		
		// 제품등록취소하기
		$("input[type='reset']").click(function(){
			$("span.error").hide();
		});

	});

</script>

<div class="container">
	<div style=" margin: 20% auto;">
	<div align="center" style="margin-bottom: 20px;">
	<h2 style="margin: 20px auto; font-weight: bold; color: black;">답변등록/수정</h2>	
	
	<form name="qnaInputFrm"
	  action="<%= request.getContextPath()%>/answerRegist.an"
	  method="POST"
	  enctype="multipart/form-data">
	  
		<table id="tblQnaInput" >
	  		
			<tbody>
				<input type="hidden" name="qnaNo" value="${vo.qnaNo}">
				<tr>
					<td width="50px" class=qnaInputName>제목</td>
					<td width="500px" align="left" style="border-bottom: hidden;" >
						<input type="text" style="width: 480px;" name="answerTitle" class="box infoData" value=A.답변&nbsp;드립니다. >
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="50px" class=qnaInputName>내용</td>
					<td width="500px" align="left" style="border-bottom: hidden; border-top: hidden;" >
						<input type="text" style="width: 480px; height: 300px;" name="answerContents" class="box infoData" value="${vo.answerContents}"/>
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="50px" class="qnaInputName">첨부파일</td>
					<td width="500px" align="left" style="border-top: hidden; ">
						<input type="file" name="answerImg" />
					</td>
				</tr>
				
				<tr style="height: 70px;">
					<td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden;">
						<input type="button" value="등록" id="btnRegister" style="width: 80px;" /> 
						&nbsp;
						<input type="reset" value="취소" id="btnCancel" style="width: 80px;" />   
					</td>
				</tr>
			</tbody>
	  
		</table>
	  
	</form>
	</div>
	</div>
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>
	