<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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


</style>
<script type = "text/javascript">
 
$(document).ready(function(){
		
	$("input#email").bind("keydown", function(event){
		if(event.keyCode == 13) { // 이메일입력란에 엔터를 했을 경우 
			goIdFind(); // 아이디 찾기를 시도한다.
		}
	});
		
});
//유효성검사를 한뒤에 post 형식으로 보내준다.
function goIdFind(){
	
	const name = $("input#name").val().trim();
	const regExp = new RegExp(/^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i); 
	
	const bool = regExp.test($("input#email").val());
	if(name == ""){
		alert("이름을 입력하세요.");
		return;
	}
	if(!bool){
		alert("이메일 형식에 맞지않습니다.");
		return;
	}
	
	
	const frm = document.idFindfrm;
	frm.action = "<%= request.getContextPath()%>/login/idFind.an";
	frm.method = "post";
	frm.submit();
	
}
// 취소하기 버튼
function goCancel(){
	location.href = "<%= request.getContextPath()%>/index.an";	
}
 </script>

<div class = "container mb-5">
	<!-- div 태그의 margin 80% 을 0 으로 바꾸고, 여기에 원하는 내용을 작성하세요! -->
	<span class = "h3 " style = "color:#888">아이디 찾기</span>
</div>
<div class="container"  style = "text-align: center;" >
	
	
	<div style = "display:inline-block; width: 50%; ">
				
	    <div class = "container">
			<form name = "idFindfrm" style = "margin-bottom: 200px;" class = "text-center">
				<div class = "row">
					<div class = "col-md-2"> 이름</div>
					<input type = "text" name = "name" id = "name" class = "col-md-10"/>
				
				</div>
				<div class = "row">
					<div class = "col-md-2"> 이메일</div>
					<input type = "email" name = "email" id = "email" class = "col-md-10" />
				</div>
				<div class = "row">
					<button class = "login_element w-100 btn btn-dark btn-lg text-center mb-2" type = "button" id = "btnIdFind"  onclick = "goIdFind()" >아이디 찾기</button>
					<button class = "login_element w-100 btn btn-light btn-lg text-center" type = "button" onclick = "goCancel();" >취소하기</button>
				</div>
		    </form>
		</div>	
	</div>
</div>

<jsp:include page="../common/footer.jsp"></jsp:include>