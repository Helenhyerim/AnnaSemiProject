<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="qnaCBJ.model.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="vo" class="qnaCBJ.model.QnaVO" />
<jsp:useBean id="dao" class="qnaCBJ.model.QnaDAO" />
<jsp:setProperty name="vo" property="*"/>

<%
	dao.insert(vo);
	
	response.sendRedirect(request.getContextPath() + "/qna.an"); //아래 코드와 같은 기능이다.
%>