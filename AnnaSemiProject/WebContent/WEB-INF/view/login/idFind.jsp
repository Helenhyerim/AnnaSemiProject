<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<<<<<<< HEAD
    
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
	frm.action = "<%= request.getContextPath()%>/login/verifyCertification.up";
	frm.method = "post";
	frm.submit();
	
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
					<button class = "login_element w-100" type = "button" id = "btnIdFind" style = "background-color: #999;" onclick = "goIdFind()" >아이디 찾기</button>
				</div>
					
		    </form>
		</div>	
	</div>
</div>
=======
<%
	String ctxPath = request.getContextPath();
%>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<script type="text/javascript">


</script>
<style type = "text/css">
	button{
		width:100%;
	}

</style>

<!-- 헤더 -->
<jsp:include page="../common/header_login.jsp"></jsp:include>



<div class = "mt-1 ml-0 mb-5" style = "width:80%; margin: 80% auto;">
	<span class = "h3" style = "color:#888; margin:48px;">아이디 찾기 </span>
</div>
<div class = "container"style = "width: 40%;">

<form name="idFindFrm" >
   
    <ul style="list-style-type: none; width:50%; margin: 0 auto;">
    	<li style="margin: 25px 0">
            <label for="name" style="display: inline-block; width: 30%">성명</label>
            <input style = "width:60%" type="text" name="name" id="name" autocomplete="off" required />
        </li>
        <li style="margin: 25px 0">
           <label for="email" style="display: inline-block; width: 30%">이메일</label>
           <input style = "width:60%" type="text" name="email" id="email" autocomplete="off" required />
        </li>
        <li>
           <div class="my-3">
		       <p class="text-center">
		          <button type="button"  id="btnFind">찾기</button>
		       </p>
		   </div>
   		</li>	
    </ul>
   
  

   
</form>
	



</div>


>>>>>>> branch 'member_branch' of https://github.com/Helenhyerim/AnnaSemiProject.git
<jsp:include page="../common/footer.jsp"></jsp:include>