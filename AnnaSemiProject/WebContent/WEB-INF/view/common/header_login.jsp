<<<<<<< HEAD

=======

>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
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
<<<<<<< HEAD
=======

	<!-- 상단 네비게이션 시작 -->
	<nav class="navbar-expand-lg  bg-white navbar-light fixed-top" id = "first-nav" >
		<!-- Brand/logo --> <!-- Font Awesome 5 Icons -->
		<a class="d-flex justify-content-center mr-0" href="#" style="margin-right: 10%;"><img class="mt-3" id = "logo" src="<%= ctxPath %>/images/logo.png" /></a>
		
		<!-- 아코디언 같은 Navigation Bar 만들기 -->
	    <button class="navbar-toggler " type="button"onclick="openNav()">
	      <span class="navbar-toggler-icon" > </span>
	    </button>
		
		<div class="collapse navbar-collapse row-vh justify-content-end mx-2" >
		  <ul class="navbar-nav">

		     
		     

		     <li class="nav-item">
		        <a class="nav-link h6" href="<%= ctxPath %>/index.an">Mypage</a>
		     </li>
		     <c:if test="${empty sessionScope.loginuser}">
			     <li class="nav-item">
			     	<a class="nav-link h6" href="<%= ctxPath %>/login/login.an">Login</a>
			     </li>
				 <li class="nav-item">
				    <a class="nav-link h6" href="<%= ctxPath %>/member/memberRegister.an">Join</a>
				 </li>
			 </c:if>

				 <li class="nav-item">
			        <a class="nav-link h6" href="<%= ctxPath %>/index.an">Mypage</a>
			     </li>
			<c:if test="${not empty sessionScope.loginuser}">
			 	<li class="nav-item">
				    <a class="nav-link h6" href="<%= ctxPath %>/login/logout.an">Logout</a>
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
			  <li class="nav-item dropdown">
			        <a class="nav-link h6" href="#" id="navbarDropdown"> 
			                      Help                     
			        </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			           <a class="dropdown-item" href="#">공지사항</a>
			           <a class="dropdown-item" href="#">QnA</a>
			        </div>
			 </li>
			 
		  </ul>
		</div>
		
		<div class="collapse navbar-collapse row-vh mx-2"  >
		  <ul class="navbar-nav flex-row mb-2"  style="font-size: 12pt;">
		       <li class="nav-item dropdown">
			        <a class="nav-link menufont_size" href="#" id="navbarDropdown"> 
			                      Necklaces                     
			        </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			           <a class="dropdown-item" href="#">gold</a>
			           <a class="dropdown-item" href="#">silver</a>
			           <a class="dropdown-item" href="#">diamond</a>
			        </div>
			 </li>
		     <li class="nav-item dropdown">
		        <a class="nav-link menufont_size" href="#" id="navbarDropdown"> 
		                      Earings                    
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		           <a class="dropdown-item" href="#">gold</a>
		           <a class="dropdown-item" href="#">silver</a>
		           <a class="dropdown-item" href="#">diamond</a>
		        </div>
		     </li>
		     <li class="nav-item dropdown">
		        <a class="nav-link menufont_size" href="#" id="navbarDropdown"> 
		                      Rings                    
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		           <a class="dropdown-item" href="#">gold</a>
		           <a class="dropdown-item" href="#">silver</a>
		           <a class="dropdown-item" href="#">diamond</a>
		        </div>
		     </li>
		     <li class="nav-item dropdown">
		        <a class="nav-link menufont_size" href="#" id="navbarDropdown"> 
		                      Bracelets                    
		        </a>
		        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
		           <a class="dropdown-item" href="#">gold</a>
		           <a class="dropdown-item" href="#">silver</a>
		           <a class="dropdown-item" href="#">diamond</a>
		        </div>
		     </li>
		      <li class="nav-item active">
		     	<a class="nav-link menufont_size" href="#" style="color:#00000080;">Sale</a>
		     </li>
		  </ul>
  		</div>		
	  	
	  	<div class="navbar-nav flex-row mb-2 mx-3" id = "search">
     		<form class="form-inline" >
		     	<div class="input-group rounded mb-2">
		           <input type="search" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon"/>
		           <span class="input-group-text border-0" id="search-addon">
		           <i type="submit" class="fas fa-search"></i>
		          </span>
		       </div>
     		</form>

   <!-- 상단 네비게이션 시작 -->
   <nav class="navbar-expand-lg  bg-white navbar-light fixed-top" id = "first-nav" >
      <!-- Brand/logo --> <!-- Font Awesome 5 Icons -->
      <a class="d-flex justify-content-center mr-0" href="#" style="margin-right: 10%;"><img class="mt-3" id = "logo" src="<%= ctxPath %>/images/logo.png" /></a>
      
      <!-- 아코디언 같은 Navigation Bar 만들기 -->
       <button class="navbar-toggler " type="button"onclick="openNav()">
         <span class="navbar-toggler-icon" > </span>
       </button>
      
      <div class="collapse navbar-collapse row-vh justify-content-end mx-2" >
        <ul class="navbar-nav">

           
           

           <li class="nav-item">
              <a class="nav-link h6" href="<%= ctxPath %>/index.an">Mypage</a>
           </li>
           <c:if test="${empty sessionScope.loginuser}">
              <li class="nav-item">
                 <a class="nav-link h6" href="<%= ctxPath %>/login/login.an">Login</a>
              </li>
             <li class="nav-item">
                <a class="nav-link h6" href="<%= ctxPath %>/member/memberRegister.an">Join</a>
             </li>
          </c:if>

             <li class="nav-item">
                 <a class="nav-link h6" href="<%= ctxPath %>/index.an">Mypage</a>
              </li>
         <c:if test="${not empty sessionScope.loginuser}">
             <li class="nav-item">
                <a class="nav-link h6" href="<%= ctxPath %>/login/logout.an">Logout</a>
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
           <li class="nav-item dropdown">
                 <a class="nav-link h6" href="#" id="navbarDropdown"> 
                               Help                     
                 </a>
                 <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="#">공지사항</a>
                    <a class="dropdown-item" href="#">QnA</a>
                 </div>
          </li>
          
        </ul>
      </div>
      
      <div class="collapse navbar-collapse row-vh mx-2"  >
        <ul class="navbar-nav flex-row mb-2"  style="font-size: 12pt;">
             <li class="nav-item dropdown">
                 <a class="nav-link menufont_size" href="#" id="navbarDropdown"> 
                               Necklaces                     
                 </a>
                 <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="#">gold</a>
                    <a class="dropdown-item" href="#">silver</a>
                    <a class="dropdown-item" href="#">diamond</a>
                 </div>
          </li>
           <li class="nav-item dropdown">
              <a class="nav-link menufont_size" href="#" id="navbarDropdown"> 
                            Earings                    
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                 <a class="dropdown-item" href="#">gold</a>
                 <a class="dropdown-item" href="#">silver</a>
                 <a class="dropdown-item" href="#">diamond</a>
              </div>
           </li>
           <li class="nav-item dropdown">
              <a class="nav-link menufont_size" href="#" id="navbarDropdown"> 
                            Rings                    
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                 <a class="dropdown-item" href="#">gold</a>
                 <a class="dropdown-item" href="#">silver</a>
                 <a class="dropdown-item" href="#">diamond</a>
              </div>
           </li>
           <li class="nav-item dropdown">
              <a class="nav-link menufont_size" href="#" id="navbarDropdown"> 
                            Bracelets                    
              </a>
              <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                 <a class="dropdown-item" href="#">gold</a>
                 <a class="dropdown-item" href="#">silver</a>
                 <a class="dropdown-item" href="#">diamond</a>
              </div>
           </li>
            <li class="nav-item active">
              <a class="nav-link menufont_size" href="#" style="color:#00000080;">Sale</a>
           </li>
        </ul>
        </div>      
        
        <div class="navbar-nav flex-row mb-2 mx-3" id = "search">
           <form class="form-inline" >
              <div class="input-group rounded mb-2">
                 <input type="search" class="form-control rounded" placeholder="Search" aria-label="Search" aria-describedby="search-addon"/>
                 <span class="input-group-text border-0" id="search-addon">
                 <i type="submit" class="fas fa-search"></i>
                </span>
             </div>
           </form>
         </div>

    <hr style="background-color: #ccc; height: 1.2px; position: relative; top:10px; margin: 0; margin-bottom: 10px;">

	</nav>
	
		
	
		<div id="myNav" class="overlay">
	  <a href="javascript:void(0)" class="closebtn"onclick="closeNav()" >&times;</a>
	  <div class="overlay-content">
	    <a href="#">Necklaces</a>
	    <a href="#">Earring</a>
	    <a href="#">Ring</a>
	    <a href="#">Bracelets</a>
	    <a href="#">Sale</a>
	    <c:if test="${empty sessionScope.loginuser}">

		    <a href="<%= ctxPath %>/login/login.an">Login</a>
		    <a href="<%= ctxPath %>/member/memberRegister.an">Join</a>
	    </c:if>
	     <c:if test="${empty sessionScope.loginuser}">
		    <a href="<%= ctxPath %>/login/logout.an">Logout</a>
		    <a href="<%= ctxPath %>/member/myPage.an">mypage</a>

	    	<a href="<%= ctxPath %>/login/login.an">Login</a>
	    	<a href="<%= ctxPath %>/member/memberRegister.an">Join</a>
	    </c:if>
	    <c:if test="">
	    	<a href="<%= ctxPath %>/login/logout.an">Login</a>
	    </c:if>
	    <a href="#">Event</a>
	    <a href="#">Review</a>
	    <a href="#">Cart</a>
	    <a href="#">Help</a>
	  </div>
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
       <c:if test="${empty sessionScope.loginuser}">

          <a href="<%= ctxPath %>/login/login.an">Login</a>
          <a href="<%= ctxPath %>/member/memberRegister.an">Join</a>
       </c:if>
        <c:if test="${empty sessionScope.loginuser}">
          <a href="<%= ctxPath %>/login/logout.an">Logout</a>
          <a href="<%= ctxPath %>/member/myPage.an">mypage</a>

          <a href="<%= ctxPath %>/login/login.an">Login</a>
          <a href="<%= ctxPath %>/member/memberRegister.an">Join</a>
       </c:if>
       <c:if test="">
          <a href="<%= ctxPath %>/login/logout.an">Login</a>
       </c:if>
       <a href="#">Event</a>
       <a href="#">Review</a>
       <a href="#">Cart</a>
       <a href="#">Help</a>
     </div>
   </div>


