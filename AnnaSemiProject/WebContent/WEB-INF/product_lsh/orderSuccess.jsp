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
		
		location.href = "<%= request.getContextPath() %>/product_lsh/orderDetail.an";
		
	}

</script>

<div id="container">
	<div style="text-align: center; padding: 20px 0; background-color: #F8F8F8; border-radius: 5px;">
		<h4 style="font-weight: bold; margin: 20px 0;">주문이 완료되었습니다.</h4>
		<ul style="list-style: none; text-align: ceter; padding: 0; font-weight: bold; font-size: 11pt;">
			<li>주문번호 : <a id="orderCode" style="text-decoration: underline;" onclick="goOrderDetail()">20220407-0001</a></li>
			<li>주문일자 : 2022-04-07 17:49</li>
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
					<c:forEach var="order" items="${requestScope.orderList}" varStatus="status">
						<tr>
							<td style="width: 120px;">
								<img src="../images/p1.png" style="width: 100px;">
							</td>
							<td>
								<ul style="list-style: none; padding: 0;">
									<li><label>상품명${order.productname}</label></li>
									<li><label>[옵션]</label></li>
									<c:forEach var="option" items="${requestScope.optionList[status.index]}">
										<c:set var="qty" value="${requestScope.qtyList[status.index]}"/>
										<li>옵션명${option} (${qty}개)</li>
									</c:forEach>
								</ul>
							</td>
							<td>
								총수량
							</td>
							<td>
								무료배송, 일반배송(3000)
							</td>
							<td>
								<label>상품가격${order.productprice}</label>	
							</td>
						</tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<td colspan="5" style="text-align: center;">
							<button type="button" class="btn btn-light" onclick='location.href="/AnnaSemiProject/index.an"'>쇼핑 계속하기</button>
							<button type="button" class="btn btn-secondary" onclick='location.href="/AnnaSemiProject/product_lsh/orderDetail.an"'>주문 확인하기</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
</div>

<jsp:include page="../view/common/footer.jsp"/>