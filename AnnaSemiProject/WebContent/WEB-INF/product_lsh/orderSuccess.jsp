<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="../view/common/header_login.jsp"/>

<style type="text/css">

	div#container {
		width: 90%;
		margin: 300px auto 0 auto;
	}
	
	table {
        border-collapse: collapse;
        width: 100%;
    }
    
    table tr:last-child td {
    	vertical-align: top;
    }
</style>

<script type="text/javascript">

	// 주문 상세보기 페이지로 이동
	function goOrderDetail() {
		
		location.href = "<%= request.getContextPath() %>/product_lsh/orderDetail.an";
		
	}

</script>

<div id="container">
	<div style="text-align: center;">
		<h5 style="font-weight: bold;">주문이 완료되었습니다!</h5>
	</div>
	
	<div class="my-5">
		<%-- 주문번호, 상세보기 링크(미정) --%>
		<div>
			<p>주문번호 : 220324-1523<span class="mx-3">&#124;</span><a onclick='goOrderDetail()'>상세보기&nbsp;&raquo;</a></p>
		</div>
		<div id="order_list">
			<table>
				<tr>
					<td rowspan="2" style="width: 10%;"><img alt="p1" src="../images/p1.png" style="width: 100%;"></td>	<%-- 이미지 --%>
					<td>14K RING / ARF0380QST</td>	<%-- 상품정보(가격, 수량) --%>
				</tr>
				<tr>
					<td>690,000원 / 2개</td>
				</tr>
			</table>
			<table>
				<tr>
					<td rowspan="2" style="width: 10%;"><img alt="p1" src="../images/p1.png" style="width: 100%;"></td>	<%-- 이미지 --%>
					<td>14K RING / ARF0380QST</td>	<%-- 상품정보(가격, 수량) --%>
				</tr>
				<tr>
					<td>345,000원 / 1개</td>
				</tr>
			</table>
			<table>
				<tr>
					<td rowspan="2" style="width: 10%;"><img alt="p1" src="../images/p1.png" style="width: 100%;"></td>	<%-- 이미지 --%>
					<td>14K RING / ARF0380QST</td>	<%-- 상품정보(가격, 수량) --%>
				</tr>
				<tr>
					<td>345,000원 / 1개</td>
				</tr>
			</table>
		</div>
	</div>
</div>

<jsp:include page="../view/common/footer.jsp"/>