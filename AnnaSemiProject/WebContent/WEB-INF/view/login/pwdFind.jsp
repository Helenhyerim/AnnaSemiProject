<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<jsp:include page="../common/header_login.jsp"></jsp:include>

<style type = "text/css">


#btnIdFind {
	border:0;
	outline: 0;
}

div.row {
	margin-bottom: 30px;
}

div.row > div{
	padding: 0;
	text-align: left;
}

.loader {
  border: 16px solid #f3f3f3;
  border-radius: 50%;
  border-top: 16px solid #999;
  width: 120px;
  height: 120px;
  -webkit-animation: spin 2s linear infinite; /* Safari */
  animation: spin 2s linear infinite;
  margin:0 auto;
}

/* Safari */
@-webkit-keyframes spin {
  0% { -webkit-transform: rotate(0deg); }
  100% { -webkit-transform: rotate(360deg); }
}

@keyframes spin {
  0% { transform: rotate(0deg); }
  100% { transform: rotate(360deg); }
}
</style>
<script type = "text/javascript">
 
$(document).ready(function(){
	
	$('div#fixloader').hide();
	
	const center_left = ( $(window).scrollLeft() + ($(window).width() - 120) / 2 );<%-- 정수로 만듦 --%>
	const center_top =( $(window).scrollTop() + ($(window).height() - 120) / 2 );<%-- 정수로 만듦 --%>
	
	$('div#fixloader').css({'position':'absolute', 'top':center_top,'left':center_left});
	
	console.log(center_left);
	console.log(center_top);
	$("input#email").bind("keydown", function(event){
		if(event.keyCode == 13) { // 이메일입력란에 엔터를 했을 경우 
			goPwdFind(); // 아이디 찾기를 시도한다.
		}
	});
		
});

// 유효성검사를 한뒤에 post 형식으로 보내준다.
function goPwdFind(){
	$('div#fixloader').show();
	const name = $("input#name").val().trim();
	const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
	const userid = $("input#userid").val().trim();
	const bool = regExp.test($("input#email").val());
	
	if(userid == ""){
		alert("아이디를 입력하세요.");
		return;
	}
	if(name == ""){
		alert("이름을 입력하세요.");
		return;
	}
	if(!bool){
		alert("이메일 형식에 맞지않습니다.");
		return;
	}
	
	const frm = document.pwdFindfrm;
	frm.action = "<%= request.getContextPath()%>/login/pwdFind.an";
	frm.method = "POST";
	frm.submit();
	
}
// 인증하기
function goCheckCode(){
	
	const frm = document.codeCheckfrm;
	
	frm.action = "<%= request.getContextPath()%>/login/verifyCertification.an";
	frm.method = "POST";
	frm.submit();

	
} 

function goCancel(){
	location.href = "<%= request.getContextPath()%>/index.an";	
}
</script>

<c:if test="${requestScope.method eq 'POST'}" >
  	<script type="text/javascript">
		alert("${requestScope.email}로 메일을 전송하였습니다.");
	</script>
</c:if>
<c:if test="${requestScope.isUserExist == false && requestScope.sendMailSuccess == false}">
	<script type="text/javascript">
		alert("메일 발송이 실패했습니다.");
	</script>
</c:if>	

<div class = "container mb-5">
	<!-- div 태그의 margin 80% 을 0 으로 바꾸고, 여기에 원하는 내용을 작성하세요! -->
	<span class = "h3 " style = "color:#888">비밀번호 찾기</span>
</div>


<div class="container"  style = "text-align: center;" >
	
	
	<div style = "display:inline-block; width: 50%; ">
				
	    <div class = "container">
	    	<c:if test="${requestScope.method ne 'POST'}">	
				<form name = "pwdFindfrm" style = "margin-bottom: 200px;" class = "text-center">
					<div class = "row">
						<div class = "col-md-2"> 아이디</div>
						<input type = "text" name = "userid" id = "userid" class = "col-md-10"/>
					
					</div>
					<div class = "row">
						<div class = "col-md-2"> 이름</div>
						<input type = "text" name = "name" id = "name" class = "col-md-10"/>
					
					</div>
					<div class = "row">
						<div class = "col-md-2"> 이메일</div>
						<input type = "email" name = "email" id = "email" class = "col-md-10" />
					</div>
					<div class = "row">
						<button class = "login_element w-100 btn btn-dark btn-lg text-center mb-2" type = "button" id = "btnPwdFind"onclick = "goPwdFind();" >비밀번호 찾기</button>
						<button class = "login_element w-100 btn btn-light btn-lg text-center" type = "button" onclick = "goCancel();" >취소하기</button>
					</div>
			    </form>
			    <div class="loader " id = "fixloader"></div>
			</c:if>		   
		    <c:if test="${requestScope.method == 'POST' && requestScope.sendMailSuccess == true && requestScope.isUserExist == true}">
		   		<form name = "codeCheckfrm" style = "margin-bottom: 200px;" class = "text-center">
					<div class = "row">
						<div class = "col-md-2"> 인증번호</div>
						<input type = "text" name = "usercertificationCode" id = "usercertificationCode" class = "col-md-10"/>
					</div>
					<div class = "row">
						<button class = "w-100 btn btn-dark btn-lg text-center" type = "button" id = "btnCheckCode" onclick = "goCheckCode()" >인증번호 확인</button>
						
					</div>
					 
					<input type = "hidden" name = "userid" value = "${requestScope.userid}"/>
			    </form>
			</c:if>
		</div>	
	</div>
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>