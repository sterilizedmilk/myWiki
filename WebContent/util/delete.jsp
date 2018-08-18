<%@page import="myWiki.WikiLogDAO"%>
<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myWiki.WikiPageDAO"%>
<%
String pageName = request.getParameter("page");
String nickname = (String) session.getAttribute("user");
int length = (new WikiPageDAO()).readPage(pageName).length();
if (nickname == null) {
    out.print("NOT_LOGIN");
} else if ((new WikiPageDAO()).deletePage(pageName) > 0) {
    (new WikiLogDAO()).recordLog(pageName, nickname, "deleted", -length);
    out.print("SUCCESS");
} else {
    out.print("FAIL");
}
%>
