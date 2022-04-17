<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<% String ctxPath = request.getContextPath(); %>

<!-- c:if 태그 사용해서 헤더 변경(로그인 세션 정보 얻어오기) -->
<jsp:include page="../view/common/header_login.jsp"/>

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/productDetail_lsh.css" />

<style type="text/css">

	img.imgcss {border-radius: 5px;}

</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		// 대표이미지 변경하기(hover)
		$("div#img_list img").hover(function() {
			const $target = $(event.target);
			const index = $target.index();
			var imgArr = new Array();
			
			$("input[name=imgfilename]").each(function(idx) {
				var value = $(this).val();
				
				imgArr.push(value);
			});
			
			$("div#cover").html('<img class="imgcss" src="../images/product/' + imgArr[index] + '">');
		});
		
		// 필수 옵션 선택
		$("select#reqOption").change(function() {

			const index = $("option:selected").index();	// 선택한 옵션의 인덱스
			const opval = $("option:selected").val();	// 선택한 옵션의 value
			
			const productName = $("option:eq("+index+")").text();
		//	const productName = $("select#reqOption option:selected").text();	
			
			const isExistOption = $("ul#ul_reqOptionResult > li:contains(" + productName + ")").length;
			
			if($("select#reqOption").val() != "") {
				if(isExistOption == 0) {
					let html = '<li style="margin: 20px 0;">'
							 + '	<label style="width: 150px;" id="pname">' + productName + '</label>'
							 + '	<input class="mr-3" type="text" name="productqty" value="1" readonly style="width: 40px; text-align: center;"/>'
						 	 + '	<img onclick="addQty()" src="../images/plus.png" style="width: 20px;">'
						 	 + '	<img onclick="subQty()" src="../images/minus.png" style="width: 20px;">'
						 	 + '	<img onclick="delOption()" src="../images/cancel.png" style="width: 20px;">'	
						 	 + '	<input type="hidden" name="optionValue" value="' + opval + '"/>'
						 	 + '</li>';
						  
					$("ul#ul_reqOptionResult").append(html);
					optionResult();
				}
				else {
					alert("이미 선택한 옵션입니다.");
				}
			}
		});
		

		// 구매하기 클릭
		$("button#btnPurchase").click(function() {
			if(${not empty sessionScope.loginuser}) {
				var opList = new Array();
				var qtyList = new Array();
				
				if($("ul#ul_reqOptionResult li").length != 0) { // 필수 옵션이 선택되어 있는 경우
					
					// 선택된 옵션별 옵션명을 알아오는 반복문
					$("label#pname").each(function(){
						var pname = $(this).text();
						
						opList.push(pname);
					});
					
					// 선택된 옵션별 수량을 알아오는 반복문
					$("ul#ul_reqOptionResult li input[name=productqty]").each(function() {
						var value = $(this).val();
			
						qtyList.push(value);
					});
				}
				else {	// 필수 옵션이 선택되어 있지 않은 경우
					alert("옵션을 선택해주세요.");
					return;
				}
				
				addHiddenInput(opList, qtyList);
				
				const frm = document.sendOptionFrm;
				frm.action = "<%= ctxPath %>/product/myOrder.an";
	            frm.method = "post";
	            frm.submit();
			}
			else {
				goLoginPage();
			}
		});
			
	
		// 장바구니 클릭
		$("span#addCart").click(function() {
			if(${not empty sessionScope.loginuser}) {	
				var opList = new Array();
				var qtyList = new Array();
				
				if($("ul#ul_reqOptionResult li").length != 0) { // 필수 옵션이 선택되어 있는 경우
					
					// 선택된 옵션별 옵션번호를 알아오는 반복문
					$("input[name='optionValue']").each(function(){
						var optionValue = $(this).val();
						
						opList.push(optionValue);
					});
				
					// 선택된 옵션별 수량을 알아오는 반복문
					$("ul#ul_reqOptionResult li input[name=productqty]").each(function() {
						var value = $(this).val();
			
						qtyList.push(value);
					});
				}
				else {
					alert("옵션을 선택해주세요.");
					return;
				}
					
				$.ajax({
					url:"<%= ctxPath %>/product_lsh/cartDuplicateCheck.an",
					data:{"userid":"${sessionScope.loginuser.userid}",
						  "productnum":"${requestScope.pvo.productnum}",
						  "productname":"${requestScope.pvo.productname}"}, 
					type:"post",
					dataType:"json",
					async:false,
					success:function(json) {
						if(json.isExist) {
							alert("이미 장바구니에 추가한 상품입니다.");
						}
						else {
							addHiddenInput(opList, qtyList);
							
							var pop_title = "addCart";
							
							window.open("", pop_title, "left=300, top=300, width=500, height=200");
							
							const frm = document.sendOptionFrm;
							frm.target = pop_title;
		                    frm.action = "<%= ctxPath %>/product_lsh/addCart.an";
		                    frm.method = "post";
		                    frm.submit();
						}
					},
					error:function(request, status, error) {
		    			alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
		    		}
				}); // end of $.ajax({})
			}
			else {
				goLoginPage();
			}
		});	// end of $("span#addCart").click(function() {})
			
		
		// 찜하기 클릭
		$("span#addWish").click(function() {
			if(${not empty sessionScope.loginuser}) {	
				$.ajax({
					url:"<%= ctxPath %>/product_lsh/wishDuplicateCheck.an",
					data:{"productnum":"${requestScope.pvo.productnum}",
						  "userid":"${sessionScope.loginuser.userid}"},
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
					error:function(request, status, error) {
		    			alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
		    		}
				}); // end of $.ajax({})
			}
			else {
				goLoginPage();
			}
		}); // end of $("span#addWish").click(function() {})
		
		
		// 리뷰 테이블 아코디언
		$("tr.reviewContents").hide();
		
		$("table#tbl_review tr.reviewTitle").click(function() {
			$(this).next("tr.reviewContents").toggle();
		});
		
		
		// 리뷰 테이블 페이지 이동시 스크롤 고정
		
				
	}); // end of $(document).ready(function() {})
	
	
	// 선택 카테고리 페이지로 이동
	function goCategoryPage(categorynum) {

		location.href = "<%= ctxPath %>/product/categoryClick.an?categorynum=" + categorynum;
	}
	
	
	// 로그인 페이지로 이동
	function goLoginPage() {
		alert("로그인 후 이용할 수 있습니다.");
	
		location.href="<%= ctxPath %>/login/login.an";
	}
	
	
   	// 선택한 옵션별 수량 변경 및 삭제 함수(addQty, subQty, delProduct)
   	function addQty() {	
       	const $target = $(event.target);
       	
       	let qty = Number($target.siblings("input").val());
       	
       	if(qty < 20) {
       		$target.siblings("input[name=productqty]").val(qty + 1);
       		optionResult();
       	}
       	else {
       		alert("최대 주문 수량입니다.");
       	}
    }
       	
	function subQty() {
		const $target = $(event.target);
		
		let qty = Number($target.siblings("input").val());
       	
       	if(qty > 1) {
       		$target.siblings("input[name=productqty]").val(qty - 1);
       		optionResult();
       	}
       	else {
       		alert("최소 주문 수량입니다.");
       	}
	}
	
	function delOption() {
		const $target = $(event.target);
		
		$target.closest("li").remove();
		
		optionResult();
	}
	
	
	// ul_reqOptionResult에 변동이 생길 때마다 호출되는 함수(totalPrice, totalQty 계산)
   	function optionResult() {

		let qty = 0;
		let price = 0;
		var qtyArr = new Array();
		
		if(${not empty sessionScope.loginuser}) { price = $("input[name=saleprice]").val(); }	// 334650
		else { price = $("input[name=productprice]").val(); }	// 345000
		
		if($("ul#ul_reqOptionResult li").length != 0) { // 필수 옵션이 선택되어 있는 경우
			
			// 선택된 옵션별 수량을 알아오는 반복문
			$("ul#ul_reqOptionResult li input[name=productqty]").each(function(idx) {
				var value = $(this).val();
	
				qty = qty + Number(value);
			});
			
			price = Number(price) * Number(qty);
			
			$("span#totalResult").text(price.toLocaleString('en') + "원 (" + qty + "개)");
			$("span#totalResult").show();
		}
		else {
			$("span#totalResult").hide();
		}
	}
	
	// 구매, 장바구니 추가에서 form으로 전송할 값 넣어주기
	function addHiddenInput(opList, qtyList) {
		for(var i in opList) {
			html = '<input type="hidden" name="opList[]" value="' + opList[i] + '" />';
			
			$("div#opListInput").append(html);
		}
		
		for(var i in qtyList) {
			html = '<input type="hidden" name="qtyList[]" value="' + qtyList[i] + '" />';
			
			$("div#qtyListInput").append(html);
		}
	}
	
	// 리뷰 작성
	function writeReview() {
		// 로그인 중인 사용자가 해당 상품을 구매한 이력이 있는지 조회하기 true라면 리뷰작성페이지로 이동
		if(${not empty sessionScope.loginuser}) {
			$.ajax({
				url:"<%= ctxPath %>/product_lsh/writeReviewCheck.an",
				data:{"productnum":"${requestScope.pvo.productnum}",
					  "userid":"${sessionScope.loginuser.userid}"},
				type:"post",
				dataType:"json",
				async:false,
				success:function(json) {
					if(!json.isPurchase) {
						alert("해당 상품을 구매한 후 리뷰를 작성하실 수 있습니다.");
					}
					
					if(json.isWriteReview) {
						alert("이미 해당 상품의 리뷰를 작성하셨습니다.");
					}
					
					if(json.isPurchase && !json.isWriteReview) {
						var writeReviewConfirm = confirm("리뷰를 작성하시겠습니까?");
						
						// form으로 데이터 전송(userid, productnum)
						if(writeReviewConfirm) {
							const frm = document.sendWriteReviewFrm;
							frm.action = "<%= ctxPath %>/product_lsh/writeReview.an";
		                    frm.method = "post";
		                    frm.submit();
						}
					}
					
				},
				error:function(request, status, error) {
	    			alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
	    		}
			}); // end of $.ajax({})
		}
		else {
			goLoginPage();
		}
	}
	
