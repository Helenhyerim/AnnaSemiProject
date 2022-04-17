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
	
	

	
	
});

//로그인 버튼을 눌렀을 경우 로그인을 실행하는 함수 
function leave(){
	
	const userid = $("input#userid").val().trim();
	const pwd = $("input#pwd").val().trim();
	
	if(userid == "") {
		alert("아이디를 입력하세요!!");
		$("input#loginUserid").val("");
		$("input#loginUserid").focus();
		return;  // goLogin() 함수 종료
	}
	
	if(pwd == "") {
		alert("암호를 입력하세요!!");
		$("input#loginPwd").val("");
		$("input#loginPwd").focus();
		return;  // goLogin() 함수 종료
	}
	
	if(!("${requestScope.userid}" ==  userid && "${requestScope.pwd}" == pwd)){
		alert("회원님의 비밀번호와 입력하신 비밀번호가 다릅니다.");	
		return;
	}

	const frm = document.loginfrm;
	frm.action = "<%= request.getContextPath()%>/leave.an";
	frm.method = "post";
	frm.submit();
	
}// end of function goLgoin() ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


function goCancel(){
	location.href = "<%= ctxPath%>/index.an";	
}

</script>

	<div class="container" >
	  <div class = "mt-1 ml-0 mb-5"style="width: 80%; margin: 80% auto; ">
		<!-- div 태그의 margin 80% 을 0 으로 바꾸고, 여기에 원하는 내용을 작성하세요! -->
		<span class = "h3" style = "color:#888">회원탈퇴</span>
		
	  </div>		
	  
	  <div class = "my-5 text-center"style="width: 80%; margin: 80% auto;">
		<form name = "loginfrm" style = "margin-bottom: 200px;">
			<table style = "margin: auto; width: 80%;">
				<thead >
					<tr>
						<th class = "h3" colspan = "2" style = "color:#888;">회원탈퇴</th>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td style = "width:80%;">
							<input type = "text" name = userid placeholder="ID" class = "login_element" id = "userid"/>
						</td>
					</tr>	
					
					<tr>
						<td style = "width:80%;">
							<input type = "password" name = pwd placeholder="password" class = "login_element" id = "pwd"/>
						</td>
					</tr>
					
					<tr>
						<td>
							<button class = "login_element btn btn-dark btn-lg text-center" type = "button"   onclick = "leave()" >회원탈퇴</button>
						</td>
					</tr>
					
					<tr>
						<td>
							<button type="button"  class = "login_element btn btn-light btn-lg text-center" type = "button" onclick = "goCancel();" >취소하기</button>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	  </div>	
	</div>

<jsp:include page="../common/footer.jsp"></jsp:include>