<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="board.*, java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:useBean id="dao" class="board.BoardDao"/>
<%
	
	int qnano = Integer.parseInt(request.getParameter("qnano"));	
	BoardVo vo =dao.selectOne(qnano);
	pageContext.setAttribute("vo", vo);

%>

 
<jsp:include page="../header_annadia.jsp"/>

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
		height: 40px; width: 800px;
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




<%-- <p>번호:${vo.qnano}</p>
<p>작성자:${vo.fk_userid}</p>
<p>문의제목:${vo.questiontitle}</p>
<p>문의내용:${vo.questioncontents}</p>
<p>문의날짜:${vo.questiondate}</p>
<p>답변제목:${vo.answertitle}</p>
<p>답변내용:${vo.answercontents}</p>
<p>답변날짜:${vo.answerdate}</p> 
 --%>
 
 <div style = "margin: 20% 28%" \>
     
      
    
    
    <div style = "width: 500px;">
		<table>
			<thead>
				<tr>
					<th width="90%"><p>[제목]:${vo.questiontitle}</p></th>
					
				</tr>
			</thead>
			
			<tbody>
				<tr>
					<td class="mycenter"><p>[내용]:${vo.questioncontents}</p> </td>
					
				</tr>
				
				
			</tbody>
		</table>
	</div>
	
     </div>



<c:forEach var="TBL_QNA" items="${ls}">

</c:forEach>


<div style="padding: 0 47%;">

<%-- <%= ctxPath%> --%>
    <a href="list.jsp">
        <input type="button" value="글 목록">
    </a>
    </div>
    

</body>
</html>