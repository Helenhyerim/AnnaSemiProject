<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="../view/common/header_login.jsp"/>

<style type="text/css">

	div#container {
		width: 70%;
		margin: 220px auto 100px auto;
	}
	
	table {
		border-collapse: collapse;
		width: 100%;
	}
	
	table#tbl_writeReview tr {
		border-top: solid 1px lightgray;
		brder-bottom: solid 1px lightgray;
		height: 40px;
	}
	
	td.title {
		background-color: #F8F8F8;
		border-right: solid 1px lightgray;
		width: 25%;
		padding-left: 10px;
	}
	
	td.content {
		padding-left: 10px;
	}

</style>

<script type="text/javascript">

	function goInsertReview() {
		
	//	const queryString = $("form[name=commentFrm]").serialize();
		
		const frm = document.sendWriteReview;
		frm.action = "<%= request.getContextPath() %>/product_lsh/insertReview.an";
		frm.method = "post";
		frm.submit();
	}

</script>

<div id="container">
	<div id="productInfo">
		<table id="tbl_productInfo">
			<tr>
				<td style="width: 20%;">
					<img src="../images/p1.png" style="max-width: 100%; border-radius: 5px;">
				</td>
				<td>
					<ul class="ml-2" style="list-style: none; padding: 0; line-height: 40px;">
						<li>상품명</li>
						<li>상품가격</li>
					</ul>
				</td>
			</tr>
		</table>
	</div>
	
	<div id="writeReviewDiv">
		<form name="sendWriteReview">
			<div class="my-3" style="width: 100%;">
				<table id="tbl_writeReview">
					<tr>
						<td class="title">제목</td>
						<td class="content"><input type="text" name="reviewTitle" id="reviewTitle" style="width: 100%;"/></td>
					</tr>
					<tr style="border-bottom: solid 1px lightgray;">
						<td class="title">작성자 아이디</td>
						<td class="content">
							${requestScope.userid}
							<input type="hidden" name="userid" value="${requestScope.userid}" />
						</td>
					</tr>
				</table>
			</div>
			<textarea cols="50" rows="10" style="resize: none; width: 100%;" name="reviewContents"></textarea>
		</form>
		<div align=right>
			<button type="button" onclick="javascript:history.back()">취소</button>
			<button type="button" onclick="goInsertReview()">등록</button>
		</div>
	</div>
</div>

<jsp:include page="../view/common/footer.jsp"/>