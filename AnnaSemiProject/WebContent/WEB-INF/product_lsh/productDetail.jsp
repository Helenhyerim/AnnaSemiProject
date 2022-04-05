<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% String ctxPath = request.getContextPath(); %>

<!-- c:if 태그 사용해서 헤더 변경(로그인 세션 정보 얻어오기) -->
<jsp:include page="../view/common/header_login.jsp"/>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/productDetail_lsh.css" />

<script type="text/javascript">

	$(document).ready(function() {
		
		$("table#tbl_optionResult").hide();
		$("tr#selOptionResult").hide();
		
		const isExistLoginUser = false;
		
		if(${not empty sessionScope.loginuser}) { isExistLoginUser = true; }
		
		// 대표이미지 변경하기(hover)
		// $("div#img_list").bind("hover", function() {})
		
		// 옵션 선택
		// 필수 옵션
		$("select#reqOption").change(function() {
			
			const reqOption_value = $("select#reqOption").val();
			
			if(reqOption_value != "") {
				const productName = $("select#reqOption option:selected").text();
				
				let addReqOption = "";
				
			//	if(.pname의 text 중에 productName과 중복되는 것이 없거나 reqTr이 존재하지 않는 경우에) {
				
				addReqOption += '<tr class="reqTr">'
						  +  '    <th class="pname">' + productName + '</th>'
						  +  '    <td>'
						  +  '        <input type="text" min="1" max="20" value="1" readonly style="width: 50px;"/>'
						  +  '        <span id="addQty" onclick="addQty()"><i class="fal fa-plus-circle"></i></span>'
						  +  '        <span id="subQty" onclick="subQty()"><i class="fal fa-minus-circle"></i></span>'
						  +  '        <span id="delProduct" onclick="delReqOption()"><i class="fal fa-trash-alt"></i></span>'
						  +  '    </td>'
						  +  '</tr>';
						  
				$("tr#selOptionResult").before(addReqOption);
				$("table#tbl_optionResult").show();
				
			// } else { alert("이미 선택한 옵션입니다."); }
			}
		});
		
		// 선택 옵션
		$("select#selOption").change(function() {
			
			const reqOption_value = $("select#reqOption").val();
			const selOption_value = $("select#selOption").val();
			
			if(reqOption_value == "") {
				alert("필수 옵션 선택 후 선택 가능한 옵션입니다.");
				return;
			}
			
			if(selOption_value != "") {
				const selOptionName = $("select#selOption option:selected").text();
				
				let addSelOption = "";
				
				addSelOption = '<span for="delProduct" class="align-right" onclick="delSelOption()">x<i class="fal fa-trash-alt" id="delProduct"></i></span>';
				
				$("th#sel").text(selOptionName);
				$("td#selAdd").html(addSelOption);
				$("table#tbl_optionResult").show();
				$("tr#selOptionResult").show();
			}
		}); // end of $("select#selOption").change(function(){})
		
		
		// 테이블(tbl_optionResult)이 변경될 때마다 총 가격과 수량을 나타내기
		$("table#tbl_optionResult").change(function() {
			// 필수옵션은 어차피 가격이 같으니까 그냥 requestScope로 받아오기
			// 선택옵션은 value에 가격을 넣어서 가져다쓰기
			
			// c:fmt pattern #,###,###
			// max 수량이 옵션당인지 total인지 물어보기
			
			// 변경된 값 반영하기
		});
		
		
		// 구매하기 클릭
		$("button#purchase").click(function() {
			if(isExistLoginUser) { // 로그인 한 경우 : 구매 페이지로 이동
				goOrderPage();
			}
			else { // 로그인 안 한 경우 : 로그인 후 이용할 수 있습니다(alert), 로그인 페이지로 이동
				goLoginPage();
			}
		});
			
	
		// 장바구니 클릭
		$("span#addCart").click(function() {
			if(isExistLoginUser) { // 로그인 한 경우 : 장바구니에 추가했습니다(alert), 장바구니 페이지에 갈 것인지 쇼핑 계속하기로 현재 창에 머무를 것인지 선택
				// popup
				const url = "<%= ctxPath %>/product_lsh/addCart.an";
				
				window.open(url, "addWish", "left=300, top=300, width=500, height=200");
			}
			else { // 로그인 안 한 경우 : 로그인 후 이용할 수 있습니다(alert), 로그인 페이지로 이동
				goLoginPage();
			}
		});	
			
		// 찜하기 클릭
		$("span#addWish").click(function() {
			if(isExistLoginUser) { // 로그인 한 경우
				
				$.ajax({
					url:"<%= ctxPath %>/product_lsh/wishDuplicateCheck.an",
					data:{"productnum":"1", "userid":"simyj"}, <%-- 임시값 --%>
					type:"post",
					dataType:"json",
					async:false,
					success:function(json) {
						if(json.isExist) {
							alert("이미 찜한 상품입니다.");
						}
						else {
							const url = "<%= ctxPath %>/product_lsh/addWish.an?userid=${(sessionScope.loginuser).userid}&productnum=${requestScope.productnum}";
							
							window.open(url, "addWish", "left=300, top=300, width=500, height=200");
						}
					},
					error:function(reqeust, status, error) {
		    			alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
		    		}
				}); // end of $.ajax({})
			
			}
			else { // 로그인 안 한 경우
			//	goLoginPage();
			
			//	아래는 테스트용 로그인 페이지 연동 후 지워야함
			
				$.ajax({
					url:"<%= ctxPath %>/product_lsh/wishDuplicateCheck.an",
					data:{"productnum":"6", "userid":"hongkd"}, <%-- 임시값 --%>
					type:"post",
					dataType:"json",
					async:false,
					success:function(json) {
						if(json.isExist) {
							alert("이미 찜한 상품입니다.");
						}
						else {
						<%--const url = "<%= ctxPath %>/product_lsh/addWish.an?userid=${(sessionScope.loginuser).userid}&productnum=${requestScope.productnum}";--%>
							const url = "<%= ctxPath %>/product_lsh/addWish.an?userid=" + json.userid + "&productnum=" + json.productnum;
						
							window.open(url, "addWish", "left=300, top=300, width=500, height=200");
						}
					},
					error:function(reqeust, status, error) {
		    			alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
		    		}
				}); // end of $.ajax({})
			}
		});
		
	}); // end of $(document).ready(function() {})
	
	// 선택 카테고리 페이지로 이동
	function goCategoryPage() {
		// 선택한 카테고리가 무엇인지 알아오기
		const $target = $(event.target);
		
		let category = $target.text();
		
		// 페이지 이동하기 전 선택한 카테고리 값 넘겨주기(번호로 넘겨주기?)
		const frm = document.sendCategoryFrm;
		frm.category.value = category;
		
		frm.action = "<%= ctxPath %>/product/categoryClick.an";
		frm.method = "post";
		frm.submit();
	}
	
	// 구매 페이지로 이동
	function goOrderPage() {
		
		// 제품코드, 수량 넘겨주기
		
		location.href="<%= ctxPath %>/product/myOrder.an";
	}
	
	// 로그인 페이지로 이동
	function goLoginPage() {
		alert("로그인 후 이용할 수 있습니다.");
		location.href="<%= ctxPath %>/login/login.an";
		
		// 로그인 후 다시 원래 페이지로 돌아오기(goBackURL)
	}
	
   	// 상품 수량 변경 및 삭제 함수(addQty, subQty, delProduct)
   	function addQty() {	
       	const $target = $(event.target);
       	
       	let qty = Number($target.parent().siblings("input").val());
       	
       	if(qty < 20) {
       		$target.parent().siblings("input").val(qty + 1);
       	}
       	else {
       		alert("최대 구매 수량을 초과하였습니다.");
       	}
    }
       	
	function subQty() {
		const $target = $(event.target);
		
		let qty = Number($target.parent().siblings("input").val());
		
		if(qty > 1) {
			$target.parent().siblings("input").val(qty - 1);
		}
		else {
			alert("최소 구매 수량 미만입니다.");
		}
	}
	
	function delReqOption() { // target 인덱스와 table의 tr 인덱스가 같은 것을 삭제
		const $target = $(event.target);
		const table = $("table#tbl_optionResult");
		
		$target.parent().parent().parent().remove();
		
		if(table.find("tr.reqTr").length == 0) {
			table.hide();
			delSelOption();
		}
	}
	
	function delSelOption() {
		const $target = $(event.target);
		
		$target.parent().empty();
		$target.parent().siblings("th#sel").empty();
		
		$("tr#selOptionResult").hide();
	}
   	
	
