<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"  %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
    
<jsp:include page="../common/header_login.jsp" />   


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

div.mvoInfo {
	width: 420px;
    margin: 0 auto;
    font-size: 12px;
	margin-top: 30px; 
	line-height: 200%;
	text-align: left;
	border: solid 1px gray;
	padding: 15px 0;
}


	span.myli {
		display: inline-block;
		width: 130px;
		border: solid 0px blue;
		margin-top: 5px;
		margin-right: 20px;
	}
	
/* ============================================= */
	div#sms, #email {
		margin: 0 auto; 
	/*	border: solid 1px red; */
		overflow: hidden; 
		width: 100%;
		padding: 10px 0;
		text-align: center;
	}
	
	
	span#smsTitle, #emailTitle {
		display: block;
		font-size: 12px;
		margin-bottom: 10px;
	}
	
	
	textarea#smsContent, #emailContent {
		height: 100px;
		justify-content: center;
		display: inline-block;
	}
	
	button#btnSendSms, #btnSendMail {
		justify-content: center;
		border: none;
		width: 50px;
		height: 100px;
		background-color: #ddd;
		color: white;
		display: inline-block;
	}
	
	textarea,button {vertical-align: middle;}	

	div#smsResult, #emailResult {
		clear: both;
		color: red;
		padding: 20px;
	}	



</style>


<script type="text/javascript">
	$(document).ready(function(){
		$("div#smsResult").hide();
		
		$("button#btnSendSms").click( ()=>{
			
		//	console.log( $("input#reservedate").val() + " " + $("input#reservetime").val() );
		//  2022-04-05 11:20
		
			if (${requestScope.mvo.sms_status eq '0'}){
				alert("문자 수신 동의를 받지 않아 문자를 보낼 수 없습니다.");
				return;  // 종료 
			}
		
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
		    	url:"<%= request.getContextPath()%>/member/smsSend.an",
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
		
		$("div#emailResult").hide();
		
		
		$("button#btnSendMail").click( ()=>{
			
			if (${requestScope.mvo.email_status eq '0'}){
				alert("메일 수신 동의를 받지 않아 메일을 보낼 수 없습니다.");
				return;  // 종료 
			}
		   
	
			 $.ajax({
			    	url:"<%= request.getContextPath()%>/member/emailSend.an",
			    	type:"POST",
			    	data:{"email":"${requestScope.mvo.email}", 
	    				"name":"${requestScope.mvo.name}",
		    			   "emailContent":$("textarea#emailContent").val()},
			    	dataType:"json",
			    	success:function(json) {
			    		//json은 {"group_id":"R2GsmEtz5JwaJQF4","success_count":1,"error_count":0} 처럼 된다.
			    		
			    		if(json.sendMailSuccess == true) {
			    			$("div#emailResult").html("이메일전송이 성공되었습니다.");
			    		}
			    		else if(json.sendMailSuccess == false) {
			    			$("div#emailResult").html("이메일전송이 실패하였습니다.");
			    		}
			    		
			    		$("div#emailResult").show();
			    		$("textarea#emailContent").val("");
			    		
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
		
		<div class="mvoInfo">
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
				  <li><span class="myli">문자수신동의여부 : </span><c:choose><c:when test="${requestScope.mvo.sms_status eq '1'}">동의</c:when><c:otherwise>비동의</c:otherwise></c:choose></li>
				  <li><span class="myli">이메일수신동의여부 : </span><c:choose><c:when test="${requestScope.mvo.email_status eq '1'}">동의</c:when><c:otherwise>비동의</c:otherwise></c:choose></li>
			   </ol>
			</div>
	
			<%-- ==== 휴대폰 SMS(문자) 보내기 ==== --%>
			<div id="sms" align="left">
			  	<span id="smsTitle">&gt;&gt;문자 보내기&lt;&lt;</span>
			  	<div style="margin: 10px 0 20px 0">
			  		발송예약일&nbsp;&nbsp;<input type="date" id="reservedate" />&nbsp;<input type="time" id="reservetime" />
			  	</div>

			  	<textarea rows="4" cols="40" id="smsContent"></textarea>
			  	<button id="btnSendSms">전송</button>
			  	<div id="smsResult"></div>
			</div>
	
			<%-- ==== 이메일 보내기 ==== --%>
			<div id="email" align="left">
			  	<span id="emailTitle">&gt;&gt;메일 보내기&lt;&lt;</span>
			  	<div style="margin: 10px 0 20px 0">
			  		발송예약일&nbsp;&nbsp;<input type="date" id="reservedate" />&nbsp;<input type="time" id="reservetime" />
			  	</div>
			
			  	<textarea rows="4" cols="40" id="emailContent"></textarea>
			  	<button id="btnSendMail">전송</button>
			  	<div id="emailResult"></div>
			
			</div>
	</div>
</c:if>	


</div>

<jsp:include page="../common/footer.jsp" /> 