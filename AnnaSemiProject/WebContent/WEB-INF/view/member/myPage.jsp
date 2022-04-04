<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>   

<jsp:include page="../common/header_login.jsp" />   

<style type="text/css">
	.titleArea h2 {
	    font-size: 18px;
	    color: #444;
	    font-weight: 600;
	    letter-spacing: 1px;
	    font-family: 'Roboto','Noto Sans KR',sans-serif;
	}

	#contents {
	    width: 100%;
	    float: none;
	    padding: 200px 20px 0;
	    box-sizing: border-box;  
	} 
	.myshopMain {
    padding: 50px;
    border: 1px solid #ddd;
    }
    
    p.myshopTit {
    font-size: 12px;
    border-bottom: 1px solid #ddd;
    padding-bottom: 8px;
    margin-bottom: 15px;
    font-weight: 600;
    }
    
    li strong {
    display: inline-block;
    margin: 0;
    font-size: 12px;
    }
    
    .cs li, .order li{
    position: relative;
    float: none;
    display: inline-block;
    width: auto;
    margin: 0;
    padding-left: 30px;
    letter-spacing: 0;
    word-spacing: 0;
	}
    
    #myshopMain .shopMain {
    	float: left;
	    width: 33.3%;
	    height: auto;
	    min-height: 120px;
	    border: 0;
	    margin: 0;
	    text-align: left;
	    padding: 0;
    }
    
   #myshopMain .shopMain h3 strong {
    display: inline-block;
    font-size: 12px;
    color: #333;
    font-weight: 600;
    margin-left: 8px;
    vertical-align: middle;
    }
    #myshopMain .shopMain h3 a {
	    width: 65%;
	    padding-bottom: 20px;
	}
	
	#myshopMain .shopMain h3 a {
    display: block;
    padding: 0 0 25px;
}
	
	#myshopMain .shopMain h3 a {
	    display: block;
	    padding: 0 0 25px;
	    padding-top: 0px;
	    padding-right: 0px;
	    padding-bottom: 25px;
	    padding-left: 0px;
	}
	
	#myshopMain .shopMain p a {
    	font-size: 12px;
    }
</style>


<script type="text/javascript">

	$(document).ready(function(){
		
	});

</script>

<div class="contents mx-5" style="margin-top:230px;">
	<div class="titleArea">
	    <h2 class="w3-left-align mb-5">MY SHOPPING</h2>
	</div>
	<div class="myshopMain">
		<div class="orderHistory" style="margin:20px 0";>
			<p class="myshopTit">ORDER HISTORY</p>
			<div class="state">
            <ul class="order">
				<li>
                    <strong>입금전</strong>
                    <a href="" class="count"><span id="xans_myshop_orderstate_shppied_before_count">0</span></a>
                </li>
                <li>
                    <strong>배송준비중</strong>
                    <a href="" class="count"><span id="xans_myshop_orderstate_shppied_standby_count">0</span></a>
                </li>
                <li>
                    <strong>배송중</strong>
                    <a href="" class="count"><span id="xans_myshop_orderstate_shppied_begin_count">0</span></a>
                </li>
                <li>
                    <strong>배송완료</strong>
                    <a href="" class="count"><span id="xans_myshop_orderstate_shppied_complate_count">0</span></a>
                </li>
            </ul>
			<ul class="cs">
				<li>
                    <strong>취소</strong>
                    <a href="" class="count"><span id="xans_myshop_orderstate_order_cancel_count">0</span></a>
                </li>
                <li>
                    <strong>교환</strong>
                    <a href="" class="count"><span id="xans_myshop_orderstate_order_exchange_count">0</span></a>
                </li>
                <li>
                    <strong>반품</strong>
                    <a href="" class="count"><span id="xans_myshop_orderstate_order_return_count">0</span></a>
                </li>
            </ul>
		</div>
		
	<div id="myshopMain">
		<p class="myshopTit">MY INFO</p>
		<ul>
			<li class="shopMain" id="order">
                <h3><a href=""><i class="xi-list"></i><strong>ORDER</strong></a></h3>
                <p><a href="">고객님께서 주문하신 상품의 주문내역을 확인하실 수 있습니다.<br>비회원은 주문하신 주문번호와 비밀번호로 조회할 수 있습니다.</a></p>
            </li>
            <li class="shopMain" id="profile">
                <h3><a href=""><i class="xi-user-o"></i><strong>PROFILE</strong></a></h3>
                <p><a href="">회원이신 고객님의 개인정보를 관리하는 공간입니다.<br>비밀번호 등의 정보를 수정하실 수 있습니다.</a></p>
            </li>
            <li class="shopMain" id="board">
                <h3><a href=""><i class="xi-document"></i><strong>BOARD</strong></a></h3>
                <p><a href="">고객님께서 작성하신 게시물을 관리하는 공간입니다.</a></p>
                <p><a href="">고객님께서 작성하신 게시물을 관리하는 공간입니다.</a></p>
            </li>
            <li class="shopMain" id="wishlist">
                <h3><a href=""><i class="xi-heart-o"></i><strong>WISHLIST</strong></a></h3>
                <p><a href="">관심상품으로 등록하신 상품의 목록을 보여드립니다.</a></p>
            </li>
            <li class="shopMain" id="mileage">
                <h3 class="txtTitle16B"><a href=""><i class="xi-won"></i><strong>MILEAGE</strong></a></h3>
                <p class="txtSub11"><a href="">고객님께서 보유하고 계신 적립금 내역을 보여드립니다.<br>포인트은 상품 구매 시 사용하실 수 있습니다.</a></p>
           </li>
             

          
        </ul>
	</div>	
 </div>
</div>
		
</div>



<jsp:include page="../common/footer.jsp" /> 
