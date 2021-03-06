<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	String ctxPath = request.getContextPath();
%>

<jsp:include page="../common/header_login.jsp"></jsp:include>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>





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
							<button class = "login_element" type = "button" id = "btnLogin" style = "background-color: #999;" onclick = "goLogin()" >로그인</button>
						</td>
					</tr>
					
					<tr>
						<td>
							<button class = "login_element" type = "button" id = "btnRegister">회원가입</button>
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