<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="faqCBJ.model.*"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	
	int faqNo = Integer.parseInt(request.getParameter("faqNo"));
	FaqDAO dao = new FaqDAO();
	dao.delete(faqNo);	
	response.sendRedirect(request.getContextPath() + "/faq.an");
%>