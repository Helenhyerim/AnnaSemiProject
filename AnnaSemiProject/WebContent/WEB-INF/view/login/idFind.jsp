<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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


<jsp:include page="../common/footer.jsp"></jsp:include>