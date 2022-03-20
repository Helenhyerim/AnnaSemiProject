<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>
<%-- ==== JSTL(Java Standard Tag Library) 사용하기 ==== --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>        
    
<!DOCTYPE html>
<html>
<head>

<title>ANNADIA</title>

<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/bootstrap-4.6.0-dist/css/bootstrap.min.css" > 

<!-- Font Awesome 5 Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/style.css" />

<!-- Optional JavaScript -->
<script type="text/javascript" src="<%= ctxPath%>/js/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="<%= ctxPath%>/bootstrap-4.6.0-dist/js/bootstrap.bundle.min.js" ></script> 

<script type="text/javascript">
	
	$(document).ready(function(){
		
		let side_html = "";
		let content_html = ""; 
		for(var i=0; i<15; i++) {
			side_html += (i+1)+".사이드 내용물<br/>";
			content_html += (i+1)+".content 내용물 입니다<br/>";
		}
		
		$("#sidecontent").html(side_html);
		$("#maincontent").html(content_html);
		
	});
	
	function openNav() {
	  document.getElementById("myNav").style.width = "100%";
	  $("div#search").hide();
	  
	}

	function closeNav() {
	  document.getElementById("myNav").style.width = "0%";
	  $("div#search").show();
	}
	
	

</script>
<style>
.overlay {
  height: 100%;
  width: 0;
  position: fixed;
  z-index: 1;
  top: 0;
  left: 0;
  background-color: rgb(0,0,0);
  background-color: rgba(0,0,0, 0.9);
  overflow-x: hidden; 
  transition: 0.5s;
}

.overlay-content {
  position: relative;
  top: 25%;
  width: 100%;
  text-align: center;
  margin-top: 30px;
}

.overlay a {
  padding: 8px;
  text-decoration: none;
  font-size: 36px;
  color: #818181;
  display: block;
  transition: 0.3s;
}

.overlay a:hover, .overlay a:focus {
  color: #f1f1f1;
}

.overlay .closebtn {
  position: absolute;
  top: 90px;
  right: 45px;
  font-size: 60px;
}

@media screen and (max-height: 450px) {
  .overlay a {font-size: 20px}
  .overlay .closebtn {
  font-size: 40px;
  top: 15px;
  right: 35px;
  }
}

#logo {
	width:150px;
}

.dropdown:hover .dropdown-menu{
        display: block;
}
.dropdown-menu{
        margin-top: 0;
}

.dropdown-menu a{
    color: gray !important;
    font-size: 12px;
}


</style>
</head>
<body>

	<!-- 상단 네비게이션 시작 -->
	<nav class="navbar-expand-lg  navbar-light mx-5 my-3 fixed-top" id = "first-nav">
		<!-- Brand/logo --> <!-- Font Awesome 5 Icons -->
		<a class="d-flex justify-content-center mr-0" href="#" style="margin-right: 10%;"><img id = "logo" src="<%= ctxPath %>/images/logo.png" /></a>
		
		<!-- 아코디언 같은 Navigation Bar 만들기 -->
	    <button class="navbar-toggler " type="button"onclick="openNav()">
	      <span class="navbar-toggler-icon" > </span>
	    </button>
		
		<div class="collapse navbar-collapse row-vh justify-content-end" >
		  <ul class="navbar-nav">
		     <li class="nav-item">
		        <a class="nav-link h6" href="<%= ctxPath %>/index.jsp">Mypage</a>
		     </li>
		     <c:if test="${member == null}">
			     <li class="nav-item">
			     	<a class="nav-link h6" href="<%= ctxPath %>/member/memberform.jsp">Login</a>
			     </li>
				 <li class="nav-item">
				    <a class="nav-link h6" href="<%= ctxPath %>/member/memberList.jsp">Join</a>
				 </li>
			 </c:if>
			 <c:if test="${member != null}">
			 	<li class="nav-item">
				    <a class="nav-link h6" href="<%= ctxPath %>/member/memberList.jsp">Logout</a>
				 </li>
			 </c:if>
			 <li class="nav-item">
			    <a class="nav-link h6" href="<%= ctxPath %>/member/memberList.jsp">Event</a>
			 </li>
			 <li class="nav-item">
			    <a class="nav-link h6" href="<%= ctxPath %>/member/memberList.jsp">Review</a>
			 </li>
			 <li class="nav-item">
			    <a class="nav-link h6" href="<%= ctxPath %>/member/memberList.jsp">Cart</a>
			 </li>
			 <li class="nav-item">
			    <a class="nav-link h6" href="<%= ctxPath %>/member/memberList.jsp">Help</a>
			 </li>
			 
		  </ul>
		</div>
		
		<div class="collapse navbar-collapse row-vh "  >
		  <ul class="navbar-nav flex-row mb-2"  style="font-size: 12pt;">
		       <li class="nav-item dropdown">
			        <a class="nav-link menufont_size" href="#" id="navbarDropdown" data-toggle="dropdown"> 
			                      Necklaces                     
			        </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			           <a class="dropdown-item" href="#">gold</a>
			           <a class="dropdown-item" href="#">silver</a>
			           <a class="dropdown-item" href="#">diamond</a>
			        </div>
			 </li>
		     <li class="nav-item dropdown">
		        <a class="nav-link menufont_size" href="#" id="navbarDropdown" data-toggle="dropdown"> 
		                      Earings                    
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		           <a class="dropdown-item" href="#">gold</a>
		           <a class="dropdown-item" href="#">silver</a>
		           <a class="dropdown-item" href="#">diamond</a>
		        </div>
		     </li>
		     <li class="nav-item dropdown">
		        <a class="nav-link menufont_size" href="#" id="navbarDropdown" data-toggle="dropdown"> 
		                      Rings                    
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		           <a class="dropdown-item" href="#">gold</a>
		           <a class="dropdown-item" href="#">silver</a>
		           <a class="dropdown-item" href="#">diamond</a>
		        </div>
		     </li>
		     <li class="nav-item dropdown">
		        <a class="nav-link menufont_size" href="#" id="navbarDropdown" data-toggle="dropdown"> 
		                      Bracelets                    
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		           <a class="dropdown-item" href="#">gold</a>
		           <a class="dropdown-item" href="#">silver</a>
		           <a class="dropdown-item" href="#">diamond</a>
		        </div>
		     </li>
		     <li class="nav-item active">
		     	<a class="nav-link menufont_size" href="#" style="color:gray;">Sale</a>
		     </li>
		  </ul>
  		</div>		
	  	<div class="navbar-nav flex-row mb-2" id = "search">
     		<form class="form-inline" >
		     	<div class="input-group rounded mb-2">
		           <input type="search" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon"/>
		           <span class="input-group-text border-0" id="search-addon">
		           <i class="fas fa-search"></i>
		          </span>
		       </div>
     		</form>
      	</div>

	</nav>
	
	
	<div id="myNav" class="overlay">
	  <a href="javascript:void(0)" class="closebtn"onclick="closeNav()" >&times;</a>
	  <div class="overlay-content">
	    <a href="#">Necklaces</a>
	    <a href="#">Earring</a>
	    <a href="#">Ring</a>
	    <a href="#">Bracelets</a>
	    <a href="#">Sale</a>
	    <a href="#">Login</a>
	    <a href="#">Join</a>
	    <a href="#">Event</a>
	    <a href="#">Review</a>
	    <a href="#">Cart</a>
	    <a href="#">Help</a>
	  </div>
	</div>



	<!-- 상단 네비게이션 끝 -->


	  