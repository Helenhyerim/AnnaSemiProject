<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="../view/common/header_login.jsp"/>

<style>
	div#contianer {
		width: 90%;
		margin: 250px auto;
	}
	
	div#sidebar {
		position: fixed;
		top: 250px;
		left: 50px;
		width: 15%;
		height: 500px;
		overflow: auto;
		margin:0 auto;
	}
	
	div#sidebar ul {
		list-style-type: none;
		padding: 0;
	}
	
	div#sidebar li a {
		line-height: 60px;
		font-size: 18pt;
		color: gray;
	}
	
	div#main_content {
		margin-left: 200px;
	}
	
	div#product_cover {
		padding: 0;
		/* text-align: center; */
	}
	
	div#cover > img {
		width: 90%;
	}
	
	div#img_list {
		margin: 10px auto;
		/* text-align: center; */
	}
	
	div#img_list > img {
		width: 15%;
		margin: 0 5px;
	}
	
	div#img_list > img:hover {
		opacity: 0.8;
	}
	
	div#product_option {padding: 10px;}
	
 	table#tbl_option tr {height: 40px;}
	
	table#tbl_option th {width: 100px;}
	
	div#bottom_content {width: 90%;}
	
	div#productInfo {
		margin-top: 50px;
		margin-bottom: 100px;
	}
	
	div#productDetailImg {
		text-align: center;
		margin-bottom: 250px;
	}
	
	div#productDetailImg > img {
		width: 90%;
	}
	
	div#productDetailImg > img:first-child {margin-bottom: 200px;}
	
	div#review_board, div#QnA_board {margin: 50px auto;}
</style>



<div id="contianer">
	<div id="sidebar">
		<ul>
			<li><a href="#">Necklaces</a></li>
			<li><a href="#">Earrings</a></li>
			<li><a href="#">Rings</a></li>
			<li><a href="#">Bracelets</a></li>
			<li><a href="#">Sale</a></li>
		</ul>
	</div>

	<div id="main_content">
		<div id="top_content" class="row">
			<div id="product_cover" class="col-md-7">
				<div id="cover"><img alt="p1" src="../images/p1.png"></div>	<!-- hover html div 집어넣기 트리거로 기본 p1 보여주기 -->
				<div id="img_list">
					<img alt="p1" src="../images/p1.png">	<!-- 파일명 db연동 -->
					<img alt="p2" src="../images/p2.png">	<!-- 파일명 db연동 -->
					<img alt="p3" src="../images/p3.png">	<!-- 파일명 db연동 -->
					<img alt="p4" src="../images/p4.png">	<!-- 파일명 db연동 -->
					<img alt="p5" src="../images/p5.png">	<!-- 파일명 db연동 -->
				</div>
			</div>
			<div id="product_option" class="col-md-5">
				<h5 class="mb-3">14K RING / ARF0380QST</h5>	<!-- 제품명 / 제품코드 db 연동 -->
				<p class="mb-0"><span>판매가 : </span>    345,000원</p>	<!-- 가격 db연동 -->
				<p class="my-0"><span>회원가 : </span>    334,650원 (10,350원 할인)</p>	<!-- 가격 db연동 후 script 처리(3% 할인가) -->
				
				<hr style="border: solid 1px lightgray">
				
				<table id="tbl_option">
					<tr>
						<th>필수 옵션</th>
						<td>
							<select>
								<option>[필수] 옵션을 선택해주세요</option>
								<option>14K 로즈골드 5호</option>
								<option>14K 로즈골드 6호</option>
								<option>14K 로즈골드 7호</option>
								<option>14K 옐로우골드 5호</option>
								<option>14K 옐로우골드 6호</option>
								<option>14K 옐로우골드 7호</option>
								<option>18K 로즈골드 5호</option>
								<option>18K 로즈골드 6호</option>
								<option>18K 로즈골드 7호</option>
								<option>18K 로즈골드 5호</option>
								<option>18K 로즈골드 6호</option>
								<option>18K 로즈골드 7호</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>선택 옵션</th>
						<td>
							<select>
								<option>[선택] 옵션을 선택해주세요</option>
								<option>선물용 포장 (+3,000원)</option>
								<option>카드 첨부 (+5,000원)</option>
							</select>
						</td>
						<td id="card_msg"></td>
					</tr>
					<tr><th data-toggle="tooltip" title="옵션 선택 후 보이기(script)">상품명</th><td  data-toggle="tooltip" title="+-x 버튼 추가(img, script)"><input type="number" min="1" max="100" value="1"></input></td></tr>
				</table>
				
				<hr style="border: solid 1px lightgray">
				
				<p>TOTAL <span data-toggle="tooltip" title="옵션 선택 후 보이기(script)">345,000원(1개)</span></p>
				<p>!할인가가 적용된 최종 결제예정금액은 주문 시 확인할 수 있습니다.</p>
				
				<hr style="border: solid 1px lightgray;">
				
				<button type="button" class="btn btn-secondary btn-block">구매</button>
				
				<p data-toggle="tooltip" title="아이콘 안보임">
					<span><i class="fal fa-shopping-cart"></i>장바구니</span>
					<span><i class="fal fa-heart"></i>찜</span>
				</p>
			</div>
		</div>
		<div id="bottom_content">
			<div id="productInfo">
				<h5>상품정보</h5>
				<hr style="border: solid 1px lightgray; width: 40%; margin: 0;">
				<p>
					Material : 14K 18K Gold<br>
					Stone : X<br>
					Weight: 약3.02g [±10% 오차있음]<br>
					Production : 안나캐럿<br>
					Special Note : 주말 및 공휴일을 제외한 4~6일의 제작기간이 필요한 제품입니다.
				</p>
			</div>
			<div id="productDetailImg">
				<img alt="pd1" src="../images/pd1.jpg">
				<img alt="pd2" src="../images/pd2.png">
			</div>
			
			<div id="review_board">
				<h5>리뷰</h5>
				<table class="table">
			    	<thead class="thead-light">
			      		<tr>
			        		<th>No.</th>
			        		<th>글제목</th>
			        		<th>닉네임</th>
			        		<th>조회수</th>
			      		</tr>
			    	</thead>
			    	<tbody>
			      		<tr>
			        		<td>1</td>
			        		<td>리뷰1</td>
			        		<td>닉네임1</td>
			        		<td>1</td>
			      		</tr>
			      		<tr>
			        		<td>2</td>
			        		<td>리뷰2</td>
			        		<td>닉네임2</td>
			        		<td>2</td>
			      		</tr>
			    	</tbody>
			  	</table>
			</div>
			
			<div id="QnA_board">
				<h5>Q&A</h5>
				<table class="table">
			    	<thead class="thead-light">
			      		<tr>
			        		<th>No.</th>
			        		<th>글제목</th>
			        		<th>닉네임</th>
			        		<th>조회수</th>
			      		</tr>
			    	</thead>
			    	<tbody>
			      		<tr>
			        		<td>1</td>
			        		<td>Q&A1</td>
			        		<td>닉네임1</td>
			        		<td>1</td>
			      		</tr>
			      		<tr>
			        		<td>2</td>
			        		<td>Q&A2</td>
			        		<td>닉네임2</td>
			        		<td>2</td>
			      		</tr>
			    	</tbody>
			  	</table>
			</div>
		</div>
	</div>
	
</div>

<jsp:include page="../view/common/footer.jsp"/>