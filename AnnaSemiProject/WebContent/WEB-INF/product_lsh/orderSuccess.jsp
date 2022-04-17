<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    
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
    
    a#orderCode {
    	text-decoration: underline;
    }
    
    table#tbl_deliveryInfo tbody tr {
    	border-top: solid 1px lightgray;
    	border-bottom: solid 1px lightgray;
    }
    
    td.title {
    	background-color: #F8F8F8;
    	border-right: solid 1px lightgray;
    }
    
</style>

<script type="text/javascript">

	$(document).ready(function() {
		
		console.log("${requestScope.orderList[0].ordernum}");
	});
		
	function goOrderDetail() {
		
		const frm = document.sendOrdernumFrm;
		frm.action = "<%= request.getContextPath() %>/product_lsh/orderDetail.an";
        frm.method = "post";
        frm.submit();
        
	}

</script>

<div id="container">
	<div style="text-align: center; padding: 20px 0; background-color: #F8F8F8; border-radius: 5px;">
		<h4 style="font-weight: bold; margin: 20px 0;">주문이 완료되었습니다.</h4>
		<ul style="list-style: none; text-align: ceter; padding: 0; font-weight: bold; font-size: 11pt;">
			<li>주문번호 : <span id="orderCode" onclick="goOrderDetail('${requestScope.orderList[0].ordernum}')">${requestScope.orderList[0].ordernum}</span></li>
			<li>주문일자 : ${requestScope.orderList[0].orderdate}</li>
		</ul>
	</div>
	
	<div class="my-5">
		<div id="order_list">
			<table>
				<thead>
					<tr style="border-bottom: solid 1px lightgray;">
						<th colspan="5" style="font-weight: bold;">주문 상품 정보</th>
					</tr>
				</thead>
				
				<tbody>
					<c:forEach var="order" items="${requestScope.orderList}" varStatus="status" begin="0">
						<tr style="border-bottom: solid 1px lightgray;">
							<td style="width: 10%;">
								<img src="../images/product/${order.pvo.productimage1}" style="max-width: 100%; border-radius: 5px;">
							</td>
							<td style="width: 30%;">
								<ul style="list-style: none; padding: 0;">
									<li><label style="font-weight: bold;">${order.pvo.productname}</label></li>
									<li><label>[옵션]</label></li>
									<li><label>${requestScope.optionnameList.get(status.index)}</label></li>
								</ul>
							</td>
							<td style="width: 20%;" align=center>
								${order.odvo.orderqty}
							</td>
							<td style="width: 20%;" align=center>
								기본배송
							</td>
							<td style="width: 20%;" align=center>
								<label><fmt:formatNumber value="${order.odvo.orderprice}" pattern="#,###,###"/>&nbsp;원</label>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
		<%-- 주문 가격 정보(정가 - 할인금액 = 결제금액) --%>
		<div class="mt-5 row" style="border: solid 1px gray; border-radius: 5px; margin: 0 auto; padding: 20px 0;" align=center> 
			<div class="col-md-4"><h4><fmt:formatNumber value="${requestScope.totalPrice_origin}" pattern="#,###,###"/>&nbsp;원</h4></div>
			<div class="col-md-4"><h4>-<fmt:formatNumber value="${requestScope.totalPrice_origin - requestScope.orderList[0].ordertotalprice}" pattern="#,###,###"/>&nbsp;원</h4></div>
			<div class="col-md-4"><h4><fmt:formatNumber value="${requestScope.orderList[0].ordertotalprice}" pattern="#,###,###"/>&nbsp;원</h4></div>
		</div>	
		
		<%-- 배송지 정보 --%>
		<div class="mt-5">
			<table id="tbl_deliveryInfo">
				<thead>
					<tr>
						<th colspan="2" style="font-weight: bold;">배송지정보</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="title">받으시는분</td>
						<td>${requestScope.orderList[0].name_receiver}</td>				
					</tr>
					<tr>
						<td class="title">우편번호</td>
						<td>${requestScope.orderList[0].zipcode}</td>				
					</tr>
					<tr>
						<td class="title">주소</td>
						<td>${requestScope.orderList[0].address}</td>				
					</tr>
					<tr>
						<c:set var="mobile" value="${requestScope.orderList[0].mvo.mobile}"/>
						<td class="title">휴대전화</td>
						<td>${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}</td>				
					</tr>
				</tbody>
				<tfoot>
					<tr>
						<td class="pt-5" colspan="2" style="text-align: center;">
							<button type="button" class="btn btn-light" onclick='location.href="/AnnaSemiProject/index.an"'>쇼핑 계속하기</button>
							<button type="button" class="btn btn-secondary" onclick="goOrderDetail()">주문 확인하기</button>
						</td>
					</tr>
				</tfoot>
			</table>
		</div>
	</div>
	
	<form name="sendOrdernumFrm">
		<input type="hidden" name="onum" value="${requestScope.orderList[0].ordernum}">
	</form>
</div>

<jsp:include page="../view/common/footer.jsp"/>