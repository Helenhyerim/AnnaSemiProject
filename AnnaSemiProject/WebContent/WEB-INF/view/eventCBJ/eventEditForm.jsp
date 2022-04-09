<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="eventCBJ.model.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<style type="text/css">

	table#tblEventInput {border: solid gray 1px;
                       border-collapse: collapse; }
                       
	table#tblEventInput td {border: solid gray 1px;
                          padding-left: 10px;
                          height: 70px; }
                          
	.eventInputName {background-color: #ddd;
                    font-weight: bold; }
   
	.error {color: red; font-weight: bold; font-size: 9pt;}

	input#btnEditer, input#btnCancel {
		background-color: black;
		color: white;
		border-line: solid 1px black;
		font-size: 14px;
		width: 100px;
	}
</style>

<%
	int eventNo = Integer.parseInt(request.getParameter("eventNo"));
	EventDAO dao = new EventDAO();
	EventVO vo = dao.selectOne(eventNo);
	pageContext.setAttribute("vo", vo);		
%>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span.error").hide();
		
		// 제품등록하기
		$("input#btnEditer").click(function(){
						
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
				var frm = document.eventInputFrm;
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
	<h2 style="margin: 20px auto; font-weight: bold; color: black;">글 등록</h2>	
	
	<form name="eventInputFrm"
	  action="<%= request.getContextPath()%>/eventEditForm.an"
	  method="POST"
	  enctype="multipart/form-data">
	  
		<table id="tblEventInput" >
	  
			<input type="hidden" name="eventNo" value="${vo.eventNo}" />
			<tbody>		
				<tr>
					<td width="15%" class=eventInputName>제목</td>
					<td width="75%" align="left" style="border-bottom: hidden;" >
						<input type="text" style="width: 300px;" name="eventTitle" class="box infoData" />
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="15%" class="eventInputName">이벤트기간</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						시작일자 <input type="date" id="eventStartdate" name="eventStartdate" /><br/><br/>
						종료일자 <input type="date" name="eventEnddate" />
					</td>
				</tr>
				<tr>
					<td width="15%" class="eventInputName">썸네일이미지</td>
					<td width="75%" align="left" style="border-top: hidden; border-bottom: hidden;">
						<input type="file" name="thumbNail" class="infoData" /><span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="15%" class="eventInputName">상세이미지</td>
					<td width="75%" align="left" style="border-top: hidden;">
						<input type="file" name="eventImg1" /><br/>
						<input type="file" name="eventImg2" />
					</td>
				</tr>
				<tr style="height: 70px;">
					<td colspan="2" align="center" style="border-left: hidden; border-bottom: hidden; border-right: hidden;">
						<input type="button" value="수정" id="btnEditer" style="width: 80px;" /> 
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
	