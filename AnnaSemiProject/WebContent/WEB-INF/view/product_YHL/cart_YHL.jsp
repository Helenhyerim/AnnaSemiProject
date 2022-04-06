<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	
});

</script>



	<div class="container" style="width: 90%; margin: 20% auto 10% auto;">
		<h3 class="text-dark text-center">장바구니</h3>
		<div class="py-5">
			<button type="button" class="btn btn-secondary">선택상품 삭제하기</button>
			<button type="button" class="btn btn-secondary">장바구니 비우기</button>
			<a type="button" id="keepShopping" class="btn btn-secondary float-right" href="javascript:history.back()">쇼핑 계속하기</a>
		</div>
		
		<!-- 첫번째 아이템-->
		
		<div id="cartItems" >
			<hr>
			<div class="form-check">
			  <input type="checkbox" name="cart_check" class="form-check-input" style="margin: 80px -60px; width: 15px; height: 15px;">
			</div>
			
			<div class="row">
				<div class="col-2">
					<a id="imgcontainer" class="col-4 stretched-link" href="">
						<img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="" alt="..." >
					</a>
				</div>
				<div class="col-5" id="itemdetail">
					<a id="itemName">14K NECKLACE / ANS0395DRL</a>
					<strong>270,000원</strong>
					<!-- <span>구매가격(할인후)</span> -->
					<a style="display: inline-block;">[옵션: 14K-로즈골드]</a>
					<button type="button" class="btn btn-secondary btn-sm">옵션변경</button>
					<a>[적립금: <span id="point"></span>원]</a>
				</div>
				<div id="itemqnt" class="col-3">
					수량:&nbsp;<input id="quantity_0" type="text" size="1" value="1">
				</div>
				<div id="itemselect" class="col-2">
					<button type="button" class="btn btn-secondary btn-sm mb-3">주문하기</button>
					<button type="button" class="btn btn-secondary btn-sm" >찜하기 </button>
				</div>
			</div>
			<hr>
		</div>
		
		<!-- 두번째 아이템-->
		
		<div id="cartItems" >
			
			<div class="form-check">
			  <input type="checkbox" name="cart_check" class="form-check-input" style="margin: 80px -60px; width: 15px; height: 15px;">
			</div>
			
			<div class="row">
				<div class="col-2">
					<a id="imgcontainer" class="col-4 stretched-link" href="">
						<img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="" alt="..." >
					</a>
				</div>
				<div class="col-5" id="itemdetail">
					<a id="itemName">14K NECKLACE / ANS0395DRL</a>
					<strong>270,000원</strong>
					<!-- <span>구매가격(할인후)</span> -->
					<a style="display: inline-block;">[옵션: 14K-로즈골드]</a>
					<button type="button" class="btn btn-secondary btn-sm">옵션변경</button>
					<a>[적립금: <span id="point"></span>원]</a>
				</div>
				<div id="itemqnt" class="col-3">
					수량:&nbsp;<input id="quantity_0" type="text" size="1" value="1">
				</div>
				<div id="itemselect" class="col-2">
					<button type="button" class="btn btn-secondary btn-sm mb-3">주문하기</button>
					<button type="button" class="btn btn-secondary btn-sm" >찜하기 </button>
				</div>
			</div>
			<hr>
		</div>
		
		<!-- 세번째 아이템-->
		
		<div id="cartItems" >
			
			<div class="form-check">
			  <input type="checkbox" name="cart_check" class="form-check-input" style="margin: 80px -60px; width: 15px; height: 15px;">
			</div>
			
			<div class="row">
				<div class="col-2">
					<a id="imgcontainer" class="col-4 stretched-link" href="">
						<img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="" alt="..." >
					</a>
				</div>
				<div class="col-5" id="itemdetail">
					<a id="itemName">14K NECKLACE / ANS0395DRL</a>
					<strong>270,000원</strong>
					<!-- <span>구매가격(할인후)</span> -->
					<a style="display: inline-block;">[옵션: 14K-로즈골드]</a>
					<button type="button" class="btn btn-secondary btn-sm">옵션변경</button>
					<a>[적립금: <span id="point"></span>원]</a>
				</div>
				<div id="itemqnt" class="col-3">
					수량:&nbsp;<input id="quantity_0" type="text" size="1" value="1">
				</div>
				<div id="itemselect" class="col-2">
					<button type="button" class="btn btn-secondary btn-sm mb-3">주문하기</button>
					<button type="button" class="btn btn-secondary btn-sm" >찜하기 </button>
				</div>
			</div>
			<hr>
		</div>
		
		<!-- 네번째 아이템-->
		
		<div id="cartItems" >
			
			<div class="form-check">
			  <input type="checkbox" name="cart_check" class="form-check-input" style="margin: 80px -60px; width: 15px; height: 15px;">
			</div>
			
			<div class="row">
				<div class="col-2">
					<a id="imgcontainer" class="col-4 stretched-link" href="">
						<img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="" alt="..." >
					</a>
				</div>
				<div class="col-5" id="itemdetail">
					<a id="itemName">14K NECKLACE / ANS0395DRL</a>
					<strong>270,000원</strong>
					<!-- <span>구매가격(할인후)</span> -->
					<a style="display: inline-block;">[옵션: 14K-로즈골드]</a>
					<button type="button" class="btn btn-secondary btn-sm">옵션변경</button>
					<a>[적립금: <span id="point"></span>원]</a>
				</div>
				<div id="itemqnt" class="col-3">
					수량:&nbsp;<input id="quantity_0" type="text" size="1" value="1">
				</div>
				<div id="itemselect" class="col-2">
					<button type="button" class="btn btn-secondary btn-sm mb-3">주문하기</button>
					<button type="button" class="btn btn-secondary btn-sm" >찜하기 </button>
				</div>
			</div>
			<hr>
		</div>
		
		<!-- 다섯번째 아이템-->
		
		<div id="cartItems" >
			
			<div class="form-check">
			  <input type="checkbox" name="cart_check" class="form-check-input" style="margin: 80px -60px; width: 15px; height: 15px;">
			</div>
			
			<div class="row">
				<div class="col-2">
					<a id="imgcontainer" class="col-4 stretched-link" href="">
						<img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="" alt="..." >
					</a>
				</div>
				<div class="col-5" id="itemdetail">
					<a id="itemName">14K NECKLACE / ANS0395DRL</a>
					<strong>270,000원</strong>
					<!-- <span>구매가격(할인후)</span> -->
					<a style="display: inline-block;">[옵션: 14K-로즈골드]</a>
					<button type="button" class="btn btn-secondary btn-sm">옵션변경</button>
					<a>[적립금: <span id="point"></span>원]</a>
				</div>
				<div id="itemqnt" class="col-3">
					수량:&nbsp;<input id="quantity_0" type="text" size="1" value="1">
				</div>
				<div id="itemselect" class="col-2">
					<button type="button" class="btn btn-secondary btn-sm mb-3">주문하기</button>
					<button type="button" class="btn btn-secondary btn-sm" >찜하기 </button>
				</div>
			</div>
			<hr>
		</div>
		
		
		<div  style="text-align: center; margin-top: 150px;">
			<button type="button" class="btn btn-secondary btn-lg mr-3">모든 상품 주문하기</button>
			<button type="button" class="btn btn-secondary btn-lg" >선택 상품 주문하기</button>
		</div>
	</div>

<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>