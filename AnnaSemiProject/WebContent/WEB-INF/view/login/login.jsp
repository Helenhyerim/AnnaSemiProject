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
</style>


<script type = "text/javascript">


$(document).ready(function(){
	
	
	$("input#loginPwd").bind("keydown", function(event){
		if(event.keyCode == 13) { // 암호입력란에 엔터를 했을 경우 
			goLogin(); // 로그인 시도한다.
		}
	});
	
	const loginUserid = localStorage.getItem('saveUserid');
	const loginUserPwd = localStorage.getItem('savePwd');
	
	if(loginUserid != null){
		$("input#loginUserid").val(loginUserid);
		$("input:checkbox[id='saveUserid']").prop("checked",true);
	}
	
	if(loginUserPwd != null){
		$("input#loginPwd").val(loginUserPwd);
		$("input:checkbox[id='savePwd']").prop("checked",true);
		localStorage.setItem('firstCheck',0);
	}
	
	
	
});

//로그인 버튼을 눌렀을 경우 로그인을 실행하는 함수 
function goLogin(){
	
	const loginUserid = $("input#loginUserid").val().trim();
	const loginPwd = $("input#loginPwd").val().trim();
	
	if(loginUserid == "") {
		alert("아이디를 입력하세요!!");
		$("input#loginUserid").val("");
		$("input#loginUserid").focus();
		return;  // goLogin() 함수 종료
	}
	
	if(loginPwd == "") {
		alert("암호를 입력하세요!!");
		$("input#loginPwd").val("");
		$("input#loginPwd").focus();
		return;  // goLogin() 함수 종료
	}
	
   if($("input:checkbox[id = 'saveUserid']").prop("checked") ){
		  // alert("아이디 저장 체크를 하셨네요");
		   
		   localStorage.setItem('saveUserid',$("input#loginUserid").val());
		   
   }
   else{
	  // alert("아이디 저장 체크를 해제 하셨네요");
	   localStorage.removeItem('saveUserid');
   }
   
   if($("input:checkbox[id = 'savePwd']").prop("checked") ){
	   
	   	if(localStorage.getItem('firstCheck') == null || localStorage.getItem('firstCheck') != 0){
		 	alert("비밀번호 저장을 체크시 해킹의 위험이 있을 수 있습니다.");
	   	}	   
		  localStorage.setItem('savePwd',$("input#loginPwd").val());
		  localStorage.setItem('firstCheck',1);
		   
	}
	else{
		  // alert("아이디 저장 체크를 해제 하셨네요");
		  localStorage.removeItem('savePwd');
		  localStorage.removeItem('firstCheck');
	}

	const frm = document.loginfrm;
	frm.action = "<%= request.getContextPath()%>/login/login.an";
	frm.method = "post";
	frm.submit();
	
}// end of function goLgoin() ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


function goIdFind(){
	location.href="<%= ctxPath%>/login/idFind.an";
		
}
function goPwdFind(){
	location.href="<%= ctxPath%>/login/pwdFind.an";	
}



</script>


<c:if test="${requestScope.method eq 'POST'}" >
	<script type="text/javascript">
		alert("회원님의 아이디를 성공적으로 찾았습니다.");
	</script>
</c:if>


	<div class="container" >
	  <div class = "mt-1 ml-0 mb-5"style="width: 80%; margin: 80% auto; ">
		<!-- div 태그의 margin 80% 을 0 으로 바꾸고, 여기에 원하는 내용을 작성하세요! -->
		<span class = "h3" style = "color:#888">LOGIN</span>
		
	  </div>		
	  
	  <div class = "my-5 text-center"style="width: 80%; margin: 80% auto;">
		<form name = "loginfrm" style = "margin-bottom: 200px;">
			<table style = "margin: auto; width: 80%;">
				<thead >
					<tr>
						<th class = "h3" colspan = "2" style = "color:#888;">로그인</th>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td style = "width:80%;">
							<input type = "text" name = userid placeholder="ID" class = "login_element" id = "loginUserid" value = "${requestScope.findUserid}"/>
						</td>
					</tr>	
					
					<tr>
						<td style = "width:80%;">
							<input type = "password" name = pwd placeholder="password" class = "login_element" id = "loginPwd"/>
						</td>
					</tr>
					
					<tr>
						<td>
							<button class = "login_element btn btn-dark btn-lg text-center" type = "button" id = "btnLogin"  onclick = "goLogin()" >로그인</button>
						</td>
					</tr>
					
					<tr>
						<td>
							<button type="button"  class = "login_element btn btn-light btn-lg text-center" type = "button" id = "btnRegister">회원가입</button>
						</td>
					</tr>
					<tr style = "text-align: left;">
						<td>
							<input type = "checkbox" name = "saveUserid" id = "saveUserid"/>
							<label for="saveUserid">아이디 저장하기</label>
							&nbsp;&nbsp;&nbsp;
							<input type = "checkbox" name = "savePwd" id = "savePwd" />
							<label for="savePwd">비밀번호 저장하기</label>
						</td>
					</tr>
					<tr>
						<td>

							

							<a class = "login_element" id = "btnRegister" href = "<%= ctxPath%>/login/idFind.an">아이디 찾기</a>

							<span> | </span>

							

							<a class = "login_element" id = "btnRegister" href = "<%= ctxPath%>/login/pwdFind.an">비밀번호 찾기</a>
						</td>
					</tr>
					
				</tbody>
			</table>
		</form>
	  </div>	
	</div>

<jsp:include page="../common/footer.jsp"></jsp:include>