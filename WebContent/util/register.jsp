<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="myWiki.WikiUserDAO" %>
<%
String nickname = request.getParameter("nickname");
String password = request.getParameter("password");
String from = request.getParameter("from");

if (!WikiUserDAO.getInstance().nicknameDuplicateCheck(nickname)) {
	%>
	<script>
	    alert("nickname '<%=nickname%>' is already used.");
	</script>    
	<%
} else if (!Pattern.matches("^[a-zA-Z][a-zA-Z0-9]{5,19}$", nickname)) {
    %>
    <script>
        alert("nickname '<%=nickname%>' is not valid.");
    </script>    
    <%
} else if (!Pattern.matches("^[a-zA-Z0-9!~@#$%^&*?]{6,20}$", password)) {
    %>
    <script>
        alert("nickname '<%=nickname%>' is not valid.");
    </script>    
    <%
} else {
    WikiUserDAO.getInstance().register(nickname, password);
    session.setAttribute("user", nickname);
}
response.sendRedirect("/myWiki/index.jsp?page=" + (from == null ? "" : from));
%>
