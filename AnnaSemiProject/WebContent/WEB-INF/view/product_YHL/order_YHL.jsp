<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //    /AnnaSemiProject
%>
<jsp:include page="/WEB-INF/view/common/header_login.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order_YHL.css" />
<style type="text/css">

</style>

<script type="text/javascript">
$(document).ready(function(){
	// === orderprice 계산해서 넣기 === //
	const price_list = document.querySelectorAll("#itemprice > span");
	const price_arr = Array.from(price_list, item => item.innerText.split(",").join(""));
	
	let sum = 0;
	for(let price of price_arr){
		sum += Number(price);
	}
	
	$("span#orderprice").html(sum.toLocaleString('en'));
	
	
	// === totalprice 계산해서 넣기 === //
	sum = 0;
	const totalprice_list = $("#itemtotalprice").children();
	const totalprice_arr = Array.from(totalprice_list, item => item.innerText.split(",").join(""));

	for(let price of totalprice_arr){
		sum += Number(price);
	}
	
	$("span#totalprice").html(sum.toLocaleString('en'));
});
</script>
	<div class="container" style="width: 90%; margin: 20% auto 10% auto;">
		<h3 class="text-dark text-center">주문내역</h3>
		
		<!-- 첫번째 아이템-->
		
		<div id="orderItems" >
			<hr>
			<div class="row">
				<div class="col-2">
					<a id="imgcontainer" class="col-4 stretched-link" href="">
						<img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="" alt="..." >
					</a>
				</div>
				<div class="col-5" id="itemdetail">
					<a id="itemName">14K NECKLACE / ANS0395DRL</a>
					<!-- <span>구매가격(할인후)</span> -->
					<a style="display: inline-block;">[옵션: 14K-로즈골드]</a>
					<a>[적립금: <span id="point"></span>원]</a>
				</div>
				<div id="itemqnt" class="col-3">
					수량:&nbsp;<input id="quantity_0" type="text" size="2" value="1">
				</div>
				<div id="itemprice" class="col-2 h4">
					<span>270,000</span>원
				</div>
			</div>
			<hr>
		</div>
		
		<!-- 두번째 아이템-->
		
		<div id="orderItems" >
			
			<div class="row">
				<div class="col-2">
					<a id="imgcontainer" class="col-4 stretched-link" href="">
						<img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="" alt="..." >
					</a>
				</div>
				<div class="col-5" id="itemdetail">
					<a id="itemName">14K NECKLACE / ANS0395DRL</a>
					<!-- <span>구매가격(할인후)</span> -->
					<a style="display: inline-block;">[옵션: 14K-로즈골드]</a>
					<a>[적립금: <span id="point"></span>원]</a>
				</div>
				<div id="itemqnt" class="col-3">
					수량:&nbsp;<input id="quantity_0" type="text" size="2" value="1">
				</div>
				<div id="itemprice" class="col-2 h4">
					<span>270,000</span>원
				</div>
			</div>
			<hr>
		</div>
		
		<!-- 세번째 아이템-->
		
		<div id="orderItems" >
			
			<div class="row">
				<div class="col-2">
					<a id="imgcontainer" class="col-4 stretched-link" href="">
						<img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="" alt="..." >
					</a>
				</div>
				<div class="col-5" id="itemdetail">
					<a id="itemName">14K NECKLACE / ANS0395DRL</a>
					<!-- <span>구매가격(할인후)</span> -->
					<a style="display: inline-block;">[옵션: 14K-로즈골드]</a>
					<a>[적립금: <span id="point"></span>원]</a>
				</div>
				<div id="itemqnt" class="col-3">
					수량:&nbsp;<input id="quantity_0" type="text" size="2" value="1">
				</div>
				<div id="itemprice" class="col-2 h4">
					<span>270,000</span>원
				</div>
			</div>
			<hr>
		</div>
		
		<div class="mt-5" id="itemtotalprice" >
			 상품금액 <span id="orderprice"></span> (+옵션 <span id="optionprice">29,000</span>) + 배송비<span id="deliveryprice">0</span> - 상품할인금액 0 = 합계 : <span id="totalprice"></span>원
		</div>
		
		
		<form name="orderinfo" style="padding-top: 200px; width: 90%; margin: 20px auto;">
		
			<h4 class="mb-3">주문 정보</h4>
			<table class="table table-bordered" >
			    <tr>
			      <th>주문하시는 분</th>
			      <td><input type="text" class="form-control " id="firstName" placeholder="이름" value="" required></td>
			    </tr>
			    
			    <tr>
			      <th>일반전화</th>
			      <td>
			      	<div class="input-group mb-3">
			      	<input style="display: inline;" type="text" class="form-control" placeholder="02">
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input style="display: inline;" type="text" class="form-control" >
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input style="display: inline;" type="text" class="form-control" >
  					</div>
				  </td>
			    </tr>
			    
			    <tr>
			      <th>휴대전화</th>
			      <td>
			      	<div class="input-group mb-3">
			      	<input style="display: inline;" type="text" class="form-control" placeholder="010">
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input style="display: inline;" type="text" class="form-control">
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input style="display: inline;" type="text" class="form-control">
  					</div>
				  </td>
			     
			    </tr>
			    <tr>
			      <th>이메일</th>
			      <td>
			      	<div class="input-group mb-3">
			      	<input style="display: inline;" type="text" class="form-control" placeholder="useremail">
  					<span style="display: inline;" class="input-group-text">@</span>
  					<input style="display: inline;" type="text" class="form-control" placeholder="google.com">
  					</div>
  				  </td>
			    </tr>
			</table>
		
		
			
			
			
		</form>
		
		
		<form name="deliveryinfo" style="padding-top: 200px; width: 90%; margin: 20px auto;">
			<div class="form-check" style="float: right; padding-right: 10px;">
			  <input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" style="width: 20px; height: 20px; ">
			  <label class="form-check-label" for="flexCheckDefault">
			    주문하시는 분 정보와 동일
			  </label>
			</div>
		
			<h4 class="mb-3">배송 정보</h4>
			<table class="table table-bordered" >
			    <tr>
			      <th>받으시는 분</th>
			      <td><input type="text" class="form-control " id="firstName" placeholder="이름" value="" required></td>
			    </tr>
			    
			    <tr>
			      <th>배송받으실 주소</th>
			      <td>
			      	<div class="input-group mb-3">
				      	<input type="text" class="form-control " id="firstName" placeholder="우편번호" value="" required>
				      	<button>주소검색</button>
			      	</div>
			      	
			      	<div class="input-group mb-3">
				      	<input type="text" class="form-control " id="firstName" placeholder="기본주소" value="" required>
				      	<input type="text" class="form-control " id="firstName" placeholder="상세주소" value="" required>
			      	</div>
			      </td>
			    </tr>
			    
			    
			    <tr>
			      <th>일반전화</th>
			      <td>
			      	<div class="input-group mb-3">
			      	<input style="display: inline;" type="text" class="form-control" placeholder="02" >
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input style="display: inline;" type="text" class="form-control" >
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input style="display: inline;" type="text" class="form-control" >
  					</div>
				  </td>
			    </tr>
			    
			    <tr>
			      <th>휴대전화</th>
			      <td>
			      	<div class="input-group mb-3">
			      	<input style="display: inline;" type="text" class="form-control" placeholder="010" >
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input style="display: inline;" type="text" class="form-control">
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input style="display: inline;" type="text" class="form-control">
  					</div>
				  </td>
			     
			    </tr>
			    <tr>
			      <th>배송메시지</th>
			      <td>
			      	<div class="input-group mb-3">
			      	<input style="display: inline;" type="text" class="form-control" placeholder="배송 메시지를 입력해주세요" >
  					</div>
  				  </td>
			    </tr>
			</table>
		
		</form>
		
		<h1>결제수단</h1>
		
			
	</div>

<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>

