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

	label.prodInfo{
		
		display: inline-block;
		width: 65px;
		margin-left: 5px;
 		/* border: solid 1px gray; */
		
	}
	ul{
	list-style:none;
	padding:0;
	}
	
</style>

<script type="text/javascript">

	const lenHIT = 4;
	// HIT 상품 "스크롤" 버튼을 클릭할때 보여줄 상품의 개수(단위)크기
	
	let start = 1;
	
	$(document).ready(function(){
		
		$("span#totalWishListCount").hide();
		$("span#countWish").hide();
	
	    // HIT상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션에 대한 초기값 호출하기 
		// 즉, 맨처음에는 "더보기..." 버튼을 클릭하지 않더라도 클릭한 것 처럼 8개의 HIT상품을 게시해주어야 한다는 말이다.
	    displayHIT("1");
	
	    // HIT 상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션 이벤트 등록하기 
	    $("button#btnMoreHIT").click( ()=>{
	    	
	    	const $target = $(event.target);
	    	
	    	if($target.text() == "처음으로"){
	    		$("tbody#displayWishList").empty();
	    		$("span#end").empty();
	    		displayHIT("1");
	    		$target.text("더보기");
	    	}
	    	else{
		    	displayHIT($target.val());
	    	}
	    	
	    });
	});// end of $(document).ready(function(){})------------------------

	
	
	
	// display 할 HIT상품 정보를 추가 요청하기(Ajax 로 처리함)
	function displayHIT(start) { 
		                         
		$.ajax({
			url:"/AnnaSemiProject/member/myPageWishListJSON.an",
		//	type:"GET",
			data:{"start":start   // "1"  "9"  "17"  "25"  "33"
				 ,"len":lenHIT},  //  8    8    8     8     8
			dataType:"JSON",
			
			success:function(json) {
				let html = "";
	            
	            if(start == "1" && json.length == 0){
	               // 처음부터 데이터가 존재하지 않는 경우
	               // !!! 주의 !!!
	               // if (json != null)  json 은 때려 죽여도 null이 안나오기때문에 안된다
	               // if (json.length == 0) 으로 해야함!! 
	               html += "현재 상품 준비중...";
	               
	               // HIT 상품 결과를 출력하기 
	               $("div#displayHIT").html(html);
	               
	            }
	            else if(json.length > 0) {
	               // 데이터가 존재하는 경우 
	               
	               $.each(json, function(index, item){
	                  
	                  html += "<tr>"+
               	     	          "<td style = 'width: 120px;'>"+
               	     			      "<img src='/AnnaSemiProject/images/"+item.productimage1+"' class='card-img-top' style='width: 100px; height:140px;'/>"+
               	     			  "</td>"+
               	     			  "<td>"+
               	     			      "<ul style = 'width: auto;'>"+
               		     			      "<li><label class='prodInfo'>제품명</label>"+item.productname+"</li>"+
  		                                  "<li><label class='prodInfo'>가격</label><span style='color: #888;'>"+(item.productprice).toLocaleString('en')+"원</span></li>"+
  		                                  "<li><label class='prodInfo'>포인트</label><span style='color: #888;'>"+item.point+" POINT</span></li>"+
  		                                  "<li class='text-center'><a href='/AnnaSemiProject/product_lsh/productDetail.an?productnum="+item.productnum+"'></a></li>"+
               	     			      "</ul>"+
               	     			  "</td>"+
               	     			  "<td style = 'width: 120px;'>"+
               	     			      "<button class = 'btn btn-dark' onclick = 'removeWishItem("+item.productnum+",'${requestScope.userid}');'>삭제하기</button>"+
               	     		      "</td>"+
               	     		  "</tr>";
	                               
	                               
	                  
	               });// end of $.each(json, function(index, item){} -----------------------------
	               // HIT 상품 결과를 출력하기 
	               $("tbody#displayWishList").append(html);
					
					// >>> !!! 중요 더보기... 버튼의 value 속성에 값을 지정하기 !!! <<< //
					$("button#btnMoreHIT").val( Number(start) + lenHIT );
					
					
					// countWish에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
					$("span#countWish").text(Number($("span#countWish").text()) + json.length );
					
					// 더보기... 버튼을 계쏙해서 클릭하여 countHI값과 totalCount값이 일치하는 경우
					if($("span#countWish").text() == $("span#totalWishListCount").text()){
						
						$("span#end").html("더이상 찜한 상품이 없습니다.");
						$("button#btnMoreHIT").text("처음으로");
						$("span#countWish").text("0");
					}
	               
	            }
	
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});                         
		
	}// end of function displayHIT(start)-------------------------------
	// Function Declration
	function removeWishItem(productnum, userid){
		
		const result = confirm("정말 삭제하시겠습니까?");
		
		console.log(userid);
		
		if(result == false){
			return;
		}
		else{
			
			$("input#removeItemNum").val(productnum);
			
			console.log($("input#removeItemNum").val());
			console.log($("input#userid").val());
			
			const frm = document.removeWishItemNum;
			frm.action = "removeItem.an";
			frm.method = "post";
			frm.submit();
		}
		
		
	}// end of removeWishItem(prductnum)----------------------
	
</script>

	<%-- === HIT 상품을 모두 가져와서 디스플레이(마우스 스크롤 방식으로 페이징 처리한 것) === --%>
	<div class = "container">
	    <p class="h3 my-3" style = "color: #888">WISHLIST</p>
	    
	     <div class="row w-75 mt-5" style = "margin: auto; border: solid 1px gray; min-height: 700px;">
	     	<table class = "w-100 table">
	     		<tbody id = "displayWishList">
	     			
	     		</tbody>
	     	</table> 
	     </div> 
	    
	    <div>
	        <p class="text-center">
	           <span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: gray;"></span> 
	           <button type="button" class="btn btn-secondary btn-lg" id="btnMoreHIT" value="">더보기</button>
	           <span id="totalWishListCount">${requestScope.totalWishListCount}</span>
	           <span id="countWish">0</span>
	        </p>
	    </div>
	</div>
	
	<form name = "removeWishItemNum" id = "removeWishItem">
		<input type = "text" name = "userid" id = "userid"  value = "${requestScope.userid}"/>
		<input type = "text" name = "removeItemNum" id = "removeItemNum" value = ""/>
	</form>
	
<jsp:include page="../common/footer.jsp" /> 