<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String pageName = request.getParameter("page");
if (pageName == null)
    pageName = "";
%>
<script>
    $(function () {
        $("#btn_login").click(function() {
            location.href = "index.jsp?mode=login&from=<%=pageName%>";
        });
        
        $("#btn_logout").click(function() {
            location.href = "/myWiki/util/logout.jsp?from=<%=pageName%>";
        });
        
        $("#btn_register").click(function() {
            location.href = "/myWiki/index.jsp?mode=register&from=<%=pageName%>";
        });
    });
</script>
<div id="header">
    <div class="user_info">
        <%
	    if (session.getAttribute("user") == null) {
	    %>
	    <button id="btn_login">login</button>
	    <button id="btn_register">register</button>
	    <%
	    } else {
	    %>
	    <button id="btn_logout">logout</button>
	    <%
	    }
	    %>
    </div>
    <form action="index.jsp" method="get" id="search">
        <input type="text" name="search">
        <button>search</button>
    </form>
</div>
