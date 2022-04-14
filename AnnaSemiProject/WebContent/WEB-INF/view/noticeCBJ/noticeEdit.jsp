<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="noticeCBJ.model.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="vo" class="noticeCBJ.model.NoticeVO"/>
<jsp:useBean id="dao" class="noticeCBJ.model.NoticeDAO"/>
<jsp:setProperty name="vo" property="*"/>

<%
	dao.update(vo);
	pageContext.setAttribute("vo",vo);
	response.sendRedirect(request.getContextPath() + "/notice.an"); //아래 코드와 같은 기능이다.

%>