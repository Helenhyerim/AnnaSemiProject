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
		
		
		// *** select 태그에 대한 이벤트는 click 이 아니라 change 이다. ***//
		$("select#sizePerPage").bind("change", function(){
			
			const frm = document.productFrm;
			frm.action = "categoryClick.an";
			frm.method = "get";
			frm.submit();
			$("select#sort").val("${requestScope.sort}");
			
		});
		
		$("select#sizePerPage").val("${requestScope.sizePerPage}");
		
		// *** select 태그에 대한 이벤트는 click 이 아니라 change 이다. ***//
		$("select#sort").bind("change", function(){
			
			const frm = document.productFrm;
			frm.action = "categoryClick.an";
			frm.method = "get";
			frm.submit();
			$("select#sizePerPage").val("${requestScope.sizePerPage}");
		});
		
		$("select#sort").val("${requestScope.sort}");
		
	});
	
	// Function Declaration
	
	
	
</script>

	<div class="container" style="">
		<div class="mb-5">
			<div id="top-container">
			<h1 class="my-5 text-dark" id="categoryname">
			<c:set var="categorynum" value="${requestScope.categorynum}" />
				<c:choose>
					<c:when test="${categorynum eq 1}">
		    			Necklaces
		    		</c:when>
		    		<c:when test="${categorynum eq 2}">
		    			Earings
		    		</c:when>
		    		<c:when test="${categorynum eq 3}">
		    			Rings
		    		</c:when>
		    		<c:when test="${categorynum eq 4}">
		    			Bracelets
		    		</c:when>
		    		<c:otherwise>
		    			SALE
		    		</c:otherwise>
				
				</c:choose>
			
			</h1>	
				<form name="productFrm" action="categoryClick.an" method="get" >	
					
					<input type="hidden" name="categorynum" value="${requestScope.categorynum}">
					
					<span style="color: red; font-weight: bold; font-size: 12pt;">페이지당 제품개수-</span>
				        <select id="sizePerPage" name="sizePerPage">
					        <option value="9">9</option>
					        <option value="6">6</option>
					        <option value="3">3</option>
				        </select>
					
					
					<div class="dropdown mb-5" style="margin-left: 90%;">
						<select id="sort" name="sort" class="form-select" aria-label="Default select example">
						  <option value="1" selected>등록순</option>
						  <option value="2">가격높은순</option>
						  <option value="3">가격낮은순</option>
						</select>
					</div>
				</form>
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
				 	<c:if test="${not empty requestScope.productList}">
					 	<c:forEach var="productvo" items="${requestScope.productList}">
						  <div class="col-4" style="margin-bottom: 100px;" class="clickProduct">
							  <a href="<%=ctxPath %>/product_lsh/productDetail.an?productnum=${productvo.productnum}" class="productDetail">
							    <img src="<%=ctxPath %>/images/${productvo.productimage1}" class="card-img-top" alt="..." >
							  </a>
						      <span id="product_detail">
							      <a href="" style="" class="productDetail">${productvo.productname}</a>
							      <a href="" style="" class="productDetail">${productvo.productprice}원</a>
						      </span>
						  </div>
						</c:forEach> 
					</c:if> 
					</div>
					
			 	</div>
		 	</div>
		</div>
		
	</div>
	
	<div id="bottom-container">
		<nav class="" aria-label="Page navigation example" >
			  <ul class="pagination justify-content-center  py-5">${requestScope.pageBar}</ul>
		</nav>
	</div>

<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>