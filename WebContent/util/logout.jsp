<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="myWiki.WikiUserDAO"%>
<%
session.removeAttribute("user");
response.sendRedirect("/myWiki/index.jsp?page=" + URLEncoder.encode(request.getParameter("from"), "UTF-8"));
%>
