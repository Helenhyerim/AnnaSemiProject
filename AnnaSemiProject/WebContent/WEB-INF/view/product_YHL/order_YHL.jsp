<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    String ctxPath = request.getContextPath();
    //    /AnnaSemiProject
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/view/common/header_login.jsp"></jsp:include>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/order_YHL.css" />
<style type="text/css">

</style>
<script type="text/javascript" src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script> <!-- 카카오 주소 api -->
<script type="text/javascript">
$(document).ready(function(){
	
	$("span.error").hide();
	const b_orderedname = false;
	
	// 1. 주문정보) id=orderedname 인 곳이 blur 상태일 때 이벤트처리
	$("input#orderedname").blur(() => {
		const $target = $(event.target);
		
		const orderedname = $target.val().trim();
		if(orderedname == ""){
			// blur 인 orderedname 만 활성화시킨다
			$("form#orderinfo:input").prop("disabled", true);
			$target.prop("disabled",false);
			$("input#goBackCart").prop("disabled", false);
			
			$target.next().show();
			$target.focus();
			b_orderedname = true;
		}
		else {
			$("form#orderinfo:input").prop("disabled", false);
			$target.next().hide();
		}
		
	}); // end of $("input#orderedname").blur(

	// 2. 주문정보) id=hp2 인 곳이 blur 상태일 때 이벤트처리
	$("input#hp2").blur( () => { 
		
		const $target = $(event.target); 
		
	 	const regExp = /^[1-9][0-9]{3}$/g;
		
	 	const bool = regExp.test($target.val());
	 
		if(!bool){ // 위 정규표현식에 위배시
			// blur 인 hp2 만 활성화시킨다
			$("form#orderinfo:input").prop("disabled", true);
			$target.prop("disabled",false);
			
			$target.parent().find(".error").show();
			$target.focus();
		}
		else{ // 위 정규표현식에 통과시 
			$("form#orderinfo:input").prop("disabled", false);
			$target.parent().find(".error").hide();
		}
	});// end of $("input#hp2").blur( --------------
			
	// 3. 주문정보) id=hp3 인 곳이 blur 상태일 때 이벤트처리
	$("input#hp3").blur( () => { 
		const $target = $(event.target); 
		
	 	const regExp = /^\d[0-9]{3}$/g;
		
	 	const bool = regExp.test($target.val());
	 
		if(!bool){ // 위 정규표현식에 위배시
			// blur 인 hp3 만 활성화시킨다
			$("form#orderinfo:input").prop("disabled", true);
			$target.prop("disabled",false);
			
			$target.parent().find(".error").show();
			$target.focus();
		}
		else{ // 위 정규표현식에 통과시 
			$("form#orderinfo:input").prop("disabled", false);
			$target.parent().find(".error").hide();
		}
	});// end of $("input#hp3").blur( --------------		
			
	// 4. 주문정보) id=email1 인 곳이 blur 상태일 때 이벤트처리
	$("input#email1").blur( () => {
		
		const $target = $(event.target);
		
	 	const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*$/i;
     
	 	const bool = regExp.test($target.val());
	 
		if(!bool){ 
			$("form#orderinfo:input").prop("disabled", true);
			$target.prop("disabled",false);
			
			$target.parent().find(".error").show();
			$target.focus();
		}
		else{ 
			$("form#orderinfo:inpu").prop("disabled", false);
			$target.parent().find(".error").hide();
		}
	});// end of $("input#email1").blur(-----------------------
		
	// 5. 주문정보) id=email2 인 곳이 blur 상태일 때 이벤트처리
	$("input#email2").blur( () => {
		
		const $target = $(event.target);
		
	 	const regExp = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
     
	 	const bool = regExp.test($target.val());
	 
		if(!bool){ 
			$("form#orderinfo:input").prop("disabled", true);
			$target.prop("disabled",false);
			
			$target.parent().find(".error").show();
			$target.focus();
		}
		else{ 
			$("form#orderinfo:inpu").prop("disabled", false);
			$target.parent().find(".error").hide();
		}
	});// end of $("input#email2").blur(-----------------------
			
	// 6. 배송정보) id=postcode 인 곳이 blur 상태일 때 이벤트처리
	$("input#postcode").blur(() => {
		const $target = $(event.target);
		
		const orderedname = $target.val().trim();
		if(orderedname == ""){
			// blur 인 postcode 만 활성화시킨다
			$("form#orderinfo:input").prop("disabled", true);
			$target.prop("disabled",false);
			
			$target.next().show();
			$target.focus();
			b_orderedname = true;
		}
		else {
			$("form#orderinfo:input").prop("disabled", false);
			$target.next().hide();
		}
		
	});// end of $("input#postcode").blur(()------------		
	
	
	$("img#zipcodeSearch").click(function(){
		  new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                let addr = ''; // 주소 변수
	                let extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("extraAddress").value = '';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('postcode').value = data.zonecode;
	                document.getElementById("address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("detailAddress").focus();
	            }
	        }).open();
	  });
	
	// 7. 배송정보) id=address 인 곳이 blur 상태일 때 이벤트처리
	$("input#address").blur(() => {
		const $target = $(event.target);
		
		const orderedname = $target.val().trim();
		if(orderedname == ""){
			// blur 인 address 만 활성화시킨다
			$("form#orderinfo:input").prop("disabled", true);
			$target.prop("disabled",false);
			
			$target.next().show();
			$target.focus();
			b_orderedname = true;
		}
		else {
			$("form#orderinfo:input").prop("disabled", false);
			$target.next().hide();
		}
		
	});// end of $("input#address").blur(()------------
	
	// 8. 배송정보) id=detailAddress 인 곳이 blur 상태일 때 이벤트처리
	$("input#detailAddress").blur(() => {
		const $target = $(event.target);
		
		const orderedname = $target.val().trim();
		if(orderedname == ""){
			// blur 인 postcode 만 활성화시킨다
			$("form#orderinfo:input").prop("disabled", true);
			$target.prop("disabled",false);
			
			$target.next().show();
			$target.focus();
			b_orderedname = true;
		}
		else {
			$("form#orderinfo:input").prop("disabled", false);
			$target.next().hide();
		}
		
	});// end of $("input#detailAddress").blur(()------------
			
	// 9. 주문정보) id=D_hp2 인 곳이 blur 상태일 때 이벤트처리
	$("input#D_hp2").blur( () => { 
		
		const $target = $(event.target); 
		
	 	const regExp = /^[1-9][0-9]{3}$/g;
		
	 	const bool = regExp.test($target.val());
	 
		if(!bool){ // 위 정규표현식에 위배시
			// blur 인 D_hp2 만 활성화시킨다
			$("form#orderinfo:input").prop("disabled", true);
			$target.prop("disabled",false);
			
			$target.parent().find(".error").show();
			$target.focus();
		}
		else{ // 위 정규표현식에 통과시 
			$("form#orderinfo:input").prop("disabled", false);
			$target.parent().find(".error").hide();
		}
	});// end of $("input#D_hp2").blur( --------------
			
	// 10. 주문정보) id=D_hp3 인 곳이 blur 상태일 때 이벤트처리
	$("input#D_hp3").blur( () => { 
		const $target = $(event.target); 
		
	 	const regExp = /^\d[0-9]{3}$/g;
		
	 	const bool = regExp.test($target.val());
	 
		if(!bool){ // 위 정규표현식에 위배시
			// blur 인 D_hp3 만 활성화시킨다
			$("form#orderinfo:input").prop("disabled", true);
			$target.prop("disabled",false);
			
			$target.parent().find(".error").show();
			$target.focus();
		}
		else{ // 위 정규표현식에 통과시 
			$("form#orderinfo:input").prop("disabled", false);
			$target.parent().find(".error").hide();
		}
	});// end of $("input#D_hp3").blur( --------------			
			
			
	
	
	
});// end of $(document).ready(function() --------
	
	// Function Declaration
	function goPurchase(paymentprice,totalpaypoint) {
	
		// ** 필수입력 사항에 모두 입력이 되었는지 검사한다. ** //
		let b_FlagNecessaryValue = false;
		
		$("input.necessaryValue").each(function(index, item){
			const data = $(item).val().trim();
			if(data == ""){
				alert("*표시된 필수입력사항은 모두 입력해주세요");
				b_FlagNecessaryValue = true;
				return false; // each 의 break; 기능
			}
		});
		
		if(b_FlagNecessaryValue){// 필수입력사항 중 입력안된게 있으면 그 다음으로 넘어가지 말고 종료
			return; // 종료
		}
		else {
			const userid = "${sessionScope.loginuser.userid}";
			const receivedname = $("input#receivedname").val();
			const postcode = $("input#postcode").val();
			const address = $("input#address").val();
			
			console.log(receivedname);
			console.log(postcode);
			console.log(address);
			
			const url = "<%= request.getContextPath()%>/product/myOrderPayEnd.an?userid="+userid+"&paymentprice="+paymentprice+"&totalpaypoint="+totalpaypoint
					+"&receivedname="+receivedname+"&postcode="+postcode+"&address="+address;
			
			window.open(url, "coinPurchaseEnd", 
						"left=350px, top=100px, width=1000px, height=600px");
			
		}

	}// end of function goPurchase()-------------
	
	
	// === DB 상의 tbl_order 테이블에 insert 하는  함수 === //
	function goPayDB(userid, totalpayprice, totalpaypoint, receivedname, postcode, address ) {

		const frm = document.orderinfo;
	<%--	
		frm.userid.value = userid;
		frm.totalpayprice.value = totalpayprice;
		frm.totalpaypoint.value = totalpaypoint;
		frm.receivedname.value = receivedname;
		frm.postcode.value = postcode;
		frm.address.value = address;
	--%>	
		const allCnt = $("div#orderItems").length;
	//	console.log("확인용 allCnt =>" + allCnt);    상세주문 1개당 1 카운트
		
		const pnumArr = new Array();
		const oqtyArr = new Array();
		const cartnoArr = new Array();
		const totalPriceArr = new Array();
		const totalPointArr = new Array();
		
		for(let i=0; i<allCnt; i++) {
			pnumArr.push( $("input:hidden[name=productnum]").eq(i).val() );
			oqtyArr.push( $(".orderqty").eq(i).val() );
			cartnoArr.push( $(".cartno").eq(i).val() );
			totalPriceArr.push( $(".totalPrice").eq(i).val() );
			totalPointArr.push( $(".totalPoint").eq(i).val() );
		}
		
		
		/*
		for(let i=0; i<allCnt; i++) {
			console.log("확인용 제품번호: " + pnumArr[i] + ", 주문량: " + oqtyArr[i] + ", 장바구니번호 : " + cartnoArr[i] + ", 주문금액: " + totalPriceArr[i] + ", 포인트: " + totalPointArr[i]);
		       확인용 제품번호: 2, 주문량: 2, 장바구니번호 : 35, 주문금액: 690000, 포인트: 0
			확인용 제품번호: 3, 주문량: 3, 장바구니번호 : 36, 주문금액: 1035000, 포인트: 0
			확인용 제품번호: 4, 주문량: 4, 장바구니번호 : 37, 주문금액: 1380000, 포인트: 0  
		}// end of for---------------------------
		*/
		
		
		const pnumjoin = pnumArr.join();             // "2,3,4"
		const oqtyjoin = oqtyArr.join();             // "2,3,4"
		const cartnojoin = cartnoArr.join();         // "35,36,37"
		const totalPricejoin = totalPriceArr.join(); // "690000,1035000,1380000"

		let sumtotalPrice = 0;
		for(let i=0; i<totalPriceArr.length; i++) {
			sumtotalPrice += parseInt(totalPriceArr[i]);
		}

		let sumtotalPoint = 0;
		for(let i=0; i<totalPointArr.length; i++) {
			sumtotalPoint += parseInt(totalPointArr[i]);
		}
		
		/*
		console.log("확인용 pnumjoin : " + pnumjoin);             // 확인용 pnumjoin : 3,56,59
		console.log("확인용 oqtyjoin : " + oqtyjoin);             // 확인용 oqtyjoin : 3,2,3
		console.log("확인용 cartnojoin : " + cartnojoin);         // 확인용 cartnojoin : 14,13,11
		console.log("확인용 totalPricejoin : " + totalPricejoin); // 확인용 totalPricejoin : 30000,2000000,30000
		console.log("확인용 sumtotalPrice : " + sumtotalPrice);   // 확인용 sumtotalPrice : 2060000
		console.log("확인용 sumtotalPoint : " + sumtotalPoint);   // 확인용 sumtotalPoint : 435
		
			확인용 pnumjoin : 2,4
			확인용 oqtyjoin : 2,4
			확인용 cartnojoin : 35,37
			확인용 totalPricejoin : 690000,1380000
			확인용 sumtotalPrice : 2070000
			확인용 sumtotalPoint : 0
		*/
		
		frm.pnumjoin.value = pnumjoin;
		frm.oqtyjoin.value = oqtyjoin;
		frm.cartnojoin.value = cartnojoin;
		frm.totalPricejoin.value = totalPricejoin;
		frm.sumtotalPrice.value = sumtotalPrice;
		frm.sumtotalPoint.value = sumtotalPoint;
	
			   
			   
		frm.action = "<%= request.getContextPath()%>/product_lsh/orderSuccess.an";
		frm.method = "post";
		frm.submit();
		
	}; // end of function goPayDB()---------------

	
	function sameWithOrderInfo() {
		
		const bool = $("#samewithorder").is(":checked");
		/*
		   $("#allCheckOrNone").is(":checked"); 은
		     선택자 $("#allCheckOrNone") 이 체크되어지면 true를 나타내고,
		     선택자 $("#allCheckOrNone") 이 체크가 해제되어지면 false를 나타내어주는 것이다.
		*/
		if(bool){
			
		}
		
	}// end of function sameWithOrderInfo()-------------------------

	
