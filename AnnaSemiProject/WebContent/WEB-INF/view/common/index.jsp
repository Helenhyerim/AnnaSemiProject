<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
	String ctxPath = request.getContextPath();
%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index.css" />




<jsp:include page="header_login.jsp"/>
	
	<div class="container">
	
		<div style="width: 90%; margin: 0 auto 250px auto;">
			<div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel">
			  <ol class="carousel-indicators">
			    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
			    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
			  </ol>
			  
			  <div class="carousel-inner">
			   
			    <div class="carousel-item active">
			      <img src="<%= ctxPath %>/images/index/carousel_img1.png" class="d-block w-100 carousel_img" alt="..."> <!-- d-block 은 display: block; 이고  w-100 은 width 의 크기는 <div class="carousel-item active">의 width 100% 로 잡으라는 것이다. -->
			    </div>
			    <div class="carousel-item">
			      <img src="<%= ctxPath %>/images/index/carousel_img2.png" class="d-block w-100 carousel_img" alt="...">
			    </div>
			    <div class="carousel-item">
			      <img src="<%= ctxPath %>/images/index/carousel_img3.png" class="d-block w-100 carousel_img" alt="...">
			    </div>
			  
			  </div>
			  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="sr-only">Previous</span>
			  </a>
			  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="sr-only">Next</span>
			  </a>
			</div>
	  </div>
	  
	  <div style="width: 80%; margin: 0 auto 200px auto;">
	  	
		<div class="col-md-12 ">
	  		<div class="row">
		        <div class="col-7">
		        <a href=""> <img id="img_all" src="<%= ctxPath %>/images/index/index_menuimg1.png" class="img-responsive img-rounded "  /></a>
		          <h4>텍스트1</h4>
		        </div>
		        
		        <div class="col-5">
		         <a href="">  <img id="img_sale" src="<%= ctxPath %>/images/index/index_menuimg6.png" class="img-responsive img-rounded"  /></a>
		          <h4>텍스트2</h4>
		    	</div>
			</div>
    	</div>
      

        <div class="col-md-12 ">
	  		<div class="row">
		        <div class="col-4">
		         <div>
		         <a href="">  <img id="img_necklaces" src="<%= ctxPath %>/images/index/index_menuimg2.png" class="img-responsive img-rounded "  /></a>
		          <div id="text_necklaces"><h5>텍스트1</h5></div>
		         </div>
		         
		         <div>
		         <a href="">  <img id="img_rings" src="<%= ctxPath %>/images/index/index_menuimg2.png" class="img-responsive img-rounded "  /></a>
		          <div id="text_rings"><h5>텍스트1</h5></div>
		          </div>
		        </div>
		         
		        <div class="col-8">
		         <a href="">  <img id="img_top10" src="<%= ctxPath %>/images/index/index_menuimg3.png" class="img-responsive img-rounded"  /></a>
		          <h4>텍스트2</h4>
		    	</div>
			</div>
    	</div>
    
	  	
	  </div>
	  
	  <div>
	  
	  </div>
	  
	  
	  
	  	
	</div>



<jsp:include page="footer.jsp"/>