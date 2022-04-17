<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<% 
	String ctxPath = request.getContextPath();
%>
<link rel="stylesheet" type="text/css" href="<%= ctxPath%>/css/index.css" />
<jsp:include page="header_login.jsp"/>

<style>

</style>

<script type="text/javascript">

	$(document).ready(function(){
		
		$("span#totalBESTCount").hide();
		$("span#countBEST").hide();
	
	// BEST상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션에 대한 초기값 호출하기 
      // 즉, 맨처음에는 "더보기..." 버튼을 클릭하지 않더라도 클릭한 것 처럼 8개의 BEST상품을 게시해주어야 한다는 말이다.
      // 1부터 8개, 9부터 8개..
      displayBEST("1");
	
		// BEST 상품 게시물을 더보기 위하여 "더보기..." 버튼 클릭액션 이벤트 등록하기
		$("button#btnMoreBEST").click(function(){
			
			const $target = $(event.target);
			
			if($target.text() == "처음으로"){
				$("div#displayBEST").empty();
				$("span#end").empty();
				displayBEST("1");
				$target.text("BEST 상품 더보기");
			}
			else {
				displayBEST($target.val());
			//	displayBEST("9");
			//	displayBEST("17");
			//	displayBEST("25");
			//	displayBEST("33");
			}
		});
		
	});// end of $(document).ready(function(){
		
	// Function Declaration
	const lenBEST = 6; 
	// BEST 상품 "더보기..."  버튼을 클릭할 때 더 보여줄 상품의 개수(단위)크기
	
	// display 할 BEST 상품 정보를 추가 요청하기(Ajax 로 처리함)
	function displayBEST(start) { // start 가 1		이라면 1~8 까지 상품 8개를 보여준다.
								 // start 가 9		이라면 9~16 까지 상품 8개를 보여준다.
								 // start 가 17		이라면 17~24 까지 상품 8개를 보여준다.
								 // start 가 25		이라면 25~32 까지 상품 8개를 보여준다.
								 // start 가 33		이라면 33~36 까지 상품 8개를 보여준다.(끝)
	
		$.ajax({
			url:"/AnnaSemiProject/product/showIndexProductJSON.an",
		//	type:"GET",
			data:{"snum":2,
				  "start":start,	// "1"	"9"  "17"  "25"  "33"
				  "len":lenBEST},	//  8	 8	  8		8	  8
			dataType:"JSON",
			success:function(json){
			 	console.log(json);
			 	console.log(typeof json); // object
			 		
				const str_json = JSON.stringify(json); // JSON 객체를 string 타입으로 변경해주는것
				console.log(typeof str_json); //string
				console.log(str_json);
				
				const obj_json = JSON.parse(str_json); // JSON 모양으로 되어진 string 을 실제 JSON 객체로 변경해주는것
				console.log(typeof obj_json); // object
				console.log(obj_json);
				
			/*
				json ==> [
							{"pnum":36,"code":"100000","discountPercent":17,"pname":"노트북30","pcompany":"삼성전자","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"59.jpg","pqty":100,"pimage2":"60.jpg","pcontent":"30번 노트북","price":1200000,"sname":"BEST"}
							,{"pnum":35,"code":"100000","discountPercent":17,"pname":"노트북29","pcompany":"레노버","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"57.jpg","pqty":100,"pimage2":"58.jpg","pcontent":"29번 노트북","price":1200000,"sname":"BEST"}
							,{"pnum":34,"code":"100000","discountPercent":17,"pname":"노트북28","pcompany":"아수스","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"55.jpg","pqty":100,"pimage2":"56.jpg","pcontent":"28번 노트북","price":1200000,"sname":"BEST"}
							,{"pnum":33,"code":"100000","discountPercent":17,"pname":"노트북27","pcompany":"애플","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"53.jpg","pqty":100,"pimage2":"54.jpg","pcontent":"27번 노트북","price":1200000,"sname":"BEST"}
							,{"pnum":32,"code":"100000","discountPercent":17,"pname":"노트북26","pcompany":"MSI","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"51.jpg","pqty":100,"pimage2":"52.jpg","pcontent":"26번 노트북","price":1200000,"sname":"BEST"}
							,{"pnum":31,"code":"100000","discountPercent":17,"pname":"노트북25","pcompany":"삼성전자","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"49.jpg","pqty":100,"pimage2":"50.jpg","pcontent":"25번 노트북","price":1200000,"sname":"BEST"}
							,{"pnum":30,"code":"100000","discountPercent":17,"pname":"노트북24","pcompany":"한성컴퓨터","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"47.jpg","pqty":100,"pimage2":"48.jpg","pcontent":"24번 노트북","price":1200000,"sname":"BEST"}
							,{"pnum":29,"code":"100000","discountPercent":17,"pname":"노트북23","pcompany":"DELL","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"45.jpg","pqty":100,"pimage2":"46.jpg","pcontent":"23번 노트북","price":1200000,"sname":"BEST"}
						]
				또는
				json => []
			
			*/
				let html ="";
				
				if(start == "1" && json.length == 0){
					// 처음부터 데이터가 존재하지 않는 경우
					// !!! 주의 !!!
					// if(json == null) 이 아니다!
					// if(json.length == 0) 로 해야한다
					
					html += "현재 상품 준비중...";
					
					// BEST 상품 결과를 출력하기
					$("div#displayBEST").html(html);
				}
				else if(json.length > 0){
					// 데이터가 존재하는 경우
					
					$.each(json, function(index, item){
							
						html +=  "<div class='col-md-6 col-lg-3'>"+
                        "<div class='card mb-3'>"+
                            "<img src='AnnaSemiProject/images/"+item.productimage1+"' class='card-img-top' style='width: 100%'/>"+
                            "<div class='card-body' style='padding: 0; font-size: 11pt;'>"+
                              "<ul class='list-unstyled mt-3 pl-3'>"+
                                 "<li><label class='prodInfo'>제품명</label>"+item.productname+"</li>"+
                                   "<li><label class='prodInfo'>판매가</label><span style=\"color: red; font-weight: bold;\">"+(item.productprice).toLocaleString('en')+" 원</span></li>"+
                                   "<li><label class='prodInfo'>포인트</label><span style=\"color: orange;\">"+item.point+" POINT</span></li>"+ 
                                   "<li class='text-center'><a href='AnnaSemiProject/product_lsh/productDetail.an?pnum="+item.productnum+"' class='stretched-link btn btn-outline-dark btn-sm' role='button'>자세히보기</a></li>"+ 
                                   <%-- 카드 내부의 링크에 .stretched-link 클래스를 추가하면 전체 카드를 클릭할 수 있고 호버링할 수 있습니다(카드가 링크 역할을 함). --%>         
                              "</ul>"+
                            "</div>"+
                         "</div>"+ 
                      "</div>";
						
					});// end of $.each(json, function(index, item){--------------------
					
					// BEST 상품 결과를 출력하기
					$("div#displayBEST").append(html);
					
					// >>> !!! 중요 더보기... 버튼의 value 속성에 값을 지정하기 !!! <<< //
					$("button#btnMoreBEST").val( Number(start) + lenBEST);
					// 더보기... 버튼의 vlaue 값이 9로 변경된다.
					// 더보기... 버튼의 vlaue 값이 17로 변경된다.
					// 더보기... 버튼의 vlaue 값이 25로 변경된다.
					// 더보기... 버튼의 vlaue 값이 33로 변경된다.
					// 더보기... 버튼의 vlaue 값이 41로 변경된다.(존재하지 않는것이다)
					
					// countBEST 에 지금까지 출력된 상품의 개수를 누적해서 기록해둔다.
					$("span#countBEST").text( Number($("span#countBEST").text()) + json.length );
					
					// 더보기... 버튼을 계속 클릭하여 countBEST 값과 totalBESTCount 값이 일치하는 경우
					if($("span#countBEST").text() == $("span#totalBESTCount").text()){
						$("span#end").html("더이상 조회할 제품이 없습니다");
						$("button#btnMoreBEST").text("처음으로");
						$("span#countBEST").text("0");
					}
				}
				
			},
			error: function(request, status, error){
	            alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
	        }
			
		});
		
	}// end of function displayBEST(start) ------

