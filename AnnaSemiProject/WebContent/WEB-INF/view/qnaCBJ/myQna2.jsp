<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
	String ctxPath = request.getContextPath();
%>   

<jsp:include page="../common/header_login.jsp" />   

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/pagination_syj.css" />

<style type="text/css">

	.titleArea h2 {
	    font-size: 18px;
	    color: #444;
	    font-weight: 600;
	    letter-spacing: 1px;
	    font-family: 'Roboto','Noto Sans KR',sans-serif;
	}
	
	#contents {
	    width: 100%;
	    float: none;
	    padding: 200px 20px 0;
	    box-sizing: border-box;  
	} 
	
	.myQnaFrm {
    margin: 0 auto;
    font-size: 12px;
    }

	select {
    height: 24px;
    border: 1px solid #d5d5d5;
    padding: 0%;
	}
	
	input[type=text] {
		width: 144px;
	    height: 24px;
	    margin: 0 0 0 2px;
	    padding: 0 6px;
	    border: 1px solid #d5d5d5;
	    line-height: 22px;
	    font-size: 12px;
	}
	
	form > button {
		display: inline-block;
	    height: 24px;
	    margin: 0 10px 0 2px;
	    padding: 0 10px;
	    color: #999;
	    border: 1px solid #ddd;
    }
    
    table#myQnaTbl {
   	 	border: 1px solid #ddd;
    }
    
    table#myQnaTbl th, td {
   		padding: 5px 0;
   		color: black;
    	font-weight: 300;
    	text-align: center;
   }
    
    tbody {
    color: black;
    }
	tr.myQnaInfo:hover {
		background-color: #d5d5d5;
		cursor: pointer;
	}
	
	.pagination {
		color: black;
		background-color: #ddd;
	}
	
	
</style>

<script type="text/javascript">

	$(document).ready(function(){
		// **** select 태그에 대한 이벤트는 click 이 아니라 change 이다. **** //
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
		

		<%--
		 // 특정 글을 클릭하면 그 글의 상세정보를 보여주도록 한다.
	    $("tr.myQnaInfo").click( ()=>{
	    	
	    	const $target = $(event.target);
	        //	alert("확인용 => " + $target.parent().html() );
	        const qnaNo = $target.parent().children(".qnano").text();
	        alert("확인용 => " + qnaNo);
	       
	        location.href="<%= ctxPath%>/qnaDetail.an?qnaNo="+qnaNo+"&goBackURL=${requestScope.goBackURL}";
	   	
	    });--%>
	 
	});// end of $(document).ready(function(){})-----------------------------

	// Function Declaration
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

<div class="contents mx-5" style="margin-top:230px;">
	<div class="titleArea">
	    <h2 class="w3-left-align mb-5">MY Q&A BOARD</h2>
	</div>
	
	<div class="myQnaFrm">


	    <table id="myQnaTbl" class="table table-bordered" style="width: 100%; margin-top: 20px;">
	        <colgroup>
	        	<col style="width:70px;">
				<col style="width:auto;">
				<col style="width:80px;">
				 <col style="width:100px;">
				<col style="width:120px;">
			</colgroup>
	        <thead><tr>
				<th scope="col">번호</th>
                <th scope="col">제목</th>
                 <th scope="col">작성자</th>
                <th scope="col">답변여부</th>
                 <th scope="col">작성일</th>
			</tr></thead>
			
	        <tbody>
			<c:if test="${not empty requestScope.qnaList}">
				<c:forEach var="qvo" items="${requestScope.qnaList}">
					<tr class="myQnaInfo" style="font-size: 14px; ">
						<td class="qnano" style="color:black;">${qvo.qnaNo}</td>
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
	
	    <form name="qnaFrm" action="qna.an" method="get" style="padding:20px 20px 0 0;">
		<select id="searchType" name="searchType">
			<option value="">검색대상</option>
			<option value="questionTitle">제목</option>
			<option value="questionContents">내용</option>
		</select>
		<input type="text" id="searchWord" name="searchWord">
	    <input type="text" style="display: none;" />
	 	<button type="button" onclick="goSearch();">검색</button> 
	     <!--  	<input type="submit" value="검색" style="margin-right: 30px" /> 
	     <!--   <input type="submit" class="img-button" value="  "  />-->
		
	    </form>

	
	
	   <nav class="my-5">
		<div style="display: flex;">
			<ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
		</div>
		</nav>
	    
	    
    </div>
</div>


<jsp:include page="../common/footer.jsp"></jsp:include>


    