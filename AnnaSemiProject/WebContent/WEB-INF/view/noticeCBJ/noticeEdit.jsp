<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="noticeCBJ.model.*"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% request.setCharacterEncoding("utf-8"); %>

<%
	int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
	NoticeVO vo = new NoticeDAO().selectOne(noticeNo);
	NoticeDAO dao = new NoticeDAO();
	int result = dao.update(noticeNo, request.getParameter("noticeTitle"), request.getParameter("noticeContents"));
//	pageContext.setAttribute("vo",vo);
	if(result >=0 ){	
	response.sendRedirect(request.getContextPath() + "/notice.an"); //아래 코드와 같은 기능이다.
	}
%>