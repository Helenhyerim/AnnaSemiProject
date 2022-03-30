<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="noticeCBJ.model.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	NoticeDAO dao = new NoticeDAO();
	System.out.println(noticeNo);
	dao.delete(noticeNo);	
	response.sendRedirect(request.getContextPath() + "/noticeDelete.an");
%>