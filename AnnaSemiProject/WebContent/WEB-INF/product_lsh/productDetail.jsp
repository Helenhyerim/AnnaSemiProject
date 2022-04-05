<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<!-- c:if 태그 사용해서 헤더 변경(로그인 세션 정보 얻어오기) -->
<jsp:include page="../view/common/header_login.jsp"/>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/productDetail_lsh.css" />

<script type="text/javascript">

	$(document).ready(function() {
		
		const isExistLoginUser = false;
		
		if(${not empty sessionScope.loginuser}) { isExistLoginUser = true; }
		
		// 대표이미지 변경하기(hover) : 부드럽게 바뀌도록 수정하기
		$("div#img_list > img").hover(function() {
			const $target = $(event.target);
			const index = $target.index();
			var imgArr = new Array();
			
			$("input[name=imgfilename]").each(function(idx) {
				var value = $(this).val();
				
				imgArr.push(value);
			});
			
			$("div#cover").html('<img src="../images/' + imgArr[index] + '">');
		});
		
		// 옵션 선택
		// 필수 옵션
		$("select#reqOption").change(function() {

			const index = $("option:selected").index();	// 선택한 옵션의 인덱스
			
			const productName = $("option:eq("+index+")").text();
		//	const productName = $("select#reqOption option:selected").text();	
			
			const isExistOption = $("ul#ul_reqOptionResult > li:contains(" + productName + ")").length;
			
			if($("select#reqOption").val() != "") {
				if(isExistOption == 0) {
					let html = '<li style="margin: 10px 0;">'
							 + '	<label style="width: 150px;" id="pname">' + productName + '</label>'
							 + '	<input type="text" value="1" readonly style="width: 40px; text-align: center;"/>'
						 	 + '	<span onclick="addQty()">+</span>'
						 	 + '	<span onclick="subQty()">-</span>'
						 	 + '	<span onclick="delOption()">x</span>'
						 	 + '</li>';
						  
					$("ul#ul_reqOptionResult").append(html);
				}
				else {
					alert("이미 선택한 옵션입니다.");
				}
			}
		});
		
		// 선택 옵션
		$("select#selOption").change(function() {
			
			if($("ul#ul_reqOptionResult > li").length == 0) {
				alert("필수 옵션 선택 후 선택 가능한 옵션입니다.");
				return; // 다시 "[선택] 옵션을 선택해주세요"로 변경하고 싶음.
			}
			
			if($("select#selOption").val() != "") {
				if($("ul#ul_selOptionResult > li").length == 0) {
					const selOptionName = $("select#selOption option:selected").text();
				
					let html = '<li>'
						 	 + '	<label>' + selOptionName + '</label>'
						 	 + ' 	<span onclick="delOption()"><i class="fal fa-trash-alt"></i></span>'
						 	 + '</li>';
				
					$("ul#ul_selOptionResult").append(html);
				}
				else {
					alert("이미 선택한 옵션입니다.");					
				}
			}
		}); // end of $("select#selOption").change(function(){})
		
		
		// total 변경하기
		$("form#optionFrm").change(function() {
			
			alert("form 변경");
			
		});
		
		
		// 구매하기 클릭
		$("button#purchase").click(function() {
			if(isExistLoginUser) { // 로그인 한 경우 : 구매 페이지로 이동
				location.href="<%= ctxPath %>/product/myOrder.an";
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
					data:{"productnum":"${requestScope.pvo.productnum}", "userid":"yuhl"}, <%-- 임시값 --%>
					type:"post",
					dataType:"json",
					async:false,
					success:function(json) {
						if(json.isExist) {
							alert("이미 찜한 상품입니다.");
						}
						else {
							const url = "<%= ctxPath %>/product_lsh/addWish.an?userid=" + json.userid + "&productnum=" + json.productnum;
							
							window.open(url, "addWish", "left=300, top=300, width=500, height=200");
						}
					},
					error:function(reqeust, status, error) {
		    			alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
		    		}
				}); // end of $.ajax({})
			
			}
			else { // 로그인 안 한 경우
				goLoginPage();
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
	
	// 로그인 페이지로 이동
	function goLoginPage() {
		alert("로그인 후 이용할 수 있습니다.");
	
		// 로그인 후 다시 원래 페이지로 돌아올 수 있도록 GET 방식으로 현재 URL 전송(goBackURL)
		location.href="<%= ctxPath %>/login/login.an?goBackURL=${requestScope.goBackURL}";
	}
	
   	// 상품 수량 변경 및 삭제 함수(addQty, subQty, delProduct)
   	function addQty() {	
       	const $target = $(event.target);
       	
       	let qty = Number($target.siblings("input").val());
       	
       	if(qty < 20) {
       		$target.siblings("input").val(qty + 1);
       	}
       	else {
       		alert("최대 주문 수량입니다.");
       	}
    }
       	
	function subQty() {
		const $target = $(event.target);
		
		let qty = Number($target.siblings("input").val());
       	
       	if(qty > 1) {
       		$target.siblings("input").val(qty - 1);
       	}
       	else {
       		alert("최소 주문 수량입니다.");
       	}
	}
	
	function delOption() {
		const $target = $(event.target);
		
		$target.closest("li").remove();
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
				<div id="cover"><img src="../images/${requestScope.pvo.productimage1}"></div>
				<div id="img_list">
					<c:forEach var="pimg" items="${requestScope.imgList}" end="4">
						<img src="../images/${pimg.imagefilename}">
					</c:forEach>
				</div>
			</div>
			<div id="product_option" class="col-md-5">
				<form name="optionFrm">
					<h5 class="mb-3">${requestScope.pvo.productname} / 제품코드-${requestScope.pvo.productnum}</h5>
					<input type="hidden" name="productname" value="${requestScope.pvo.productname}"/>
					
					<div style="line-height: 40px;">
						판매가 : <fmt:formatNumber value="${requestScope.pvo.productprice}" pattern="###,###"/><br>
						회원가 : <fmt:formatNumber value="${requestScope.pvo.saleprice}" pattern="###,###"/>&nbsp;(<fmt:formatNumber value="${requestScope.discountPrice}" pattern="##,###"/>원 할인)
					</div>
					<input type="hidden" name="productprice" value="${requestScope.pvo.productprice}"/>
					<input type="hidden" name="saleprice" value="${requestScope.pvo.productprice}"/>
					
					<hr style="border: solid 1px lightgray">
					
					<ul id="ul_option" style="list-style: none; line-height: 50px; padding-left: 0; margin: 0; width: 100%;">
						<li>
							<label style="width: 150px;">필수 옵션</label>
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
						</li>
						<li>
							<label style="width: 150px;">선택 옵션</label>						
							<select id="selOption">
								<option value="">[선택] 옵션을 선택해주세요</option>
								<option value="3000">선물용 포장</option>
							</select>							
						</li>
					</ul>
					
					<ul id="ul_reqOptionResult" style="list-style: none; padding: 0;"></ul>
					<ul id="ul_selOptionResult" style="list-style: none; padding: 0;"></ul>
					
					<hr style="border: solid 1px lightgray">
					
					<div id="totalResult"><span>TOTAL</span></div>
					<div id="msg" class="mt-3" style="font-size: 10pt;">!할인가가 적용된 최종 결제예정금액은 주문 시 확인할 수 있습니다.</div>
					
					<hr style="border: solid 1px lightgray;">
					
					<button type="button" class="btn btn-secondary btn-block" id="btnPurchase">구매</button>
					
					<div>
						<span id='addCart'><i class="fal fa-shopping-cart"></i>장바구니</span>
						<span id='addWish'><i class="fal fa-heart"></i>찜</span>
					</div>
				</form>
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
				<c:forEach var="pdimg" items="${requestScope.imgList}" begin="4">
					<img src="../images/${pdimg.imagefilename}" style="width: 90%; margin: 0 auto;"/>
				</c:forEach>
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

<%-- <script>에서 배열로 사용할 input --%>
<c:forEach var="pimg" items="${requestScope.imgList}" end="4">	
	<input type="hidden" name="imgfilename" value="${pimg.imagefilename}"/>
</c:forEach>

<jsp:include page="../view/common/footer.jsp"/>