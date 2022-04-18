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


<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.css" > 
<script type="text/javascript" src="<%= ctxPath%>/jquery-ui-1.13.1.custom/jquery-ui.js"></script>


<script type="text/javascript">
	$(document).ready(function(){
	
	$(".spinner").spinner({
		spin: function(event, ui) {
			const $target = $(event.target);
			
			if(ui.value > 10) {
				$target.spinner("value", 10);
				return false;
			}
			else if(ui.value < 1) {
				$target.spinner("value", 1);
				return false;
			}
		}
	});// end of $(".spinner").spinner({});-----------------
	
	// 장바구니 일부상품 삭제
	$("button#deleteSome").click(function(){
		
		const cart_check_list = document.getElementsByName("cart_check");
		let cart_checked = "";
		let cnt = 0;
		for(let cart_checkbox of cart_check_list){
			
			if(cart_checkbox.checked){
				cnt++;
				if(cnt > 1){
					cart_checked += ",";
				}
				cart_checked += cart_checkbox.value;
			}
		}// end of for
		
		$.ajax({
			url:"<%= ctxPath%>/product/deleteCartItem.an",
			type:"POST",
			data:{"cart_checkBox":cart_checked,
				  "userid":"${sessionScope.loginuser.userid}"},
			type:"post",
			success:function(text){
				const result = JSON.parse(text);
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
	
	// 장바구니 개별상품 주문
	$("button#orderOne").click(function(event){
		
		const $target = $(event.target);
		$target.parent().parent().parent().find("input#cart_check").prop("checked",true);
		
		goOrder();
		
	});// end of $("button#orderAll").click(function(){ -------------------------------------
	
	// 장바구니 일부상품 주문
	$("button#orderSome").click(function(){

		//	console.log( $("input:checkbox[name='cart_check']:checked").length );
		// 0 1 2 ...
		
		if($("input:checkbox[name='cart_check']:checked").length == 0){
			alert("주문할 상품을 선택해주세요!");
			return false;
		}
		
		goOrder();
		
	});// end of $("button#orderSome").click(function(){ -------------------------------------

	// 장바구니 모든상품 주문
	$("button#orderAll").click(function(){
		
	//	console.log( $("input:checkbox[name='cart_check']:checked").length );
		// 0 1 2 ...
		
		if($("input:checkbox[name='cart_check']").length == 0){
			alert("주문할 상품이 없습니다!");
			return false;
		}
		
		const cart_check_list = document.getElementsByName("cart_check");
		let cart_checked = "";
		let cnt = 0;
		for(let cart_checkbox of cart_check_list){
			cnt++;
			if(cnt > 1){
				cart_checked += ",";
			}
			cart_checked += cart_checkbox.value;
		//	console.log(cart_checked); cartno 1, 2, ...4
			
		}// end of for
		
		$("input#cart_checked").val(cart_checked);
	//	console.log("확인용 cart_checked =>" + cart_checked);
		
		const frm = document.cartOrderFrm;
		frm.action = "myOrder.an";
		frm.method= "post";
		frm.submit();
		
	});// end of $("button#orderAll").click(function(){ -------------------------------------
	
		
	
		
		
		
		
});

// Function Declaration

	// 개별상품 주문과 선택상품 주문시 사용하는 주문function
	function goOrder() {
		
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
		
	}// end of function goOrder() {-----------------------------------
		
	
	// === 장바구니 현재주문수량 수정하기 === // 
	function goOqtyEdit(obj, userid) {
		
		const index = $("button.updateBtn").index(obj);
	//	alert(index);
		
		const cartno = $("input.cartno").eq(index).val();
    //  alert("장바구니번호 : " + cartno);	
		
		const oqty = $("input.oqty").eq(index).val();
	//	alert("주문량 : " + oqty);
		
		const regExp = /^[0-9]+$/g; // 숫자만 체크하는 정규표현식
		const bool = regExp.test(oqty);
	
		if(!bool) {
			alert("수정하시려는 수량은 0개 이상이어야 합니다.");
			location.href="javascript:history.go(0);";
			return;
		}
		//  alert("장바구니번호 : " + cartno + "\n주문량 : " + oqty);
		else{
			$.ajax({
					url:"<%= ctxPath%>/product/cartEdit.an",
					type:"POST",
					data:{"cartno":cartno,
						  "oqty":oqty,
						  "userid":userid},
					dataType:"JSON",
					success:function(json){
						if(json.n == 1) {
							alert("주문수량이 변경되었습니다.");	
							location.href = "myCart.an?userid="+userid; 
						}
					},
					error: function(request, status, error){
						alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
					}
				});
		}
	 
	}// end of function goOqtyEdit(obj)-----------------

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
			<c:forEach var="productvo" items="${requestScope.productList}" >
				<div id="cartItems" >
					<hr>
					<div class="form-check">
					  <input type="checkbox" id="cart_check" name="cart_check" value="${productvo.cvo.cartno }" class="form-check-input" style="margin: 80px -60px; width: 15px; height: 15px;">
					  <input type="hidden" name="userid" value="${sessionScope.loginuser.userid }">
					  <input type="hidden" id="cart_checked" name="cart_checked" value="">
					</div>
					
					<div class="row">
						<div class="col-2">
							<a id="imgcontainer" class="col-4 stretched-link" href="">
								<img src="<%=ctxPath %>/images/product/${productvo.productimage1}" class="" alt="..." >
							</a>
						</div>
						<div class="col-5" id="itemdetail">
							<a id="itemName">${productvo.productname}</a>
							<strong>${productvo.productprice}원</strong>
							<!-- <span>구매가격(할인후)</span> -->
							<a style="display: inline-block;">[옵션: ${productvo.cvo.optionname}]</a>
							<a>[적립금: <span id="point">${productvo.point}</span>원]</a>
						</div>
						
						<div id="itemqnt" class="col-3">
							수량:&nbsp;<input class="spinner oqty" id="quantity_0" style="width: 30px; height: 20px;" value="${productvo.cvo.orderqty}" />개
							<button class="btn btn-outline-secondary btn-sm updateBtn" type="button" onclick="goOqtyEdit(this,'${requestScope.userid}')">수정</button>
							<%-- 장바구니 테이블에서 특정제품의 현재주문수량을 변경하여 적용하려면 먼저 장바구니번호(시퀀스)를 알아야 한다 --%>
			               	<input type="hidden" class="cartno" value="${productvo.cvo.cartno}" /> 
						</div>
						
						<div id="itemselect" class="col-2">
							<button id="orderOne" type="button" class="btn btn-secondary btn-sm mb-3">주문하기</button>
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