</script>

<div id="contianer">
	<div id="sidebar">
		<ul>
			<li><a class='category' onclick='goCategoryPage()'>Necklaces</a></li>
			<li><a class='category' onclick='goCategoryPage()'>Earrings</a></li>
			<li><a class='category' onclick='goCategoryPage()'>Rings</a></li>
			<li><a class='category' onclick='goCategoryPage()'>Bracelets</a></li>
			<li><a class='category' onclick='goCategoryPage()'>Sale</a></li>
		</ul>
	</div>

	<div id="main_content">
		<div id="top_content" class="row">
			<div id="product_cover" class="col-md-7">
				<div id="cover"><img alt="p1" src="../images/p1.png"></div>	<!-- hover html div 집어넣기 트리거로 기본 p1 보여주기 -->
				<div id="img_list">
					<img alt="p1" src="../images/p1.png">
					<img alt="p2" src="../images/p2.png">
					<img alt="p3" src="../images/p3.png">
					<img alt="p4" src="../images/p4.png">
					<img alt="p5" src="../images/p5.png">
				</div>
			</div>
			<div id="product_option" class="col-md-5">
				<h5 class="mb-3">14K RING / ARF0380QST</h5>	<!-- 제품명 / 제품코드 db 연동 -->
				<p class="mb-0"><span>판매가 : </span>    345,000원</p>	<!-- 가격 db연동 -->
				<p class="my-0"><span>회원가 : </span>    334,650원 (10,350원 할인)</p>	<!-- 가격 db연동 후 script 처리(3% 할인가) -->
				
				<hr style="border: solid 1px lightgray">
				
				<table id="tbl_option"> <%-- table을 form으로 바꿔야할듯 --%>
					<tr>
						<th>필수 옵션</th>
						<td>
							<select id="reqOption">
								<option value="">[필수] 옵션을 선택해주세요</option>
								<option>14K 로즈골드 5호</option>
								<option>14K 로즈골드 6호</option>
								<option>14K 로즈골드 7호</option>
								<option>14K 옐로우골드 5호</option>
								<option>14K 옐로우골드 6호</option>
								<option>14K 옐로우골드 7호</option>
								<option>18K 로즈골드 5호</option>
								<option>18K 로즈골드 6호</option>
								<option>18K 로즈골드 7호</option>
								<option>18K 옐로우골드 5호</option>
								<option>18K 옐로우골드 6호</option>
								<option>18K 옐로우골드 7호</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>선택 옵션</th>						
						<td>
							<select id="selOption">
								<option value="">[선택] 옵션을 선택해주세요</option>
								<option>선물용 포장</option>
							</select>
						</td>
						<td id="card_msg"></td>
					</tr>
				</table>
				
				<table id="tbl_optionResult" class="mt-4">
					<tr id=selOptionResult>
						<th id="sel"></th>
						<td id="selAdd"></td>
					</tr>
				</table>
				
				<hr style="border: solid 1px lightgray">
				
				<p>TOTAL <span id="total" style="margin-left: 170px;">345,000원(1개)</span></p>
				<p>!할인가가 적용된 최종 결제예정금액은 주문 시 확인할 수 있습니다.</p>
				
				<hr style="border: solid 1px lightgray;">
				
				<button type="button" class="btn btn-secondary btn-block" id="purchase">구매</button>
				
				<p data-toggle="tooltip" title="아이콘 안보임">
					<span id='addCart'><i class="fal fa-shopping-cart"></i>장바구니</span>
					<span id='addWish'><i class="fal fa-heart"></i>찜</span>
				</p>
			</div>
		</div>
		<div id="bottom_content">
			<div id="productInfo">
				<h5>상품정보</h5>
				<hr style="border: solid 1px lightgray; width: 40%; margin: 0;">
				<ul>
					<li>Material : 14K 18K Gold</li>
					<li>Stone : X</li>
					<li>Weight: 약3.02g [±10% 오차있음]<br></li>
					<li>Production : 안나캐럿<br></li>
					<li>Special Note : 주말 및 공휴일을 제외한 4~6일의 제작기간이 필요한 제품입니다.</li>
				</ul>
			</div>
			<div id="productDetailImg">
				<img alt="pd1" src="../images/pd1.jpg">
				<img alt="pd2" src="../images/pd2.png">
			</div>
			
			<div id="review_board">
				<h5>리뷰</h5>
				<table class="table">
			    	<thead class="thead-light">
			      		<tr>
			        		<th>No.</th>
			        		<th>글제목</th>
			        		<th>닉네임</th>
			        		<th>조회수</th>
			      		</tr>
			    	</thead>
			    	<tbody>
			      		<tr>
			        		<td>1</td>
			        		<td>리뷰1</td>
			        		<td>닉네임1</td>
			        		<td>1</td>
			      		</tr>
			      		<tr>
			        		<td>2</td>
			        		<td>리뷰2</td>
			        		<td>닉네임2</td>
			        		<td>2</td>
			      		</tr>
			    	</tbody>
			  	</table>
			</div>
			
			<div id="QnA_board">
				<h5>Q&A</h5>
				<table class="table">
			    	<thead class="thead-light">
			      		<tr>
			        		<th>No.</th>
			        		<th>글제목</th>
			        		<th>닉네임</th>
			        		<th>조회수</th>
			      		</tr>
			    	</thead>
			    	<tbody>
			      		<tr>
			        		<td>1</td>
			        		<td>Q&A1</td>
			        		<td>닉네임1</td>
			        		<td>1</td>
			      		</tr>
			      		<tr>
			        		<td>2</td>
			        		<td>Q&A2</td>
			        		<td>닉네임2</td>
			        		<td>2</td>
			      		</tr>
			    	</tbody>
			  	</table>
			</div>
		</div>
	</div>
</div>

<%-- 선택한 카테고리 값 전송하는 form --%> 
<form name='sendCategoryFrm'>
	<input type="hidden" name="category"/>
</form>

<jsp:include page="../view/common/footer.jsp"/>