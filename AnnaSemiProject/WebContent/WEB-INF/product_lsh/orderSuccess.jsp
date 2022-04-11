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
    
    table tr:last-child td {
    	vertical-align: top;
    }
    
    a#orderCode {
    	text-decoration: underline;
    }
    
</style>

<script type="text/javascript">

	// 주문 상세보기 페이지로 이동
	function goOrderDetail() {
		
		location.href = "<%= request.getContextPath() %>/product_lsh/orderDetail.an?userid=eomjh";
		
	}

</script>

<div id="container">
	<div style="text-align: center; padding: 20px 0; background-color: #F8F8F8; border-radius: 5px;">
		<h4 style="font-weight: bold; margin: 20px 0;">주문이 완료되었습니다.</h4>
		<ul style="list-style: none; text-align: ceter; padding: 0; font-weight: bold; font-size: 11pt;">
			<li>주문번호 : <span id="orderCode" onclick="goOrderDetail()">${requestScope.ovo.ordernum}</span></li>
			<li>주문일자 : ${requestScope.ovo.orderdate}</li>
		</ul>
	</div>
	
	<div class="my-5">
		<div id="order_list">
			<table>
				<thead>
					<tr>
						<th colspan="5">주문 상품 정보</th>
					</tr>
				</thead>
				
				<tbody>
					<tr>
						<td style="width: 10%;">
							<img src="../images/p1.png" style="max-width: 100%; border-radius: 5px;">
						</td>
						<td style="width: 30%;">
							<ul style="list-style: none; padding: 0;">
								<li><label style="font-weight: bold;">상품1</label></li>
								<li><label>[옵션]</label></li>
								<li>옵션1 (2개)</li>
								<li>옵션2 (1개)</li>
							</ul>
						</td>
						<td style="width: 20%;">
							총수량
						</td>
						<td style="width: 20%;">
							무료배송, 일반배송(3000)
						</td>
						<td style="width: 20%;">
							<label>상품가격${order.productprice}</label>	
						</td>
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="5" style="text-align: center;">
							<button type="button" class="btn btn-light" onclick='location.href="/AnnaSemiProject/index.an"'>쇼핑 계속하기</button>
							<button type="button" class="btn btn-secondary" onclick='goOrderDetail()'>주문 확인하기</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>

<jsp:include page="../view/common/footer.jsp"/>