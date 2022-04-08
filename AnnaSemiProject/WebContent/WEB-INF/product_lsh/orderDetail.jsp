<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../view/common/header_login.jsp"/>

<style type="text/css">

	div#container {
		width: 70%;
		margin: 220px auto 100px auto;
	}
	
	table {
		border-collapse: collapse;
		width: 100%;
	}
	
	table > tbody > tr:first-child {
		border-top: solid 1px lightgray;
	}
	
	table > tbody > tr {
		border-bottom: solid 1px lightgray;
	}
	
	table tr td:first-child {
		width: 5%;
		text-align: center;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {

		// 체크박스 전체 선택/해제
		$("input#checkAll").click(function() {
			if($("input#checkAll").prop("checked")) {
				$("input.product").prop("checked", true);
			}
			else {
				$("input.product").prop("checked", false);
			}
		});
		
		$("input.product").click(function() {
			if($("input[name='product']:checked").length == 5) {
				$("input#checkAll").prop("checked", true);
			}
			else {
				$("input#checkAll").prop("checked", false);
			}
		});

	}); // end of $(document).ready(function() {})
	
	
	// 선택 주문 취소
	function selOrderCancel() {
		alert("선택 주문 취소를 클릭하셨군요");
	}
	
	
	// 전체 주문 취소
	function allOrderCancel() {
		alert("전체 주문 취소를 클릭하셨군요");
	}
	
</script>

<div id="container">
	<div>
		<table>
			<thead>
				<tr>
					<th style="text-align: center;"><input type="checkbox" id="checkAll"></th>
					<th colspan="2" style="text-align: center; font-size: 16pt;">상세 주문 내역</th>
				</tr>
			</thead>
			
			<tbody>
			<%--	<c:forEach var="order" items="orderList">	--%>
					<tr>	<%-- 주문 개수만큼 반복(each) --%>
						<td><input type="checkbox" class="product" name="product"></td>
						<td style="width: 20%;"><img src="../images/p1.png" style="width: 80%;"></td>
						<td>
							<ul style="list-style: none; padding: 0; line-height: 35px;">
								<li><label>상품명</label></li>
								<li><label>가격/수량</label></li>
								<li><label>옵션명</label></li>
							</ul>
						</td>
					</tr>
			<%--	</c:forEach>	--%>
					<tr>	<%-- 주문 개수만큼 반복(each) --%>
						<td><input type="checkbox" class="product" name="product"></td>
						<td style="width: 20%;"><img alt="p1" src="../images/p2.png" style="width: 80%;"></td>
						<td>
							<ul>
								<li><label>상품명</label></li>
								<li><label>가격/수량</label></li>
								<li><label>옵션명</label></li>
							</ul>
						</td>
					</tr>
					<tr>	<%-- 주문 개수만큼 반복(each) --%>
						<td><input type="checkbox" class="product" name="product"></td>
						<td style="width: 20%;"><img alt="p1" src="../images/p3.png" style="width: 80%;"></td>
						<td>
							<ul>
								<li><label>상품명</label></li>
								<li><label>가격/수량</label></li>
								<li><label>옵션명</label></li>
							</ul>
						</td>
					</tr>
					<tr>	<%-- 주문 개수만큼 반복(each) --%>
						<td><input type="checkbox" class="product" name="product"></td>
						<td style="width: 20%;"><img alt="p1" src="../images/p4.png" style="width: 80%;"></td>
						<td>
							<ul>
								<li><label>상품명</label></li>
								<li><label>가격/수량</label></li>
								<li><label>옵션명</label></li>
							</ul>
						</td>
					</tr>
					<tr>	<%-- 주문 개수만큼 반복(each) --%>
						<td><input type="checkbox" class="product" name="product"></td>
						<td style="width: 20%;"><img alt="p1" src="../images/p5.png" style="width: 80%;"></td>
						<td>
							<ul>
								<li><label>상품명</label></li>
								<li><label>가격/수량</label></li>
								<li><label>옵션명</label></li>
							</ul>
						</td>
					</tr>
			</tbody>
			<tfoot style="text-align: right;">
				<tr>
					<td></td>
					<td></td>
					<td>
						<button type="button" class="btn btn-light" onclick='selOrderCancel()'>선택 주문 취소</button>
						<button type="button" class="btn btn-secondary" onclick='allOrderCancel()'>전체 주문 취소</button>
					</td>
				<tr>
			</tfoot>
		</table>
	</div>
	
	<div style="width: 60%; margin: 10px auto;">
		<div id="orderInfo" style="display: inline-block;">
			주문정보<br>
			주문자    홍길동<br>
			전화번호    010-1234-5678<br>
			배송지    서울특별시 마포구 서교동
		</div>
		<div id="payInfo" style="display: inline-block;">
			결제정보<br>
			결제방법    신용카드<br>
			상품금액    금액<br>
			배송비    무료<br>
			총결제금액    금액
		</div>
	</div>
	
	<div style="text-align: center; margin-top: 30px;">
		<button type="button" class="btn btn-secondary" style="width: 300px;" onclick='javascript:history.back()'>목록으로</button>
	</div>
</div>

<jsp:include page="../view/common/footer.jsp"/>