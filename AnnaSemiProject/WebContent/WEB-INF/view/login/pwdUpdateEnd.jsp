<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<style type ="text/css">

body > div.container > div.my-5.text-center > form > table tr{
	text-align: center;
}

body > div.container > div.my-5.text-center > form > table .login_element {
	width:100%;
	height:50px;
}
button {
	border:0;
	outline: 0;
}

button[type=button]{
	border-radius: 0;
    width: 100%;
    min-width: auto;
    height: 45px;
    line-height: 44px;
    font-size: 12px;
    padding: 0
}
</style>


<script type = "text/javascript">


$(document).ready(function(){
	
	
	$("input#div_pwd2").bind("keydown", function(event){
		if(event.keyCode == 13) { // 암호입력란에 엔터를 했을 경우 
			pwdUpdate(); // 로그인 시도한다.
		}
	});
	
	$("#btnCancel").click(function(){
		location.href = "<%=ctxPath%>/index.an";
	});
	if(${requestScope.method == 'POST' && requestScope.n == 1}){
		alert("사용자 ID ${requestScope.userid}님의 암호가 변경되었습니다.");
		location.href = "<%=ctxPath%>/index.an";
	
	}
		
    
   
	
});


function pwdUpdate(){
	
	const pwd = $("input#pwd").val();
	const pwd2 = $("input#pwd2").val();
	
	  const regExp = new RegExp(/^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[^a-zA-Z0-9]).*$/g);
	   // 숫자/문자/특수문자/ 포함 형태의 8~15자리 이내의 암호 정규표현식 객체 생성
		
	  const bool = regExp.test(pwd);   
	  
	  if(!bool) {
		  // 암호가 정규표현식에 위배된 경우 
		  alert("암호는 8글자 이상 15글자 이하에 영문자, 숫자, 특수기호가 혼합되어야만 합니다.");
		  $("input#pwd").val("");
		  $("input#pwd2").val("");
		  return;
	  }
	  else if(bool && pwd != pwd2) {
		  alert("암호가 일치하지 않습니다.");
		  $("input#pwd").val("");
		  $("input#pwd2").val("");
		  return;
	  }
	  else{
		  const frm = document.pwdUpdateEndFrm;
		  frm.action = "<%=ctxPath%>/login/pwdUpdateEnd.an";
		  frm.method = "post";
		  frm.submit();
	  }

}


</script>


	<div class="container" >
	  <div class = "mt-1 ml-0 mb-5"style="width: 80%; margin: 80% auto; ">
		<!-- div 태그의 margin 80% 을 0 으로 바꾸고, 여기에 원하는 내용을 작성하세요! -->
		<span class = "h3" style = "color:#888">비밀번호 변경</span>
		
	  </div>		
	  
	  <div class = "my-5 text-center"style="width: 80%; margin: 80% auto;">
		<form name = "pwdUpdateEndFrm" style = "margin-bottom: 200px;">
			<table style = "margin: auto; width: 80%;">
				
				
				<tbody>
					<tr>
						<td style = "width:80%;">
							<div class = "row my-3" id="div_pwd" align="center" >
						    	<span style="color: #888; text-align:left; font-size: 14pt;" class = "col-md-2 p-0">새암호</span><br/> 
						        <input type="password" name="pwd" id="pwd" placeholder="PASSWORD" class = "col-md-10 p-0" style = " height: 50px;" required />
						    </div>
						</td>
					</tr>	
					
					<tr>
						<td style = "width:80%;">
							<div class = "row mb-3" id="div_pwd2" align="center" >
						        <span style="color: #888; text-align:left; font-size: 14pt;" class = "col-md-2 p-0">새암호 확인</span><br/> 
						        <input type="password" id="pwd2" placeholder="PASSWORD" class = "col-md-10 p-0" style = " height: 50px;" required />
						    </div>
						</td>
					</tr>
					
					<tr>
						<td>
							<div class = "row">
								<button class = "login_element col-md-6 btn btn-dark btn-lg text-center" type = "button" id = "btnUpdate"  onclick = "pwdUpdate()">변경하기</button>
								<button class = "login_element col-md-6 btn btn-dark btn-lg text-center" type = "button" id = "btnCancel">취소하기</button>
								<button type="button" id = "btnCancel" class="btn btn-light btn-lg text-center" onClick="goRegister();">취소하기</button> 
							</div>
						</td>
					</tr>
					
					
				</tbody>
			</table>
			<input type = "hidden" name = "userid" value = "${requestScope.userid}"/>
		</form>
	  </div>	
	</div>

<jsp:include page="../common/footer.jsp"></jsp:include>