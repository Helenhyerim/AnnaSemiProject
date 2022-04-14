<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="eventCBJ.model.*"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	
	int eventNo = Integer.parseInt(request.getParameter("eventNo"));
	EventDAO dao = new EventDAO();
	dao.delete(eventNo);	
	response.sendRedirect(request.getContextPath() + "/event.an");
%>