<<<<<<< HEAD


   <!-- 상단 네비게이션 끝 -->

    <hr style="position: relative; top:10px; margin: 0; margin-bottom: 250px; ">
=======
</style>
</head> 
<body>

	<!-- 상단 네비게이션 시작 -->
<<<<<<< HEAD
	<nav class="navbar-expand-lg bg-white navbar-light fixed-top" id="first-nav">
=======
	<nav class="navbar-expand-lg  bg-white navbar-light mx-5 fixed-top" id = "first-nav">
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
		<!-- Brand/logo --> <!-- Font Awesome 5 Icons -->
<<<<<<< HEAD
		<a class="d-flex justify-content-center mr-0" href="#" style="margin-right: 10%;"><img class = "mt-3" id = "logo" src="<%= ctxPath %>/images/logo.png" /></a>
=======
		<a class="d-flex justify-content-center mr-0" href="#" style="margin-right: 10%;"><img class = "mt-3"  id = "logo" src="<%= ctxPath %>/images/logo.png" /></a>
		
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
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
<<<<<<< HEAD
		<hr style="background-color: #ccc; height: 1.2px; position: relative; top: 10px; margin: 0; margin-bottom: 10px;">
=======

	<hr style="background-color: #ccc; height: 1.2px; position: relative; top:0; margin: 0; margin-bottom: 0;">
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
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


	  
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
>>>>>>> branch 'main' of https://github.com/Helenhyerim/AnnaSemiProject.git
