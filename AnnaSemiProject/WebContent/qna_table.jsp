<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    String ctxPath = request.getContextPath();
    //    /MyMVC
%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Insert title here</title>

<style type="text/css">

    div#container {
    
    	width: 71%;
    	margin: 50px auto;
    } 
    
     div#container2 {
    
    	width: 10%;
    	margin: 0px 48%;
    }

    div#container > table {
    	width: 100%;
    }

	table, th, td {
		border: solid 1px gray;
		border-collapse: collapse;
	}
	
	th {
		height: 40px;
		background-color: #ccc;
	}
	
	td {
		height: 600px;
	}
	
	td.mycenter {
		text-align: left;
	}
	
	td.myright {
		text-align: right;
	}

	button#btn {
		width: 100px;
		height: 40px;
		border-radius: 20%;
		border: none;
		
		color: white; 
	}
	
	a.btn{
    display:block;
    width:80px;
    line-height:30px;
    text-align:center;
    background-color:#222;
    color:#fff;
}
 
button.btn{
    width:80px;
    height:30px;
    border:none;
    background-color:#222;
    color:#fff;
}

button#btn {
		width: 100px;
		height: 40px;
		border-radius: 50%;
		border: none;
		background-color: gray;
		color: black; 
		
</style>

</head>

<body>

<jsp:include page="header_annadia.jsp"/>

<div style = "margin: 17% 48%">
     <h1 style= " font-size: 24pt;" >
     QNA
     </h1>
     </div>
     
<div id="container">
		<table>
			<thead>
				<tr>
					<th width="10%">문의 제목</th>
					
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td class="mycenter">문의 내용</td>
					
				</tr>
				
				
			</tbody>
		</table>
	</div>

   <script type="text/javascript">
    $(document).ready(function(){

    	$("div#answer").hide();
    	
    	$("button#btn").text("답변보기");
    	
    	$("button#btn").bind("click", function(){
    		
    		const text = $(this).text();
    		
    		if(text == "답변보기") {
    			$(this).text("감추기");
    			$(this).css({"background-color":"gray", "color":"black"});
    		}
    		else {
    			$(this).text("답변보기");
    			$(this).css({"background-color":"gray", "color":"black"});
    		}
    		
    		$("div#answer").toggle();
    	 
    	});
    	
    });
</script>    
	
<!-- <div id = "container2">
	<button type="button" style = "border-radius:20px;">
	   <p style = "font-size:12pt">답변 보기</p>
	</button>	
</div> -->
         
        

<div style="padding: 0 47%;">


       <form>
    <a href="<%= ctxPath%>/qna_list.jsp">
        <input type="button" value="글 목록">
    </a>
</form>
       
         <form>
    <a href="<%= ctxPath%>/review.jsp">
        <input type="button" value="리뷰페이지(임시로둔거 이따가 없앨거임)">
    </a>
</form>

</body>

       
   

</html>



<!-- <script type="text/javascript" src="../../js/jquery-3.6.0.min.js"></script>  -->


</head>

<!-- <body>
    <div style="display: flex; margin: 50px 0 20px 0;">
    	<div style="margin: auto;">
    		<button id="btn"></button>
    	</div>
    </div>
    <div style="display: flex;">
        <div style="margin: auto;">
    	    <div id="answer"> 
    	    
    	    
    	    
    	     </div>
    	</div>
    </div>
</body>
 -->

<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModalCenter" >
  답변
</button>

<!-- Modal -->
<div class="modal fade" id="exampleModalCenter" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalCenterTitle">답변</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        답변 내용 답변 내용 답변 내용 답변 내용 답변 내용
        답변 내용 답변 내용 답변 내용 답변 내용 답변 내용
        답변 내용 답변 내용 답변 내용 답변 내용 답변 내용
        답변 내용 답변 내용 답변 내용 답변 내용 답변 내용
        답변 내용 답변 내용 답변 내용 답변 내용 답변 내용
        답변 내용 답변 내용 답변 내용 답변 내용 답변 내용
        답변 내용 답변 내용 답변 내용 답변 내용 답변 내용
        답변 내용 답변 내용 답변 내용 답변 내용 답변 내용
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
        
      </div>
    </div>
  </div>
  

  
</div>




<jsp:include page="footer.jsp"/>