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
	
	table#tbl_order > tbody > tr:first-child {
		border-top: solid 1px lightgray;
	}
	
	table#tbl_order > tbody > tr {
		border-bottom: solid 1px lightgray;
	}
	
	table#tbl_order tr td:first-child {
		width: 5%;
		text-align: center;
	}
	
	table#tbl_deliveryInfo tbody tr, table#tbl_payInfo tbody tr, table#tbl_orderInfo tbody tr {
		border-top: solid 1px lightgray;
		border-bottom: solid 1px lightgray;
	}
	
	td.title {
		background-color: #F8F8F8;
		border-right: solid 1px lightgray;
		width: 25%;
		padding-left: 10px;
	}
	
	td.content {
		padding-left: 10px;
	}
	
</style>

<script type="text/javascript">

	$(document).ready(function() {

		

	}); // end of $(document).ready(function() {})
	
	
	// 전체 주문 취소
	function allOrderCancel() {
		
		var orderCancelConfirm = confirm("주문을 취소하시겠습니까?");
		
		console.log(orderCancelConfirm);

		if(orderCancelConfirm) {
			$.ajax({
				url:"<%= request.getContextPath() %>/product_lsh/orderCancel.an",
				data:{"ordernum":"${requestScope.orderList[0].ordernum}"},
				type:"post",
				dataType:"json",
				success:function(json) {
					alert("주문이 취소되었습니다.");
					location.href="javascript:location.reload(true)";
				},
				error:function(request, status, error) {
	    			alert("code: " + request.status + "\n" + "message: " + request.responseText + "\n" + "error: " + error);
	    		}
			});
		}
	}
	
</script>

<div id="container">
	<div align=center class="mb-6">
		<h4 style="font-weight: bold;">상세 주문 내역</h4>
	</div>

	<div class="my-5" style="width: 50%;">
		<table id="tbl_orderInfo">
			<thead>
				<tr>
					<th colspan="2" style="font-weight: bold;">주문정보</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="title">주문번호</td>
					<td class="content">${requestScope.orderList[0].ordernum}</td>				
				</tr>
				<tr>
					<td class="title">주문일자</td>
					<td class="content">${requestScope.orderList[0].orderdate}</td>				
				</tr>
				<tr>
					<td class="title">주문자</td>
					<td class="content">${requestScope.orderList[0].mvo.name}</td>				
				</tr>
				<tr>
					<td class="title">주문처리상태</td>
					<td class="content">
						<c:choose><c:when test="${requestScope.orderList[0].orderstatus eq 1}">결제완료</c:when><c:otherwise>주문취소</c:otherwise></c:choose>
					</td>				
				</tr>
			</tbody>
		</table>
	</div>

	<div>
		<table id="tbl_order">
			<tbody>
				<c:forEach var="order" items="${requestScope.orderList}" varStatus="status">
					<tr>
						<td style="width: 10%;">
							<img src="../images/product/${order.pvo.productimage1}" style="max-width: 100%; border-radius: 5px;">
						</td>
						<td style="width: 30%;">
							<ul style="list-style: none; padding: 0;">
								<li><label style="font-weight: bold;">${order.pvo.productname}</label></li>
								<li><label>[옵션]</label></li>
								<li>${requestScope.optionnameList.get(status.index)}</li>
							</ul>
						</td>
						<td style="width: 20%;" align=center>
							${order.odvo.orderqty}
						</td>
						<td style="width: 20%;" align=center>
							<label><fmt:formatNumber value="${order.odvo.orderprice}" pattern="#,###,###"/>&nbsp;원</label>	
						</td>
					</tr>
				</c:forEach>
			</tbody>
			<c:if test="${requestScope.orderList[0].orderstatus eq 1}">
			<tfoot>
				<tr>
					<td colspan="4" style="text-align: right;">
						<button type="button" class="btn btn-secondary" onclick='allOrderCancel()'>전체 주문 취소</button>
					</td>
				<tr>
			</tfoot>
			</c:if>
		</table>
	</div>
	
	<div class="row my-5" style="width: 100%; margin: 10px auto;">
		<div class="col-md-6">
			<table id="tbl_deliveryInfo"> 
				<thead>
					<tr>
						<th colspan="2" style="font-weight: bold;">배송지 정보</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="title">받으시는 분</td>
						<td class="content">${requestScope.orderList[0].name_receiver}</td>
					</tr>
					<tr>
						<td class="title">우편번호</td>
						<td class="content">${requestScope.orderList[0].zipcode}</td>
					</tr>
					<tr>
						<td class="title">주소</td>
						<td class="content">${requestScope.orderList[0].address}</td>
					</tr>
					<tr>
						<c:set var="mobile" value="${requestScope.orderList[0].mvo.mobile}"/>
						<td class="title">휴대전화</td>
						<td class="content">${fn:substring(mobile, 0, 3)}-${fn:substring(mobile, 3, 7)}-${fn:substring(mobile, 7, 11)}</td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="col-md-6">
			<table id="tbl_payInfo"> 
				<thead>
					<tr>
						<th colspan="2" style="font-weight: bold;">결제 정보</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="title">금액</td>
						<td class="content"><fmt:formatNumber value="${requestScope.orderList[0].ordertotalprice}" pattern="#,###,###"/>&nbsp;원</td>
					</tr>
					<tr>
						<td class="title">적립 포인트</td>
						<td class="content"><fmt:formatNumber value="${requestScope.orderList[0].ordertotalpoint}" pattern="#,###,###"/></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div style="text-align: center; margin-top: 30px;">
		<button type="button" class="btn btn-secondary" style="width: 300px;" onclick='javascript:history.back()'>목록으로</button>
	</div>
</div>

<jsp:include page="../view/common/footer.jsp"/>