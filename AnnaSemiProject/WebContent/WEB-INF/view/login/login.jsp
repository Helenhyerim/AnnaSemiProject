<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String cntPath = request.getContextPath();
%>

<jsp:include page="../common/header_login.jsp"></jsp:include>




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
	
});

//로그인 버튼을 눌렀을 경우 로그인을 실행하는 함수 
function goLogin(){
	
	
	const frm = document.loginfrm;
	frm.action = "login.an";
	frm.method = "post";
	frm.submit();
	
}// end of function goLgoin() ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


</script>




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
							<input type = "text" name = userid placeholder="ID" class = "login_element"/>
						</td>
					</tr>	
					
					<tr>
						<td style = "width:80%;">
							<input type = "password" name = pwd placeholder="password" class = "login_element" id = "loginPwd"/>
						</td>
					</tr>
					
					<tr>
						<td>
							<button class = "login_element" type = "button" id = "btnLogin" style = "background-color: #999;" onclick = "goLogin()" >로그인</button>
						</td>
					</tr>
					
					<tr>
						<td>
							<button class = "login_element" type = "button" id = "btnRegister">회원가입</button>
						</td>
					</tr>
					
					<tr>
						<td>
							<a class = "login_element" id = "btnRegister" href = "<%= cntPath%>/login/idFind.an">아이디 찾기</a>
							<span> | </span>
							<a class = "login_element" id = "btnRegister" href = "<%= cntPath%>/login/pwdFind.an">비밀번호 찾기</a>
						</td>
					</tr>
					
				</tbody>
			</table>
		</form>
	  </div>	
	</div>

<jsp:include page="../common/footer.jsp"></jsp:include>