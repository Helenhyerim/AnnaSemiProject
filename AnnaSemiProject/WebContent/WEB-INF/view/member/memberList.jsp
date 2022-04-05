<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<%
	String ctxPath = request.getContextPath();
    //     /MyMVC
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
	
	.memberFrm {
    margin: 0 auto;
    font-size: 12px;
    }

	select {
    height: 24px;
    border: 1px solid #d5d5d5;
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
    
    table#memberTbl {
   	 	border: 1px solid #ddd;
    }
    
    table#memberTbl th, td {
   		padding: 5px 0;
   		color: black;
    	font-weight: 300;
    	text-align: center;
   }
    
	tr.memberInfo:hover {
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
			const frm = document.memberFrm;
			frm.action = "memberList.an";
			frm.method = "get";
			frm.submit();
		});
		
		$("select#sizePerPage").val("${requestScope.sizePerPage}");
		
		
		
		$("form[name='memberFrm']").submit(function(){
			if($("select#searchType").val() == "") {
				alert("검색대상을 선택하세요!!");
				return false; // return false; 는 submit을 하지말라는 것이다.
			}
			
			if($("input#searchWord").val().trim() == "") {
				alert("검색어를 입력하세요!!");
				return false; // return false; 는 submit을 하지말라는 것이다.
			}
		});
		
		
		$("input#searchWord").bind("keyup", function(event){
			if(event.keyCode == 13) {
				// 검색어에서 엔터를 치면 검색하러 가도록 한다.
				goSearch();
			}
		});
		
		if("${requestScope.searchType}" != "") { 
			$("select#searchType").val("${requestScope.searchType}");
			$("input#searchWord").val("${requestScope.searchWord}");
	    }
		
		 // 특정 회원을 클릭하면 그 회원의 상세정보를 보여주도록 한다.
	    $("tr.memberInfo").click( ()=>{
	    	
	    	const $target = $(event.target);
	        
	        const userid = $target.parent().children(".userid").text();
	    //  alert("확인용 => " + userid);
	    
	        location.href="<%= ctxPath%>/member/memberOneDetail.an?userid="+userid;
	    //																									  &goBackURL=/member/memberList.up?currentShowPageNo=5 sizePerPage=10 searchType=name searchWord=%EC%9C%A0
				
	    });
	 
	});// end of $(document).ready(function(){})-----------------------------

	// Function Declaration
	function goSearch() {
		
		if($("select#searchType").val() == "") {
			alert("검색대상을 선택하세요.");
			return; // return; 는 goSearch() 함수 종료이다.
		}
		
		if($("input#searchWord").val().trim() == "") {
			alert("검색어를 입력하세요.");
			return; // return; 는 goSearch() 함수 종료이다.
		}
		
		const frm = document.memberFrm;
		frm.action = "memberList.an";
		frm.method = "get";
		frm.submit();
	}

</script>

<div class="contents mx-5" style="margin-top:230px;">
	<div class="titleArea">
	    <h2 class="w3-left-align mb-5">전체회원목록</h2>
	</div>
	
	<div class="memberFrm">
	    <form name="memberFrm" action="memberList.an" method="get">
	    	<select id="searchType" name="searchType">
	    		<option value="">검색대상</option>
	    		<option value="name">회원명</option>
	    		<option value="userid">아이디</option>
	    		<option value="email">이메일</option>
	    		<option value="mobile">휴대전화</option>
	    	</select>
	    	<input type="text" id="searchWord" name="searchWord">
	    	<input type="text" style="display: none;" />
	   	<button type="button" onclick="goSearch();">검색</button> 
	     <!--  	<input type="submit" value="검색" style="margin-right: 30px" /> -->
	    	
	    	<span style="margin-right:2px">페이지당 회원명수</span>
			<select id="sizePerPage" name="sizePerPage">
				<option value="10">10</option>
				<option value="5">5</option>
				<option value="3">3</option>
			</select>
	    </form>
	    
	    <table id="memberTbl" class="table table-bordered" style="width: 100%; margin-top: 20px;">
	        <thead>
	        	<tr>
	        		<th>아이디</th>
	        		<th>회원명</th>
	        		<th>이메일</th>
	        		<th>휴대전화</th>
	        	</tr>
	        </thead>
	        
	        <tbody>
		        <c:if test="${not empty requestScope.memberList}">
		            <c:forEach var="mvo" items="${requestScope.memberList}">
		            	<tr class="memberInfo">
		            		<td class="userid">${mvo.userid}</td>
		            		<td>${mvo.name}</td>
		            		<td>${mvo.email}</td>
		            		<td>${mvo.mobile}</td>
		            	</tr>
		            </c:forEach>
	            </c:if>
	            <c:if test="${empty requestScope.memberList}">
            	<tr>
            		<td colspan="4" style="text-align: center;">검색된 데이터가 존재하지 않습니다</td>
            	</tr>
            </c:if>
	        </tbody>
	    </table>    
	
	    <nav class="my-5">
	       <div style="display: flex;">
	       	   <ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
	       </div>
	    </nav>
    </div>
</div>

<jsp:include page="../common/footer.jsp" /> 


    