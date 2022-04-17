<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<style type="text/css">

	td {
		border-left:none;
		border-right:none;
		border-top: solid 1px #E0E0E0;
		border-bottom: solid 1px #E0E0E0;		
		color: gray;
		text-align:center;
		height:50px;
	}

	tr.qnaInfo:hover {
		background-color: #ddd;
		cursor: pointer;
	}
	
	th {
		text-align:center;
		color: black;
	}
	
	button {
		background-color: black;
		color: white;
		border-line: solid 1px black;
		font-size: 14px;
		width: 100px;
		
	}
	
	input.img-button {
        background: url( "<%= ctxPath%>/imagesCBJ/button_search.png" ) no-repeat;
        border: none;
        width: 32px;
        height: 32px;
        cursor: pointer;
      }
    
	
	ul.pagination a {
		border: none;
		font-weight: bold;
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("select#sizePerPage").bind("change", function(){
			const frm = document.qnaFrm;
			frm.action = "qna.an";
			frm.method = "get";
			frm.submit();
		});
		
		$("select#sizePerPage").val("${requestScope.sizePerPage}");
		
		
		$("form[name='qnaFrm']").submit(function(){
			if($("select#searchType").val() == "") {
				alert("검색대상을 올바르게 선택하세요!!");
				return false; 
			}
			
			if($("input#searchWord").val().trim() == "") {
				alert("검색어는 공백만으로는 되지 않습니다.\n검색어를 올바르게 입력하세요!!");
				return false; 
			}
		});
		
		
		$("input#searchWord").bind("keyup", function(event){
			if(event.keyCode == 13) {
				goSearch();
			}
		});
		
	    if("${requestScope.searchType}" != "") { 
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
	    }
		
		
	});

	function goSearch() {
		
		if($("select#searchType").val() == "") {
			alert("검색대상을 올바르게 선택하세요!!");
			return; // return; 는 goSearch() 함수 종료이다.
		}
		
		if($("input#searchWord").val().trim() == "") {
			alert("검색어는 공백만으로는 되지 않습니다.\n검색어를 올바르게 입력하세요!!");
			return; // return; 는 goSearch() 함수 종료이다.
		}
		
		const frm = document.qnaFrm;
		frm.action = "qna.an";
		frm.method = "get";
		frm.submit();
	}

</script>

<div class="container">
<div style="margin: 20% auto;">
 
<h2 style="margin: 20px auto; font-weight: bold; color: black;">Qna</h2>

	
	<table>
		<thead>
		   <tr>
		      <th style="width: 60px; ">번호</th>
		      <th style="width: 1000px;">제목</th>
		      <th style="width: 130px;">작성자</th>
		      <th style="width: 130px;">상태</th>
		      <th style="width: 130px;">등록일</th>		      
		   </tr>
		</thead>

		<tbody>
			<c:if test="${not empty requestScope.qnaList}">
				<c:forEach var="qvo" items="${requestScope.qnaList}">
					<tr class="qnaInfo" style="font-size: 14px; ">
						<td class="qnano" style="color:black; font-weight: bold; ">${qvo.qnaNo}</td>
						<td style="text-align:left; "><a href="<%= ctxPath%>/qnaDetail.an?qnaNo=${qvo.qnaNo}">${qvo.questionTitle}</a></td>
						<td>${qvo.fk_userId}</td>
						<td>
							<c:choose>
								<c:when test="${empty qvo.answerTitle}">
									<div style="color:black;">대기중</div>
								</c:when>
								<c:otherwise>
									<div style="color:lightgreen; font-weight:bold;">답변완료</div>
								</c:otherwise>
							</c:choose>
						</td>
						<td>${ fn:substring(qvo.questionDate, 0, 10)}</td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty requestScope.qnaList}">
	           	<tr>
	           		<td colspan="4" style="text-align: center;">검색된 데이터가 존재하지 않습니다.</td>
	           	</tr>
	        </c:if>
		</tbody>
	</table>
	
	<c:if test="${sessionScope.loginuser.userid ne 'admin'}">
		<div id="regist" style="display:inline-block; float:right; padding:20px;">
			<a href="<%= ctxPath%>/questionRegist.an"/><button>질문등록</button></a>
		</div>
	</c:if>
	
	<form name="qnaFrm" action="qna.an" method="get" style="padding:20px 20px 0 0;">
		<select id="searchType" name="searchType">
			<option value="">검색대상</option>
			<option value="questionTitle">제목</option>
			<option value="questionContents">내용</option>
		</select>
		<input type="text" id="searchWord" name="searchWord">
		
		<input type="text" style="display: none;" />	
		
		<input type="submit" class="img-button" value="  "  />
		
	</form>
	
	<nav class="my-5">
		<div style="display: flex;">
			<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
		</div>
	</nav>
		
</div>		
</div>



<jsp:include page="../common/footer.jsp"></jsp:include>
