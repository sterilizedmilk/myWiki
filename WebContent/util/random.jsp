<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="myWiki.WikiPageDAO"%>
<% response.sendRedirect("/myWiki/index.jsp?page=" + URLEncoder.encode(WikiPageDAO.getInstance().randomPage(), "UTF-8")); %>
