<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="faqCBJ.model.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<style type="text/css">

	table#tblFaqInput {border: solid gray 1px;
                       border-collapse: collapse; }
                       
	table#tblFaqInput td {border: solid gray 1px;
                          padding-left: 10px;
                          height: 70px; }
                          
	.faqInputName {background-color: #ddd;
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
				var frm = document.faqInputFrm;
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
	
	<form name="faqInputFrm"
	  action="<%= request.getContextPath()%>/faqRegistForm.an"
	  method="POST"
	  enctype="multipart/form-data">
	  
		<table id="tblFaqInput" >
	  
			<tbody>
				<tr>
			      <td width="15% hidden;border-bottom: hidden;%" class="faqInputName" style="padding-top: 10px;">카테고리</td>
			      <td width="75%" align="left" style="padding-top: 10px; border-bottom: hidden;" >
			         <select name="fk_cnum"> <!-- class="infoData"> -->
			         	<option value="">:::선택하세요:::</option>
				            <c:forEach var="map" items="${requestScope.faqCategoryList}"> <%-- var가 vo로 가져왔다면 get다음의 이름, var가 map으로 가져왔다면 key값 --%>
				            	<option value="${map.cnum}">${map.cname}</option>				            	
				            </c:forEach>
			         	</select>
			         <span class="error">필수입력</span>
			      </td>   
			   </tr>
			   
			  	<!-- <tr>
					<td width="15%" class=faqInputName>카테고리</td>
					<td width="75%" align="left" style="border-bottom: hidden;" >
						<input type="text" style="width: 300px;" name="faqRequestType" class="box" />
					</td>
				</tr> -->
				<tr>
					<td width="15%" class=faqInputName>제목</td>
					<td width="75%" align="left" style="border-bottom: hidden;" >
						<input type="text" style="width: 300px;" name="faqTitle" class="box infoData" />
						<span class="error">필수입력</span>
					</td>
				</tr>
				<tr>
					<td width="15%" class="faqInputName">상세이미지</td>
					<td width="75%" align="left" style="border-top: hidden;">
						<input type="file" name="faqImg" /><br/>
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
	