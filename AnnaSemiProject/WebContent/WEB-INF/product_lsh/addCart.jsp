<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 상품 추가</title>

<script type="text/javascript">

	function goCart() {
		
		// 팝업창 닫고 부모창 페이지 이동 및 form 데이터 전송
		window.opener.name = "parentPage";
	    document.sendCartFrm.target = "parentPage";
	    document.sendCartFrm.action = "<%= request.getContextPath() %>/product/myCart.an"; 
	    document.sendCartFrm.method = "post";
	    document.sendCartFrm.submit();
	    
	    self.close();
	}
	
	function continueShopping() {
		
		// 팝업창 닫고 부모창 새로고침
		opener.parent.location.reload();
		
		self.close();
	}

</script>

</head>

<body>
	<div style="text-align: center; margin-top: 65px;">
		<h4>해당 상품이 장바구니에 추가되었습니다.</h4>
		<button type="button" onclick="goCart()">장바구니 이동</button>
		<button type="button" onclick="continueShopping()">쇼핑 계속하기</button>
	</div>
	
	<form name="sendCartFrm">
		<input type="hidden" name="userid" value="${requestScope.userid}" />
		<input type="hidden" name="productnum" value="${requestScope.productnum}" />
		<input type="hidden" name="productname" value="${requestScope.productname}" />
		<c:forEach var="option" items="${requestScope.opList}">
			<input type="hidden" name="opList" value="${option}" />
		</c:forEach>
		<c:forEach var="qty" items="${requestScope.qtyList}">
			<input type="hidden" name="qtyList" value="${qty}" />
		</c:forEach>
		<input type="hidden" name="productprice" value="${requestScope.productprice}" />
	</form>
</body>
</html>