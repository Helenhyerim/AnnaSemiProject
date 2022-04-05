<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
 <%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
    
<jsp:include page="../common/header_login.jsp" />   


<style type="text/css">
div#mvoInfo {
		width: 60%; 
		text-align: left;
		border: solid 0px red;
		margin-top: 30px; 
		font-size: 13pt;
		line-height: 200%;
	}
	
	span.myli {
		display: inline-block;
		width: 90px;
		border: solid 0px blue;
	}
	
/* ============================================= */
	div#sms {
		margin: 0 auto; 
		/* border: solid 1px red; */ 
		overflow: hidden; 
		width: 50%;
		padding: 10px 0 10px 80px;
	}
	
	span#smsTitle {
		display: block;
		font-size: 13pt;
		font-weight: bold;
		margin-bottom: 10px;
	}
	
	textarea#smsContent {
		float: left;
		height: 100px;
	}
	
	button#btnSend {
		float: left;
		border: none;
		width: 50px;
		height: 100px;
		background-color: navy;
		color: white;
	}
	
	div#smsResult {
		clear: both;
		color: red;
		padding: 20px;
	}	



</style>


<script type="text/javascript">
	$(document).ready(function(){
		$("div#smsResult").hide();
		
		$("button#btnSend").click( ()=>{
			
		//	console.log( $("input#reservedate").val() + " " + $("input#reservetime").val() );
		//  2022-04-05 11:20
		
		    let reservedate = $("input#reservedate").val();
		    reservedate = reservedate.split("-").join("");
		    
		    let reservetime = $("input#reservetime").val();
		    reservetime = reservetime.split(":").join("");
		    
		    const datetime = reservedate + reservetime;
		    
		 // console.log(datetime);
		 // 202204051120
		    
		    let dataObj;
		 
		    if( reservedate == "" || reservetime == "" ) {
		    	dataObj = {"mobile":"${requestScope.mvo.mobile}", 
		    			   "smsContent":$("textarea#smsContent").val()};
		    }
		    else {
		    	dataObj = {"mobile":"${requestScope.mvo.mobile}", 
		    			   "smsContent":$("textarea#smsContent").val(),
		    			   "datetime":datetime};
		    }
		    
		    $.ajax({
		    	url:"<%= request.getContextPath()%>/member/smsSend.up",
		    	type:"POST",
		    	data:dataObj,
		    	dataType:"json",
		    	success:function(json) {
		    		//json은 {"group_id":"R2GsmEtz5JwaJQF4","success_count":1,"error_count":0} 처럼 된다.
		    		
		    		if(json.success_count == 1) {
		    			$("div#smsResult").html("문자전송이 성공되었습니다.");
		    		}
		    		else if(json.error_count == 1) {
		    			$("div#smsResult").html("문자전송이 실패하였습니다.");
		    		}
		    		
		    		$("div#smsResult").show();
		    		$("textarea#smsContent").val("");
		    		
		    	},
		    	error: function(request, status, error){
					alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
				}
		    });
		});
		
		
	});// end of $(document).ready(function(){
		
		
</script>  
<div class="contents mx-5" style="margin-top:230px;">

	<c:if test="${empty requestScope.mvo}">
		존재하지 않는 회원입니다.<br>
	</c:if>
	<c:if test="${not empty requestScope.mvo}">
		<c:set var="mobile" value="${requestScope.mvo.mobile}" />
		<c:set var="birthday" value="${requestScope.mvo.birthday}" />
		
		<div class="titleArea">
		    <h2 class="w3-left-align mb-5">${requestScope.mvo.name}님의 상세정보</h2>
		</div>	
		
		<div id="mvoInfo">
		   <ol>
		   	  <li><span class="myli">아이디 : </span>${requestScope.mvo.userid}</li>
			  <li><span class="myli">회원명 : </span>${requestScope.mvo.name}</li>
			  <li><span class="myli">이메일 : </span>${requestScope.mvo.email}</li>
			  <li><span class="myli">휴대폰 : </span>${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}</li>
			  <li><span class="myli">우편번호 : </span>${requestScope.mvo.postcode}</li>
			  <li><span class="myli">주소 : </span>${requestScope.mvo.address}&nbsp;${requestScope.mvo.detailaddress}&nbsp;</li>
			  <li><span class="myli">성별 : </span><c:choose><c:when test="${requestScope.mvo.gender eq '1'}">남</c:when><c:otherwise>여</c:otherwise></c:choose></li>   
			  <li><span class="myli">생년월일 : </span>${fn:substring(birthday, 0, 4)}.${fn:substring(birthday, 4, 6)}.${fn:substring(birthday, 6, 8)}</li>
			  <li><span class="myli">나이 : </span>${requestScope.mvo.age}세</li>
			  <li><span class="myli">포인트 : </span><fmt:formatNumber value="${requestScope.mvo.point}" pattern="###,###" /> POINT</li> 
			  <li><span class="myli">가입일자 : </span>${requestScope.mvo.registerday}</li>
			  <li><span class="myli">문자수신동의여부 : </span>${requestScope.mvo.sms_status}</li>
			  <li><span class="myli">이메일수신동의여부 : </span>${requestScope.mvo.email_status}</li>
		   </ol>
		</div>
	
		<%-- ==== 휴대폰 SMS(문자) 보내기 ==== --%>
		<div id="sms" align="left">
		  	<span id="smsTitle">&gt;&gt;휴대폰 SMS(문자) 보내기 내용 입력란&lt;&lt;</span>
		  	<div style="margin: 10px 0 20px 0">
		  		발송예약일&nbsp;<input type="date" id="reservedate" />&nbsp;<input type="time" id="reservetime" />
		  	</div>
		  	<textarea rows="4" cols="40" id="smsContent"></textarea>
		  	<button id="btnSend">전송</button>
		  	<div id="smsResult"></div>
		</div>
	
	</c:if>

	<div>
		<button style="margin-top: 50px;" type="button" onclick="javascript:history.back();">회원목록[history.back()]</button>
		&nbsp;&nbsp;
		<button style="margin-top: 50px;" type="button" onclick="goMemberList()">회원목록[검색된결과]</button>
		&nbsp;&nbsp;
		<button style="margin-top: 50px;" type="button" onclick="javascript:location.href='memberList.up'">회원목록[처음으로]</button> 
	</div>
</div>
<jsp:include page="../common/footer.jsp" /> 