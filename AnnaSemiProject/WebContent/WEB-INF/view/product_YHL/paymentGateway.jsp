<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.2.js"></script>

<script type="text/javascript">

$(document).ready(function() {
	//	여기 링크를 꼭 참고하세용 http://www.iamport.kr/getstarted
   var IMP = window.IMP;     // 생략가능
   IMP.init('imp48559227');  // 중요!!  아임포트에 가입시 부여받은 "가맹점 식별코드". 
	
   // 결제요청하기
   IMP.request_pay({
       pg : 'html5_inicis', // 결제방식 PG사 구분
       pay_method : 'card',	// 결제 수단
       merchant_uid : 'merchant_' + new Date().getTime(), // 가맹점에서 생성/관리하는 고유 주문번호
       name : 'Anna 결제테스트(결제|주문명)',	 // 코인충전 또는 order 테이블에 들어갈 주문명 혹은 주문 번호. (선택항목)원활한 결제정보 확인을 위해 입력 권장(PG사 마다 차이가 있지만) 16자 이내로 작성하기를 권장
       amount : 100,	  //  '${requestScope.paymentprice}' 결제 금액 number 타입. 필수항목. 
       buyer_email : '${requestScope.email}',  // 구매자 email
       buyer_name : '${requestScope.name}',	  // 구매자 이름 
       buyer_tel : '${requestScope.mobile}',    // 구매자 전화번호 (필수항목)
       buyer_addr : '${requestScope.address}',  
       buyer_postcode : '${requestScope.postcode}',
       m_redirect_url : ''  // 휴대폰 사용시 결제 완료 후 action : 컨트롤러로 보내서 자체 db에 입력시킬것!
   }, function(rsp) {
	   
	   if ( rsp.success ) { // PC 데스크탑용
			
			opener.location.href = "javascript:goPayDB('${requestScope.userid}','100', '0','${requestScope.receivedname}', '${requestScope.postcode}', '${requestScope.address}');";
				
	 
		   self.close();
	   }else {
           location.href="/product/myCart.an";
           alert("결제에 실패하였습니다.");
      }
   }); // end of IMP.request_pay()----------------------------

}); // end of $(document).ready()-----------------------------

</script>
</head>	

<body>
</body>
</html>
