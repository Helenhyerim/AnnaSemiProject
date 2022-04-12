<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

<%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>   

<!-- Font Awesome 5 Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
	

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
    
    ul {
	    display: inline-block;
	    padding-inline-start: 0px;
	    list-style:none;
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
	    padding-left: 5px;
	    padding-right: 30px;
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
	    padding-bottom: 25px;
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
	    display: block;
	    padding-top: 0px;
	    padding-right: 0px;
	    padding-bottom: 15px;
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
	    <h2 class="w3-left-align mb-5">MY POINT</h2>
	</div>
	
	<div class="myshopMain">
		<div class="orderHistory" style="margin:30px 0;">
			<p class="myshopTit">ORDER HISTORY</p>
			<div class="state" >
            	<ul class="order">
					<li class="">
					<strong class="title">총 포인트</strong> <span class="data"><span id="xans_myshop_summary_total_mileage">0원</span>&nbsp;</span>
					</li>
					<li class="">
					<strong class="title">사용가능 포인트</strong> <span class="data"><span id="xans_myshop_summary_avail_mileage">0원</span>&nbsp;</span>
					</li>
					<li class="">
					<strong class="title">사용된 포인트</strong> <span class="data"><span id="xans_myshop_summary_used_mileage">0원</span>&nbsp;</span>
					</li>
					<li class="">
					<strong class="title">미가용 포인트</strong> <span class="data"><span id="xans_myshop_summary_unavail_mileage">0원</span>&nbsp;</span>
					</li>
					<li class="">
					<strong class="title">환불예정 포인트</strong> <span class="data"><span id="xans_myshop_summary_returned_mileage">0원</span>&nbsp;</span>
					</li>
            	</ul>
			</div>
			
			<div class="ec-base-tab">
        		<ul class="menu">
					<li class="selected"><a href="/myshop/mileage/historyList.html">적립내역보기</a></li>
		            <li><a href="/myshop/mileage/unavailList.html">미가용적립내역보기</a></li>
		            <li><a href="/myshop/mileage/couponList.html">미가용쿠폰/회원등급적립내역</a></li>
        		</ul>
			</div>
	
	
			<div class="ec-base-table typeList">
            <table border="1" summary="">
			<caption>포인트 내역</caption>
                <colgroup>
					<col style="width:15%">
					<col style="width:15%">
					<col style="width:25%">
					<col style="width:auto">
					</colgroup>
					<thead><tr>
					<th scope="col">주문날짜</th>
                        <th scope="col">포인트</th>
                        <th scope="col">관련 주문</th>
                        <th scope="col">내용</th>
                    </tr></thead>
					<tbody class="displaynone center">
					<tr class="">
					<td></td>
                        <td class="right"></td>
                        <td></td>
                        <td class="left"></td>
                    </tr>
					<tr class="">
					<td></td>
                        <td class="right"></td>
                        <td></td>
                        <td class="left"></td>
                    </tr>
					<tr class="">
					<td></td>
                        <td class="right"></td>
                        <td></td>
                        <td class="left"></td>
                    </tr>
			</tbody>
			</table>
			<p class="message ">포인트 내역이 없습니다.</p>
		</div>
	</div>
</div>





<jsp:include page="../common/footer.jsp" /> 
