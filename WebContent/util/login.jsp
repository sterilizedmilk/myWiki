<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="myWiki.WikiUserDAO"%>
<%
String nickname = request.getParameter("nickname");
String password = request.getParameter("password");
if ((new WikiUserDAO()).passwordCheck(nickname, password)) {
    session.setAttribute("user", nickname);
	%>
	<script> alert("welcome!"); </script>
	<%
} else {
	%>
	<script> alert("failed to login."); </script>
	<%
}
response.sendRedirect("/myWiki/index.jsp?page="
                      + URLEncoder.encode(request.getParameter("from"), "UTF-8"));
%>
