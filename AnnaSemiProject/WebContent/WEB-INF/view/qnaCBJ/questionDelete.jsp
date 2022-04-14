<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="qnaCBJ.model.*"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	QnaDAO dao = new QnaDAO();
	dao.delete(qnaNo);	
	response.sendRedirect(request.getContextPath() + "/qna.an");
%>