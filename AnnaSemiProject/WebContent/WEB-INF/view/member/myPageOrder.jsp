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
 		border: solid 1px gray;
		
	}
	
</style>

<script type="text/javascript">

	const lenHIT = 4;
	// HIT 상품 "스크롤" 버튼을 클릭할때 보여줄 상품의 개수(단위)크기
	
	let start = 1;
	
	$(document).ready(function(){
		
		$("span#totalHITCount").hide();
		$("span#countHIT").hide();
	
		displayHIT(start);
		
		const web_browser_height = $(window).height();
		
		//  ==== 스크롤 이벤트 발생 시키기 시작 ==== //
		
		$(window).scroll(function(){
			
			
			if($(window).scrollTop() + 1 >= $(document).height() - web_browser_height){
				
				// alert("새로이 4개 제품 더보여주어야 함. 확인용");
				const totlaHITCount = $("span#totalHITCount").text();
				const countHIT = $("span#countHIT").text();
				
				if(totalHITCount != countHIT){
					
					start = start + lenHIT;
					displayHIT(start);
					
				}
				
				
			}// end of if($(window).scrollTop() + 1 >= $(document).height() - web_browser_height)---------------
			
			if($(window).scrollTop() == 0){
				// 다시 처음부터 시작하도록 한다.
				$("div#displayHIT").empty();
				$("span#end").empty();
				$("span#countHIT").text("0");
				
				start = 1;
				displayHIT(start);
				
			}
			
			
		});
		
		
		//  ==== 스크롤 이벤트 발생 시키기 끝 ==== //
		
	});// end of $(document).ready(function(){})------------------------

	
	// Function Declration
	
	
	// display 할 HIT상품 정보를 추가 요청하기(Ajax 로 처리함)
	function displayHIT(start) { // start 가 1   이라면 1~8   까지 상품 8개를 보여준다.
		                         // start 가 9   이라면 9~16  까지 상품 8개를 보여준다. 
		                         // start 가 17  이라면 17~24 까지 상품 8개를 보여준다. ㅛㅛㅛㅛㅛㅛ
		                         // start 가 25  이라면 25~32 까지 상품 8개를 보여준다. 
		                         // start 가 33  이라면 33~36 까지 상품 4개를 보여준다. (마지막 상품)
		                         
		$.ajax({
			url:"/MyMVC/shop/mallDisplayJSON.up",
		//	type:"GET",
			data:{"sname":"HIT"
				 ,"start":start   // "1"  "9"  "17"  "25"  "33"
				 ,"len":lenHIT},  //  8    8    8     8     8
			dataType:"JSON",
			success:function(json) {
				/*
				console.log(json);
				console.log(typeof json);
				
				const str_json = JSON.stringify(json);// JSON 객체를 string 타입으로 변경해주는 것
				
				console.log(typeof str_json); // string
				console.log(str_json); // string
				
				const obj_json = JSON.parse(str_json); // JSON 모양으로 되어진 string 을 실제 JSON 객체로 변경시켜주는 것
				
				console.log(typeof obj_json); // object
				console.log(obj_json);
				*/
				
				/*
				
				json ==>[{"pnum":36,"code":"100000","discountPercent":17,"pname":"노트북30","pcompany":"삼성전자","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"59.jpg","pqty":100,"pimage2":"60.jpg","pcontent":"30번 노트북","price":1200000,"sname":"HIT"}
					    ,{"pnum":35,"code":"100000","discountPercent":17,"pname":"노트북29","pcompany":"레노버","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"57.jpg","pqty":100,"pimage2":"58.jpg","pcontent":"29번 노트북","price":1200000,"sname":"HIT"}
					    ,{"pnum":34,"code":"100000","discountPercent":17,"pname":"노트북28","pcompany":"아수스","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"55.jpg","pqty":100,"pimage2":"56.jpg","pcontent":"28번 노트북","price":1200000,"sname":"HIT"}
					    ,{"pnum":33,"code":"100000","discountPercent":17,"pname":"노트북27","pcompany":"애플","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"53.jpg","pqty":100,"pimage2":"54.jpg","pcontent":"27번 노트북","price":1200000,"sname":"HIT"}
					    ,{"pnum":32,"code":"100000","discountPercent":17,"pname":"노트북26","pcompany":"MSI","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"51.jpg","pqty":100,"pimage2":"52.jpg","pcontent":"26번 노트북","price":1200000,"sname":"HIT"}
					    ,{"pnum":31,"code":"100000","discountPercent":17,"pname":"노트북25","pcompany":"삼성전자","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"49.jpg","pqty":100,"pimage2":"50.jpg","pcontent":"25번 노트북","price":1200000,"sname":"HIT"}
					    ,{"pnum":30,"code":"100000","discountPercent":17,"pname":"노트북24","pcompany":"한성컴퓨터","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"47.jpg","pqty":100,"pimage2":"48.jpg","pcontent":"24번 노트북","price":1200000,"sname":"HIT"}
					    ,{"pnum":29,"code":"100000","discountPercent":17,"pname":"노트북23","pcompany":"DELL","saleprice":1000000,"point":60,"pinputdate":"2022-04-04","pimage1":"45.jpg","pqty":100,"pimage2":"46.jpg","pcontent":"23번 노트북","price":1200000,"sname":"HIT"}]
			
				또는 
				
				json ==> []
				*/
				
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
						
						html +=  "<div class='col-md-6 col-lg-3'>"+
			                        "<div class='card mb-3'>"+
			                            "<img src='/MyMVC/images/"+item.pimage1+"' class='card-img-top' style='width: 100%'/>"+
			                            "<div class='card-body' style='padding: 0; font-size: 11pt;'>"+
			                              "<ul class='list-unstyled mt-3 pl-3'>"+
			                                 "<li><label class='prodInfo'>제품명</label>"+item.pname+"</li>"+
			                                 "<li><label class='prodInfo'>정가</label><span style=\"color: red; text-decoration: line-through;\">"+(item.price).toLocaleString('en')+" 원</span></li>"+
			                                   "<li><label class='prodInfo'>판매가</label><span style=\"color: red; font-weight: bold;\">"+(item.saleprice).toLocaleString('en')+" 원</span></li>"+
			                                   "<li><label class='prodInfo'>할인율</label><span style=\"color: blue; font-weight: bold;\">["+item.discountPercent+"%] 할인</span></li>"+
			                                   "<li><label class='prodInfo'>포인트</label><span style=\"color: orange;\">"+item.point+" POINT</span></li>"+ 
			                                   "<li class='text-center'><a href='/MyMVC/shop/prodView.up?pnum="+item.pnum+"' class='stretched-link btn btn-outline-dark btn-sm' role='button'>자세히보기</a></li>"+ 
			                                   <%-- 카드 내부의 링크에 .stretched-link 클래스를 추가하면 전체 카드를 클릭할 수 있고 호버링할 수 있습니다(카드가 링크 역할을 함). --%>         
			                              "</ul>"+
			                            "</div>"+
			                         "</div>"+ 
			                      "</div>";
						
					});// end of $.each(json, function(index, item){} -----------------------------
					// HIT 상품 결과를 출력하기 
					$("div#displayHIT").append(html);
					
				
					// countHIT에 지금까지 출력된 상품의 개수를 누적해서 기록한다.
					$("span#countHIT").text(Number($("span#countHIT").text()) + json.length );
					
					// 스크롤을 계속해서 클릭하여 countHI값과 totalHITCount값이 일치하는 경우
					if($("span#countHIT").text() == $("span#totalHITCount").text()){
						
						$("span#end").html("더이상 죄회할 제품이 없습니다.");
			
					}
					
					
				}
				
			},
			error: function(request, status, error){
				alert("code: "+request.status+"\n"+"message: "+request.responseText+"\n"+"error: "+error);
			}
		});                         
		
	}// end of function displayHIT(start)-------------------------------
	
</script>

	<%-- === HIT 상품을 모두 가져와서 디스플레이(마우스 스크롤 방식으로 페이징 처리한 것) === --%>
	<div>
	    <p class="h3 my-3 text-center">- HIT 상품 -</p>
	    
	    <div class="row" id="displayHIT"></div> 
	    
	    <div>
	        <p class="text-center">
	           <span id="end" style="font-size: 14pt; font-weight: bold; color: red;"></span> 
	           <span id="totalHITCount">${requestScope.totalHITCount}</span>
	           <span id="countHIT">0</span>
	        </p>
	    </div>
	</div>

<jsp:include page="../common/footer.jsp" /> 