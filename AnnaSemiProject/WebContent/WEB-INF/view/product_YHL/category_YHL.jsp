<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /AnnaSemiProject
%>
<jsp:include page="/WEB-INF/view/common/header_login.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/category_YHL.css" />
<style>

</style>
<script type="text/javascript">
	$(document).ready(function(){
		
	});
	
	// Function Declaration
	
	function getproductnum() {
		
	}
	

</script>

	<div class="container" style="">
		<div class="mb-5">
			<div id="top-container">
				<h1 class="my-5 text-dark">Necklaces</h1>
	
				<div class="dropdown mb-5" style="margin-left: 90%;">
					<button class="btn btn-light dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
						신상품순
					</button>
					<ul class="dropdown-menu " aria-labelledby="dropdownMenuButton">
						<li class="dropdown-item" href="#">가격높은순</li> 
						<li class="dropdown-item" href="#">가격낮은순</li> 
						<li class="dropdown-item" href="#">판매순</li>
					</ul>
				</div>
			</div>
			
			
			<div id="middle-container" class="row " style="">
				<div class="col-md-2 " id="sideinfo" >
					<div>
						<p class="py-2 mb-0 h5">Color</p>
						<div class="mb-2">
							<div class="form-check">
					  			<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
								  <label class="form-check-label" for="flexCheckDefault">
								    White
								  </label>
							</div>
							<div class="form-check">
					  			<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
								  <label class="form-check-label" for="flexCheckDefault">
								    Gold
								  </label>
							</div>
							<div class="form-check">
					  			<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
								  <label class="form-check-label" for="flexCheckDefault">
								    Rose Gold
								  </label>
							</div>
						</div>
					</div>
					
					<div>
						<p class="py-2 mb-0 h5">Price</p>
						<div class="mb-2">
							<div class="form-check">
					  			<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
								  <label class="form-check-label" for="flexCheckDefault">
								    ~ 200,000
								  </label>
							</div>
							<div class="form-check">
					  			<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
								  <label class="form-check-label" for="flexCheckDefault">
								    ~ 300,000
								  </label>
							</div>
							<div class="form-check">
					  			<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
								  <label class="form-check-label" for="flexCheckDefault">
								    ~ 400,000
								  </label>
							</div>
						</div>
					</div>
					
					<div>
						<p class="py-2 mb-0 h5">Type</p>
						<div class="mb-2">
							<div class="form-check">
					  			<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
								  <label class="form-check-label" for="flexCheckDefault">
								    Long
								  </label>
							</div>
							<div class="form-check">
					  			<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault">
								  <label class="form-check-label" for="flexCheckDefault">
								    Bold
								  </label>
							</div>
						</div>
					</div>
			 
			 	</div>
			 	
			 	
			 	<div id="image-container" class="col-md-10 ">
				 	<div class="row">
				 	
				 	<c:forEach var="productvo" items="${requestScope.imgList}">
					  <div class="col-4" style="margin-bottom: 100px;" >
						  <a href="<%=ctxPath %>/product_lsh/productDetail.an" onclick="">
						    <img src="<%=ctxPath %>/images/${productvo.productimage1}" class="card-img-top" alt="..." >
						  </a>
					      <span id="product_detail">
						      <a href="" style="">14K NECKLACE / ANS0395DRL</a>
						      <a href="" style="">270,000원</a>
					      </span>
					  </div>
					</c:forEach> 
					 
					  <a class="col-4" href=""  >
					    <img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="card-img-top" alt="...">
					      <span id="product_detail">
						      <span style="">14K NECKLACE / ANS0395DRL</span>
						      <span style="">270,000원</span>
					      </span>
					  </a>
					  
					  <a class="col-4" href=""  >
					    <img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="card-img-top" alt="...">
					      <span id="product_detail">
						      <span style="">14K NECKLACE / ANS0395DRL</span>
						      <span style="">270,000원</span>
					      </span>
					  </a>
					  
					  <a class="col-4" href="" style="margin-bottom: 100px;" >
					    <img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="card-img-top" alt="...">
					      <span id="product_detail">
						      <span style="">14K NECKLACE / ANS0395DRL</span>
						      <span style="">270,000원</span>
					      </span>
					  </a>
					  
					  <a class="col-4" href=""  >
					    <img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="card-img-top" alt="...">
					      <span id="product_detail">
						      <span style="">14K NECKLACE / ANS0395DRL</span>
						      <span style="">270,000원</span>
					      </span>
					  </a>
					  
					  <a class="col-4" href=""  >
					    <img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="card-img-top" alt="...">
					      <span id="product_detail">
						      <span style="">14K NECKLACE / ANS0395DRL</span>
						      <span style="">270,000원</span>
					      </span>
					  </a>
					  
					  <a class="col-4" href=""  style="margin-bottom: 100px;">
					    <img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="card-img-top" alt="...">
					      <span id="product_detail">
						      <span style="">14K NECKLACE / ANS0395DRL</span>
						      <span style="">270,000원</span>
					      </span>
					  </a>
					  
					  <a class="col-4" href=""  >
					    <img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="card-img-top" alt="...">
					      <span id="product_detail">
						      <span style="">14K NECKLACE / ANS0395DRL</span>
						      <span style="">270,000원</span>
					      </span>
					  </a>
					  
					  <a class="col-4" href=""  >
					    <img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="card-img-top" alt="...">
					      <span id="product_detail">
						      <span style="">14K NECKLACE / ANS0395DRL</span>
						      <span style="">270,000원</span>
					      </span>
					  </a>
					</div>
					
			 	</div>
		 	</div>
		</div>
		
	</div>
	
	<div id="bottom-container">
		<nav class="" aria-label="Page navigation example" >
			  <ul class="pagination justify-content-center  py-5">
			    <li class="page-item"><a class="page-link" href="#">Previous</a></li>
			    <li class="page-item active"><a class="page-link" href="#">1</a></li>
			    <li class="page-item"><a class="page-link" href="#">2</a></li>
			    <li class="page-item"><a class="page-link" href="#">3</a></li>
			    <li class="page-item"><a class="page-link" href="#">Next</a></li>
			  </ul>
		</nav>
	</div>

<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>