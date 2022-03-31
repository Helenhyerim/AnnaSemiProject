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
		
		const isExistLoginUser = false;
		
	//	if(${empty sessionScope.loginuser}) { isExistLoginUser = true; }
		
		// 대표이미지 변경하기(hover)
		
		// 옵션 선택하면 옵션 보이기
		// 필수 옵션
		$("#reqOption").change(function() {
			
			let reqOption_value = $("select#reqOption").val();
			
			if(reqOption_value != "") {
				let productName = $("select#reqOption option:selected").text();
				
				let html = "<tr>"
						 + "	<th>" + productName + "</th>"
						 + "	<td>"
						 + "		<input type='text' min='1' max='99' value='1' readonly style='width: 30px;'/>
						 + "		<span class='plus'>+</span>
						 + "		<span class='minus'>-</span>
						 + "		<span class='delProduct'>x</span>
					     + "	</td>
				         + "</tr>";
				
				$("tr#selOptionShow").before(html);
			}
		});
		
		// 선택 옵션
		$("select#selOption").change(function() {
			
			let reqOption_value = $("select#reqOption").val();
			let selOption_value = $("select#selOption").val();
			
			if(reqOption_value == "") {
				alert("필수 옵션 선택 후 선택 가능한 옵션입니다.");
			}
			
			if(selOption_value != "") {
				let selOption = $("select#selOption option:selected").text();
				
				$("th#sel").text(selOption);
			}
			
		});
		
		// 옵션 변경하면(수정, 삭제) 변경된 값 보이기
		
		
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
				
			}
			else { // 로그인 안 한 경우 : 로그인 후 이용할 수 있습니다(alert), 로그인 페이지로 이동
				goLoginPage();
			}
		});	
			
		// 찜하기 클릭
		$("span#addWish").click(function() {
			if(isExistLoginUser) { // 로그인 한 경우 : 찜한 상품으로 등록되었습니다(alert), 현재 창에 자동 머무르기
				
			}
			else { // 로그인 안 한 경우 : 로그인 후 이용할 수 있습니다(alert), 로그인 페이지로 이동
				goLoginPage();
			}
		});
		
	}); // end of $(document).ready(function() {})
	
	// 선택 카테고리 페이지로 이동
	function goCategoryPage() {
		// 선택한 카테고리가 무엇인지 알아오기
		const $target = $(event.target);
		let category = $target.text();
		
		alert(category);
		
		// 페이지 이동하기 전 선택한 카테고리 값 넘겨주기 
		const frm = document.sendCategoryFrm;
		frm.category.value = category;
		
		frm.action = "<%= ctxPath %>/product/categoryClick.an";
		frm.method = "post";
		frm.submit();
	}
	
	// 구매 페이지로 이동
	function goOrderPage() {
		location.href="<%= ctxPath %>/product/myOrder.an";
	}
	
	// 로그인 페이지로 이동
	function goLoginPage() {
		alert("로그인 후 이용할 수 있습니다.");
	//	location.href="로그인 페이지 경로";
	}
	
	/*
	
	/*   
      location.href="javascript:history.go(-2);";  // 이전이전 페이지로 이동 
       location.href="javascript:history.go(-1);";  // 이전 페이지로 이동
       location.href="javascript:history.go(0);";   // 현재 페이지로 이동(==새로고침) 캐시에서 읽어옴.
       location.href="javascript:history.go(1);";   // 다음 페이지로 이동.
       
       location.href="javascript:history.back();";       // 이전 페이지로 이동 
       location.href="javascript:location.reload(true)"; // 현재 페이지로 이동(==새로고침) 서버에 가서 다시 읽어옴. 
       location.href="javascript:history.forward();";    // 다음 페이지로 이동.
   */
	
	
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
					<tr id=selOptionShow>
						<th id="sel"></th>
						<td id="selAdd"></td>
					</tr>
				</table>
				
				<hr style="border: solid 1px lightgray">
				
				<p>TOTAL <span data-toggle="tooltip" title="옵션 선택 후 보이기(script)">345,000원(1개)</span></p>
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
				<p>
					Material : 14K 18K Gold<br>
					Stone : X<br>
					Weight: 약3.02g [±10% 오차있음]<br>
					Production : 안나캐럿<br>
					Special Note : 주말 및 공휴일을 제외한 4~6일의 제작기간이 필요한 제품입니다.
				</p>
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