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
	    <h2 class="w3-left-align mb-5">MY ADMIN</h2>
	</div>
	
	<div class="myshopMain">
		<div class="orderHistory" style="margin:30px 0;">
			<p class="myshopTit">ADMIN HISTORY</p>
			<div class="state" >
            	<ul class="order">
				<li>
                    <strong>????????????</strong>
                    <a href="" class="count"><span id="xans_myshop_orderstate_shppied_before_count">0</span></a>
         
                </li>
                <li>
                    <strong>????????????</strong>
                    <a href="" class="count"><span id="xans_myshop_orderstate_shppied_standby_count">0</span></a>
              
                </li>
            </ul>
			<ul class="cs">
				<li>
                    <strong>??????</strong>
                    <a href="" class="count"><span id="xans_myshop_orderstate_order_cancel_count">0</span></a>
            
                </li>
                <li>
                    <strong>????????????</strong>
                    <a href="" class="count"><span id="xans_myshop_orderstate_order_exchange_count">0</span></a>
                </li>
            </ul>
			</div>
		</div>
	
	
	<div id="myshopMain">
		<p class="myshopTit">ADMIN INFO</p>
		<ul>
			<li class="shopMain" id="profile">
                <h3><a href="<%= ctxPath%>/member/memberEdit.an"><i class="far fa-user fa-xs"></i><strong>PROFILE</strong></a></h3>
                <p><a href="<%= ctxPath%>/member/memberEdit.an">???????????? ??????????????? ???????????? ???????????????.<br>???????????? ?????? ????????? ???????????? ??? ????????????.</a></p>
            </li>
			<li class="shopMain" id="member">
                <h3 class="txtTitle16B"><a href="<%= ctxPath%>/member/memberList.an"><i class="fas fa-users fa-xs"></i><strong>MEMBER</strong></a></h3>
                <p class="txtSub11"><a href="<%= ctxPath%>/member/memberList.an">?????? ????????? ????????? ???????????? ???????????????.<br>????????? ??????????????? ????????? ??? ????????????.</a></p>
           </li>
			
            
            <li class="shopMain" id="board">
                <h3><a href="<%= ctxPath%>"><i class="far fa-file-alt fa-xs"></i><strong>BOARD</strong></a></h3>
                <p><a href="<%= ctxPath%>/notice.an"><i class="far fa-edit"></i>&nbsp;???????????? ?????????</a></p>
                <p><a href="<%= ctxPath%>/event.an"><i class="far fa-edit"></i>&nbsp;????????? ?????????</a></p>
                <p><a href="<%= ctxPath%>/faq.an"><i class="far fa-edit"></i>&nbsp;FAQ ?????????</a></p>
                <p><a href="<%= ctxPath%>/qna.an"><i class="far fa-edit"></i>&nbsp;Q&A ?????????</a></p>
                <p><a href="<%= ctxPath%>"><i class="far fa-edit"></i>&nbsp;?????? ?????????</a></p>
            </li>
            <li class="shopMain" id="order">
                <h3><a href="<%= ctxPath%>"><i class="fas fa-list fa-xs"></i><strong>ORDER</strong></a></h3>
                <p><a href="<%= ctxPath%>">????????????????????? ???????????? ??? ????????????.</a></p>
            </li>
            <li class="shopMain" id="product">
                <h3><a href="<%= ctxPath%>"><i class="fas fa-box fa-xs"></i><strong>PRODUCT</strong></a></h3>
                <p><a href="<%= ctxPath%>">????????? ???????????? ???????????? ???????????????.</a></p>
            </li>
        </ul>
	</div>	
 </div>
</div>
<<<<<<< HEAD
=======
		
>>>>>>> branch 'product_branch4' of https://github.com/Helenhyerim/AnnaSemiProject.git


<jsp:include page="../common/footer.jsp" /> 
<<<<<<< HEAD

=======
>>>>>>> branch 'product_branch4' of https://github.com/Helenhyerim/AnnaSemiProject.git
