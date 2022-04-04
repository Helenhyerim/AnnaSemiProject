<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../view/common/header_login.jsp"/>

<style type="text/css">

	div#container {
		width: 90%;
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

	// 체크박스 전체 선택/해제
	$("input[type='checkbox']#checkall").click(function() {
		alert("전체선택/해제 체크박스를 클릭하셨군요!")
	});

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
					<td><input type="checkbox" name='checkall' id='checkall'></td>
					<th colspan="2" style="text-align: center; font-size: 16pt;">상세 주문 내역</th>
				</tr>
			</thead>
			
			<tbody>
				<tr>	<%-- 주문 개수만큼 반복(each) --%>
					<td><input type="checkbox" name='product' id='product0' value='상품명1'></td>
					<td style="width: 20%;"><img alt="p1" src="../images/p1.png" style="width: 100%;"></td>
					<td>
						상품명<br>
						가격/수량<br>
						선택 옵션
					</td>
				<tr>
				<tr>	<%-- 주문 개수만큼 반복(each) --%>
					<td><input type="checkbox" name='product' id='product1' value='상품명2'></td>
					<td style="width: 20%;"><img alt="p1" src="../images/p1.png" style="width: 100%;"></td>
					<td>
						상품명<br>
						가격/수량<br>
						선택 옵션
					</td>
				<tr>
				<tr>	<%-- 주문 개수만큼 반복(each) --%>
					<td><input type="checkbox" name='product' id='product2' value='상품명3'></td>
					<td style="width: 20%;"><img alt="p1" src="../images/p1.png" style="width: 100%;"></td>
					<td>
						상품명<br>
						가격/수량<br>
						선택 옵션
					</td>
				<tr>
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
		<button type="button" class="btn btn-secondary" style="width: 300px;" onclick=''>목록으로</button>
	</div>
</div>

<jsp:include page="../view/common/footer.jsp"/>