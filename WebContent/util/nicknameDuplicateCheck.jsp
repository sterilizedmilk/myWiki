<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myWiki.WikiUserDAO" %>
<%
if ((new WikiUserDAO()).nicknameDuplicateCheck(request.getParameter("nickname"))) {
    out.print("OK");
} else {
    out.print("USED");
}
%>