</script>
	<div class="container" style="width: 90%; margin: 20% auto 10% auto;">
		<h3 class="text-dark text-center">주문내역</h3>
		
		
		<c:forEach var="pvo" items="${requestScope.productList }">
			<div id="orderItems" >
				<hr>
				<div class="row" >
					<div class="col-2">
						<a id="imgcontainer" class="col-4 stretched-link" href="">
							<input type="hidden" name="productnum" value="${pvo.productnum }">
							<input type="hidden" class="cartno" value="${pvo.cvo.cartno}" /> 
							
							<img src="<%=ctxPath %>/images/necklaces/목걸이이미지1.png" class="" alt="..." >
						</a>
					</div>
					<div class="col-5" id="itemdetail">
						<a id="itemName">${pvo.productname }</a>
						<!-- <span>구매가격(할인후)</span> -->
						<a style="display: inline-block;">[옵션: 14K-로즈골드]</a>
						<a>[적립금: <span id="point">${pvo.point }</span>원]</a>
						<fmt:formatNumber value="${pvo.productprice}" pattern="###,###" />원
						<input type="hidden" class="totalPrice" value="${pvo.cvo.totalpricebyproduct}" />
			            <input type="hidden" class="totalPoint" value="${pvo.cvo.totalpointbyproduct}" />
					</div>
					<div id="itemqnt" class="col-3">
						수량:&nbsp;<input class="orderqty"  type="text" size="2" value="${pvo.cvo.orderqty }">
					</div>
					<div id="itemprice" class="col-2 h4">
						<span id="totalpricebyproduct"><fmt:formatNumber value="${pvo.cvo.totalpricebyproduct}" pattern="###,###" /></span>원
						
			               
					</div>
				</div>
				<hr>
			</div>
		</c:forEach>
		
		
		<div class="mt-5" id="itemtotalprice" >
			 상품금액 <span id="orderprice"></span> (+옵션 <span id="optionprice">29,000</span>) + 배송비<span id="deliveryprice">0</span> - 상품할인금액 0 = 합계 : <fmt:formatNumber value="${requestScope.sumPrice }" pattern="###,###" />원
		</div>
		
		
		<form name="orderinfo" style="padding-top: 200px; width: 90%; margin: 20px auto;">
		
			<h4 class="mb-3">주문 정보</h4>
			<table class="table table-bordered" >
			    <tr>
			      <th>주문하시는 분<span class="star">*</span></th>
			      <td>
			      	<input type="text" class="form-control necessaryValue" id="orderedname" name="orderedname" placeholder="이름" value="" required>
			      	<span class="error">주문하시는 분의 성명을 입력해주세요.</span>
			      </td>
			    </tr>
			    
			    <tr>
			      <th>일반전화</th>
			      <td>
			      	<div class="input-group mb-3">
			      	<input name="homenum1" style="display: inline;" type="text" class="form-control" placeholder="02">
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input name="homenum2" style="display: inline;" type="text" class="form-control" >
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input name="homenum3" style="display: inline;" type="text" class="form-control" >
  					</div>
				  </td>
			    </tr>
			    
			    <tr>
			      <th>휴대전화<span class="star">*</span></th>
			      <td>
			      	<div class="input-group mb-3">
			      	<input id="hp1" name="hp1" style="display: inline;" type="text" class="form-control necessaryValue" value="010">
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input id="hp2" name="hp2" style="display: inline;" type="text" class="form-control necessaryValue">
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input id="hp3" name="hp3" style="display: inline;" type="text" class="form-control necessaryValue">
  					<span class="error">휴대폰 번호를 입력해주세요.</span>
  					</div>
				  </td>
			     
			    </tr>
			    <tr>
			      <th>이메일<span class="star">*</span></th>
			      <td>
			      	<div class="input-group mb-3">
			      	<input id="email1" name="email1" style="display: inline;" type="text" class="form-control necessaryValue" placeholder="useremail">
  					<span style="display: inline;" class="input-group-text">@</span>
  					
  					<input id="email2" name="email2" style="display: inline;" type="text" class="form-control necessaryValue" placeholder="google.com">
  					<span class="error">이메일을 입력해주세요.</span>
  					</div>
  				  </td>
			    </tr>
			</table>
		
		
			
			<div class="form-check" style="float: right; padding-right: 10px;">
			  <input class="form-check-input" type="checkbox" onclick="sameWithOrderInfo()" id="samewithorder" style="width: 20px; height: 20px; ">
			  <label class="form-check-label" for="flexCheckDefault">
			    주문하시는 분 정보와 동일
			  </label>
			</div>
		
			<h4 class="mb-3">배송 정보</h4>
			<table class="table table-bordered" >
			    <tr>
			      <th>받으시는 분<span class="star">*</span></th>
			      <td>
			      	<input type="text" class="form-control necessaryValue" id="receivedname" name="receivedname" placeholder="이름" value="" required>
			      	<span class="error">받으시는 분의 성명을 입력해주세요.</span>
			      </td>
			    </tr>
			    
			    <tr>
			      <th>배송받으실 주소<span class="star">*</span></th>
			      <td>
			      	<div class="input-group mb-3">
				      	<input id="postcode" name="postcode" type="text" class="form-control necessaryValue" placeholder="우편번호" value="" required>
				      	<%-- 우편번호 찾기 --%>
				      	<img id="zipcodeSearch" src="../images/b_zipcode.gif" style="vertical-align: middle;" />
				      	<span class="error">우편번호 형식이 아닙니다.</span>
			      	</div>
			      	
			      	<div class="input-group mb-3">
				      	<input id="address" name="address" size="40" type="text" class="form-control necessaryValue" placeholder="기본주소" value="" required><br>
				      	<input id="detailAddress" name="detailAddress" size="40" type="text" class="form-control necessaryValue" placeholder="상세주소" value="" required>
			      		<span class="error">기본주소 및 상세주소를 입력해주세요.</span>
			      	</div>
			      </td>
			    </tr>
			    
			    
			    <tr>
			      <th>일반전화</th>
			      <td>
			      	<div class="input-group mb-3">
			      	<input name="D_homenum1" style="display: inline;" type="text" class="form-control" placeholder="02" >
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input name="D_homenum2" style="display: inline;" type="text" class="form-control" >
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input name="D_homenum3" style="display: inline;" type="text" class="form-control" >
  					</div>
				  </td>
			    </tr>
			    
			    <tr>
			      <th>휴대전화<span class="star">*</span></th>
			      <td>
			      	<div class="input-group mb-3">
			      	<input id="D_hp1" name="D_hp1" style="display: inline;" type="text" class="form-control necessaryValue" value="010" >
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input id="D_hp2" name="D_hp2" style="display: inline;" type="text" class="form-control necessaryValue">
  					<span style="display: inline;" class="input-group-text">-</span>
  					<input id="D_hp3" name="D_hp3" style="display: inline;" type="text" class="form-control necessaryValue">
  					<span class="error">휴대폰 번호를 입력해주세요.</span>
  					</div>
				  </td>
			     
			    </tr>
			    <tr>
			      <th>배송메시지</th>
			      <td>
			      	<div class="input-group mb-3">
			      	<input name="deliveryMsg" style="display: inline;" type="text" class="form-control" placeholder="배송 메시지를 입력해주세요" >
  					</div>
  				  </td>
			    </tr>
			</table>
		 	
		<%-- PG(Payment Gateway 결제)에 결제후 DB상에 주문을 insert 해주는 폼이다. --%>
		   <input type="hidden" name="pnumjoin" />
		   <input type="hidden" name="oqtyjoin" />
		   <input type="hidden" name="cartnojoin" />
		   <input type="hidden" name="totalPricejoin" />
		   <input type="hidden" name="sumtotalPrice" />
		   <input type="hidden" name="sumtotalPoint" />
 		</form> 
		
		<input type="button" id="purchase" onclick="goPurchase(${requestScope.sumPrice },0);" value="결제하기" />
		<input type="button" id="goBackCart" onclick="javascript:history.back()" value="장바구니로 되돌아가기" />
		
			
	</div>

<jsp:include page="/WEB-INF/view/common/footer.jsp"></jsp:include>


