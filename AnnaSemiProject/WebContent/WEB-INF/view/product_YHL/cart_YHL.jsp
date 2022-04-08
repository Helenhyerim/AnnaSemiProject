<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /AnnaSemiProject
%>
<jsp:include page="/WEB-INF/view/common/header_login.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/cartpage_YHL.css" />
<style type="text/css">

</style>
<script type="text/javascript">
$(document).ready(function(){
	
	
	// 장바구니 일부상품 삭제
	$("button#deleteSome").click(function(){
		
		const cart_check_list = document.getElementsByName("cart_check");
		let cart_checked = "";
		let cnt = 0;
		for(let cart_checkbox of cart_check_list){
			
			if(cart_checkbox.checked){
			//	console.log("확인용 cartno =>" + cart_checkbox.value); // cartno 1, 2, ...
				cnt++;
				if(cnt > 1){
					cart_checked += ",";
				}
				cart_checked += cart_checkbox.value;
			//	console.log(cart_checked); cartno 1, 2, ...4
			}
		}// end of for
		
		$.ajax({
			url:"<%= ctxPath%>/product/deleteCartItem.an",
			type:"POST",
			data:{"cart_checkBox":cart_checked,
				  "userid":"${sessionScope.loginuser.userid}"},
			type:"post",
			success:function(text){
				
				console.log("확인용 text => " + text);
				console.log("확인용 typeof text => " + typeof text);
				const result = JSON.parse(text);
				
			//	console.log("확인용 result => " + result);
			//	console.log("확인용 typeof result => " + typeof result);
				
				if(result.cartDeleteResult){
					alert("선택하신 장바구니 상품이 삭제되었습니다");
					window.location.reload(); // 페이지 새로고침
				}
			},
			error:function(request, status, error){
  	    	  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  	      }
		})// end of $.ajax
		
	});// end of $("button#deleteSome").click(function(){ -------------------------------------
	
		
	// 장바구니 전체상품 삭제
	$("button#deleteAll").click(function(){	
		
		const cart_check_list = document.getElementsByName("cart_check");
		let cart_all = "";
		let cnt = 0;
		
		for(let cart_allCheckBox of cart_check_list){
			cnt++;
			
			if(cnt > 1){
				cart_all += ",";
			}
			cart_all += cart_allCheckBox.value;
			
		}// end of for
		
		$.ajax({
			url:"<%= ctxPath%>/product/deleteCartItem.an",
			type:"POST",
			data:{"cart_checkBox":cart_all,
				  "userid":"${sessionScope.loginuser.userid}"},
			type:"post",
			success:function(text){
				
			//	console.log("확인용 text => " + text);
			//	console.log("확인용 typeof text => " + typeof text);
				const result = JSON.parse(text);
				
			//	console.log("확인용 result => " + result);
			//	console.log("확인용 typeof result => " + typeof result);
				
				if(result.cartDeleteResult){
					alert("장바구니를 비웠습니다");
					window.location.reload(); // 페이지 새로고침
				}
			},
			error:function(request, status, error){
  	    	  alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
  	      }
		})// end of $.ajax
			
	});// end of $("button#deleteSome").click(function(){----------------------------
	
		
	// 장바구니 일부상품 주문
	$("button#orderSome").click(function(){
		
	//	console.log( $("input:checkbox[name='cart_check']:checked").length );
		// 0 1 2 ...
		
		if($("input:checkbox[name='cart_check']:checked").length == 0){
			alert("주문할 상품을 선택해주세요!");
		}
		
		const cart_check_list = document.getElementsByName("cart_check");
		let cart_checked = "";
		let cnt = 0;
		for(let cart_checkbox of cart_check_list){
			
			if(cart_checkbox.checked){
			//	console.log("확인용 cartno =>" + cart_checkbox.value); // cartno 1, 2, ...
				cnt++;
				if(cnt > 1){
					cart_checked += ",";
				}
				cart_checked += cart_checkbox.value;
			//	console.log(cart_checked); cartno 1, 2, ...4
			}
		}// end of for
		
		$("input#cart_checked").val(cart_checked);
	//	console.log("확인용 cart_checked =>" + cart_checked);
		
	const frm = document.cartOrderFrm;
		frm.action = "myOrder.an";
		frm.method= "post";
		frm.submit();
		
	});// end of $("button#orderSome").click(function(){ -------------------------------------

		
});

// Function Declaration


</script>



	<div class="container" style="width: 90%; margin: 20% auto 10% auto;">
		<h3 class="text-dark text-center">장바구니</h3>
		<div class="py-5">
			
				<button id="deleteSome" type="button" class="btn btn-secondary">선택상품 삭제하기</button>
				<button id="deleteAll" type="button" class="btn btn-secondary">장바구니 비우기</button>
			
			<a type="button" id="keepShopping" class="btn btn-secondary float-right" href="javascript:history.back()">쇼핑 계속하기</a>
		</div>
		
		
		<c:if test="${not empty requestScope.productList}">
		<form name="cartOrderFrm">
			<c:forEach var="productvo" items="${requestScope.productList}">
				<div id="cartItems" >
					<hr>
					<div class="form-check">
					  <input type="checkbox" name="cart_check" value="${productvo.cvo.cartno }" class="form-check-input" style="margin: 80px -60px; width: 15px; height: 15px;">
					  <input type="hidden" name="userid" value="${sessionScope.loginuser.userid }">
					  <input type="hidden" id="cart_checked" name="cart_checked" value="">
					</div>
					
					<div class="row">
						<div class="col-2">
							<a id="imgcontainer" class="col-4 stretched-link" href="">
								<img src="<%=ctxPath %>/images/${productvo.productimage1}" class="" alt="..." >
							</a>
						</div>
						<div class="col-5" id="itemdetail">
							<a id="itemName">${productvo.productname}</a>
							<strong>${productvo.productprice}원</strong>
							<!-- <span>구매가격(할인후)</span> -->
							<a style="display: inline-block;">[옵션: 14K-로즈골드]</a>
							<button type="button" class="btn btn-secondary btn-sm">옵션변경</button>
							<a>[적립금: <span id="point">${productvo.point}</span>원]</a>
						</div>
						<div id="itemqnt" class="col-3">
							수량:&nbsp;<input id="quantity_0" type="text" size="1" value="${productvo.cvo.orderqty}">
						</div>
						<div id="itemselect" class="col-2">
							<button type="button" class="btn btn-secondary btn-sm mb-3">주문하기</button>
							<button type="button" class="btn btn-secondary btn-sm" >찜하기 </button>
						</div>
					</div>
					<hr>
				</div>
			</c:forEach> 
		</form>
		</c:if>
		<c:if test="${empty requestScope.productList}">
			<span>장바구니에 담은 상품이 없습니다.</span>
		</c:if>
		
		<div  style="text-align: center; margin-top: 150px;">
			<button type="button" id="orderAll" class="btn btn-secondary btn-lg mr-3">모든 상품 주문하기</button>
			<button type="button" id="orderSome" class="btn btn-secondary btn-lg" >선택 상품 주문하기</button>
		</div>
	</div>

<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>