</script>



	
	<div class="container">
	
		<div style="width: 90%; margin: 0 auto 250px auto;">
			<div id="carouselExampleIndicators" class="carousel slide carousel-fade" data-ride="carousel">
			  <ol class="carousel-indicators">
			    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
			    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
			    <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
			  </ol>
			  
			  <div class="carousel-inner">
			   
			    <div class="carousel-item active">
			      <img src="<%= ctxPath %>/images/index/carousel_img1.png" class="d-block w-100 carousel_img" alt="..."> <!-- d-block 은 display: block; 이고  w-100 은 width 의 크기는 <div class="carousel-item active">의 width 100% 로 잡으라는 것이다. -->
			    </div>
			    <div class="carousel-item">
			      <img src="<%= ctxPath %>/images/index/carousel_img2.png" class="d-block w-100 carousel_img" alt="...">
			    </div>
			    <div class="carousel-item">
			      <img src="<%= ctxPath %>/images/index/carousel_img3.png" class="d-block w-100 carousel_img" alt="...">
			    </div>
			  
			  </div>
			  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
			    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
			    <span class="sr-only">Previous</span>
			  </a>
			  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
			    <span class="carousel-control-next-icon" aria-hidden="true"></span>
			    <span class="sr-only">Next</span>
			  </a>
			</div>
	  </div>
	  
	  <div style="width: 80%; margin: 0 auto 300px auto;">
	  	
		<div class="col-md-12 ">
	  		<div class="row">
		        <div class="col-7">
		        <a href=""> <img id="img_all" src="<%= ctxPath %>/images/index/index_menuimg1.png" class="img-responsive img-rounded "  /></a>
		          <h4>텍스트1</h4>
		        </div>
		        
		        <div class="col-5">
		         <a href="">  <img id="img_sale" src="<%= ctxPath %>/images/index/index_menuimg6.png" class="img-responsive img-rounded"  /></a>
		          <h4>텍스트2</h4>
		    	</div>
			</div>
    	</div>
      

        <div class="col-md-12 ">
	  		<div class="row">
		        <div class="col-4">
		         <div>
		         <a href="">  <img id="img_necklaces" src="<%= ctxPath %>/images/index/index_menuimg2.png" class="img-responsive img-rounded "  /></a>
		          <div id="text_necklaces"><h5>텍스트1</h5></div>
		         </div>
		         
		         <div>
		         <a href="">  <img id="img_rings" src="<%= ctxPath %>/images/index/index_menuimg2.png" class="img-responsive img-rounded "  /></a>
		          <div id="text_rings"><h5>텍스트1</h5></div>
		          </div>
		        </div>
		         
		        <div class="col-8">
		         <a href="">  <img id="img_top10" src="<%= ctxPath %>/images/index/index_menuimg3.png" class="img-responsive img-rounded"  /></a>
		          <h4>텍스트2</h4>
		    	</div>
			</div>
    	</div>
    
	  	
	  </div>
	  
	  <div style=" margin-bottom: 300px">
	    <p class="h3 my-3 text-center">BEST</p>
	    
	    <div class="row" id="displayBEST"></div> 
	    
	    <div>
	        <p class="text-center">
	           <span id="end" style="display:block; margin:20px; font-size: 14pt; font-weight: bold; color: red;"></span>
	           
	           <button type="button" class="btn btn-secondary btn-lg" id="btnMoreBEST" value="">BEST 상품 더보기</button>
	           <span id="totalBESTCount">${requestScope.totalBESTCount }</span>
	           <span id="countBEST">0</span>
	        </p>
	    </div>
	  </div>
 	  
	  <div>
	  	<a href="https://www.youtube.com/watch?v=FB0MFsndLZE&list=TLGGshbOh15ajFkxNDA0MjAyMg&t=2s" target="_blank">
	  		<img src="<%= ctxPath %>/images/index/index_videoimg.png" style="width: 100%; height: 50%; margin-bottom: 300px">
	  	</a>
	  </div>
	  
	  	
	</div>



<jsp:include page="footer.jsp"/>