</script>

<div id="contianer">
	<div id="sidebar">
		<ul>
			<c:forEach var='category' items="${requestScope.categoryList}">
				<li><a class='category' onclick="goCategoryPage(${category.categorynum})">${category.categoryname}</a></li>
			</c:forEach>
		</ul>
	</div>

	<div id="main_content">
		<div id="top_content" class="row">
			<div id="product_cover" class="col-md-7">
				<div id="cover" style="width: 90%; margin: 0px auto;" align=center>
					<img class="imgcss" src="../images/product/${requestScope.pvo.productimage1}">
				</div>
				<div id="img_list" align=center>
					<c:forEach var="pimg" items="${requestScope.imgList}" end="4">
						<img class="imgcss" src="../images/product/${pimg.imagefilename}">
					</c:forEach>
				</div>
			</div>
			<div id="product_option" class="col-md-5">
				<h5 class="mb-4" style="font-weight: bold;">${requestScope.pvo.productname}</h5>
				
				<div style="line-height: 45px;">
					판매가 : <fmt:formatNumber value="${requestScope.pvo.productprice}" pattern="###,###"/>원<br>
					회원가 : <fmt:formatNumber value="${requestScope.pvo.saleprice}" pattern="###,###"/>원&nbsp;(<fmt:formatNumber value="${requestScope.discountPrice}" pattern="##,###"/>원 할인)
				</div>
				<input type="hidden" name="productprice" value="${requestScope.pvo.productprice}"/>
				<input type="hidden" name="saleprice" value="${requestScope.pvo.saleprice}"/>
				
				<hr class="my-4" style="border: solid 1px lightgray">
				
				<ul id="ul_option" style="list-style: none; line-height: 50px; padding-left: 0; width: 100%;">
					<li>
						<label style="width: 150px;">필수 옵션</label>
						<select id="reqOption" style="width: 300px;">
							<option value="">[필수] 옵션을 선택해주세요</option>
							<c:forEach var="option" items="${requestScope.optionList}">
								<option value="${option.optionnum}">${option.optionname}</option>							
							</c:forEach>
						</select>
					</li>
				</ul>
				
				<ul class="mt-5" id="ul_reqOptionResult" style="list-style: none; padding: 0;"></ul>
				
				<hr style="border: solid 1px lightgray">
				
				<div>TOTAL<span id="totalResult" style="margin-left: 50px;"></span></div>
				<div id="hiddenTotalResult"></div>
				<div id="msg" class="mt-3" style="font-size: 10pt;">!할인가가 적용된 최종 결제예정금액은 주문 시 확인할 수 있습니다.</div>
				
				<hr style="border: solid 1px lightgray;">
				
				<button type="button" class="btn btn-secondary btn-block" id="btnPurchase">구매</button>
				
				<div class="row" style="margin-top: 20px; text-align: center;">
					<div class="col-md-6"><span id='addCart' style="font-size: 10pt; font-weight: bold;"><img src="../images/cart.png">&nbsp;장바구니</span></div>
					<div class="col-md-6"><span id='addWish' style="font-size: 10pt; font-weight: bold;"><img src="../images/heart.png" style="width: 30px;">&nbsp;찜</span></div>
				</div>
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
			<div id="productDetailImg" align=center>
				<c:forEach var="pdimg" items="${requestScope.imgList}" begin="4">
					<img src="../images/product/${pdimg.imagefilename}" class="mb-5" style="width: 80%; margin: 0 auto;"/>
				</c:forEach>
			</div>
			
			<div id="review_board">
				<table class="table" id="tbl_review" style="width: 80%; margin: 0 auto;" >
					<caption style="caption-side: initial; font-weight: bold; font-size: 14pt;">리뷰</caption>
					<thead class="thead-light">
			      		<tr>
			        		<th>No.</th>
			        		<th>글제목</th>
			        		<th>닉네임</th>
			      		</tr>
			    	</thead>
			    	<tbody>
			    		<c:if test="${not empty requestScope.reviewList}">
			    			<c:set var="reviewNo" value="${requestScope.totalReviewCnt}"/>
				      		<c:forEach var="review" items="${requestScope.reviewList}" varStatus="status">
				      			<tr class="reviewTitle">
				      				<td>${reviewNo - status.index}</td> <%-- ${review.review_no} --%>
				      				<td>${review.reviewtitle}</td>
				      				<td>${review.userid}</td>
				      			</tr>
				      			<tr class="reviewContents">
				      				<td colspan="3" style="font-size: 12pt; height: 100px;">${review.reviewcontents}</td>
				      			</tr>
				      		</c:forEach>
			      		</c:if>
			      		<c:if test="${empty requestScope.reviewList}">
			      			<tr>
			      				<td colspan="3" align=center>게시물이 없습니다.</td>
			      			</tr>
			      		</c:if>
			    	</tbody>
			    	<tfoot>
			    		<tr>
			    			<td colspan="3" align=right>
			    			<c:if test="${not empty sessionScope.loginuser}">
		    					<button type="button" class="btn btn-secondary" onclick="writeReview()">리뷰 작성</button>
			    			</c:if>
			    			</td>
			    		</tr>
			    	</tfoot>
			  	</table>
			</div>
			
			<c:if test="${not empty requestScope.reviewList && requestScope.totalPage ne 1}">
				<nav class="my-5">
			        <div style="display: flex; width: 100%;" align=center>
			       	    <ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
			    	</div>
			    </nav>
		    </c:if>
		</div>
	</div>
</div>

<%-- <script>에서 배열로 사용할 input --%>
<c:forEach var="pimg" items="${requestScope.imgList}" end="4">	
	<input type="hidden" name="imgfilename" value="${pimg.imagefilename}"/>
</c:forEach>

<%-- 선택한 옵션 전송하는 form --%>
<form name='sendOptionFrm'>
	<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}"/>
	<input type="hidden" name="pnum" value="${requestScope.pvo.productnum}"/>
	<input type="hidden" name="pname" value="${requestScope.pvo.productname}"/>
	<div id="opListInput"></div>
	<div id="qtyListInput"></div>
	<input type="hidden" name="pprice" value="${requestScope.pvo.saleprice}"/>
</form>

<%-- 리뷰 작성을 위한 데이터 전송 form --%>
<form name="sendWriteReviewFrm">
	<input type="hidden" name="userid" value="${sessionScope.loginuser.userid}"/>
	<input type="hidden" name="productnum" value="${requestScope.pvo.productnum}" />
</form>

<jsp:include page="../view/common/footer.jsp"/>