<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <div style="width: 95%;
	            border: hidden;
	            padding-top: 5px;
	            padding-bottom: 5px;
	            float: left;">
	    <a href="<%= request.getContextPath()%>/faq.an">전체</a>&nbsp;&#124;
		<c:forEach var="map" items="${requestScope.faqCategoryList}">
			<a href="<%= request.getContextPath()%>/faqByCategory.an?cnum=${map.cnum}">${map.cname}</a>&nbsp;&#124;
		</c:forEach>
    </div>
    