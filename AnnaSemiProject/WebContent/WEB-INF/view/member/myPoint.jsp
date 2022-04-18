<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>  
<%
	String ctxPath = request.getContextPath();
    //     /MyMVC
%>   

<!-- Font Awesome 5 Icons -->
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">	

<jsp:include page="../common/header_login.jsp" />  

<!-- 직접 만든 CSS -->
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/pagination_syj.css" />
 

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
    table#memberTbl {
   	 	border: 1px solid #ddd;
   	 	font-size: 12px;
    }
    
    table#memberTbl th, td {
   		padding: 5px 0;
   		color: black;
    	font-weight: 300;
    	text-align: center;
   }
    
	tr.orderInfo:hover {
		background-color: #d5d5d5;
		cursor: pointer;
	}
	
	.pagination {
		color: black;
		background-color: #ddd;
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
			<p class="myshopTit">사용 가능 포인트&nbsp;<fmt:formatNumber value="${(sessionScope.loginuser).point}" pattern="###,###" />POINT</span></p>
			
		<table id="memberTbl" class="table table-bordered" style="width: 100%; margin-top: 20px;">
	        <colgroup>
               <col style="width:15%">
               <col style="width:15%">
               <col style="width:auto">
               <col style="width:15%">
               <col style="width:15%">


	        <thead>
	        	<tr>
	        		<th scope="col">적립날짜</th>
	        		<th scope="col">주문번호</th>
	        		<th scope="col">주문상세</th>
	        		<th scope="col">주문총액</th>
	        		<th scope="col">적립포인트</th>
	        		
	        	</tr>
	        </thead>
	        
	        <tbody>
	        	<c:if test="${empty requestScope.orderList}">
	            	<tr>
	            		<td colspan="6" style="text-align: center;">포인트 내역이 없습니다.</td>
	            	</tr>
            	</c:if>
		        <c:if test="${not empty requestScope.orderList}">
		            <c:forEach var="ordermap" items="${requestScope.orderList}">
		            	<c:if test="${ordermap.ORDERTOTALPOINT ne '0'}">
		            	<tr class="orderInfo">
		            		<td class="orderDate">${ordermap.ORDERDATE}</td>		            		
		            		<td class="orderNum">${ordermap.ORDERNUM}</td>		    
		            		<td class="orderProduct" style="cursor:pointer;" onclick="javascript:location.href='/AnnaDia/shop/prodView.up?productnum=${ordermap.FK_PRODUCTNUM}'">  <%-- === 제품정보 넣기 === --%>	
								<div style="padding-top: 10px; justify-content: center; width=100%; text-align:center;">							
									    <ul class="list-unstyled">
									       <li>제품번호 : ${ordermap.FK_PRODUCTNUM}</li> 
									       <li>제품명 : ${ordermap.PRODUCTNAME}</li>   
									       <li>정&nbsp;가 : <span style="text-decoration: line-through;"><fmt:formatNumber value="${ordermap.PRODUCTPRICE}" pattern="###,###" /></span> 원</li>   <%-- 제품개당 판매정가 --%> 
									       <li>판매가 : <span class="text-danger font-weight-bold"><fmt:formatNumber value="${ordermap.SALEPRICE}" pattern="###,###" /></span> 원</li> <%-- 제품개당 판매세일가 --%>
									       <li>포인트 : <span class="text-danger font-weight-bold"><fmt:formatNumber value="${ordermap.POINT}" pattern="###,###" /></span> POINT</li>  <%-- 제품개당 포인트 --%>
									    </ul>							
							    </div> 
							</td>
		            		<td class="orderPrice">
		            		<fmt:formatNumber value="${ordermap.ORDERTOTALPRICE}" pattern="###,###" /> 원
		            		</td>		            		
		            		<td class="orderTotalPoint">
		            		<fmt:formatNumber value="${ordermap.ORDERTOTALPOINT}" pattern="###,###" /> P
		            		</td>	
		            	</tr>
		            	</c:if>
		            </c:forEach>
	            </c:if>
	            

	        </tbody>
	    </table>    
	
	    <%-- === 페이지바 === --%>
		<nav class="my-5">
	        <div style='display:flex;'>
	    	   <ul class="pagination" style='margin:auto;'>${requestScope.pageBar}</ul>
	    	</div>
	    </nav>

	    	
		</div>
	</div>
</div>





<jsp:include page="../common/footer.jsp" /> 
