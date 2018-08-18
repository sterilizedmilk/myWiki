<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="myWiki.WikiPageDAO"%>
<%
String pageName = request.getParameter("page").replaceAll("&", "&amp;").replaceAll("<", "&lt;");
boolean newPage = !(new WikiPageDAO()).isPageExist(pageName);
if (session.getAttribute("user") == null) {
    %>
    <script>
        alert("you have to login before edit document!");
        location.href="/myWiki/index.jsp?mode=login&from=<%=pageName%>";
    </script>
    <%
    return;
}
request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
%>
<script>
    function edit_submit() {
        var pageName = document.createElement("input");
        pageName.setAttribute("type", "hidden");
        pageName.setAttribute("name", "pageName");
        pageName.setAttribute("value", "<%=pageName%>");
        document.getElementById("edit").appendChild(pageName);
        return true;
    };
</script>
<h1><%=pageName%>: <%=newPage? "Create" : "Edit"%></h1>
<div class="content_body">
	<form action="/myWiki/util/update.jsp" method="post" id="edit" onsubmit="return edit_submit();">
	    <% if (newPage) { %>
	           <textarea form="edit" name="page_content" id="content_edit"></textarea>    
	    <% } else { %>
		       <textarea form="edit" name="page_content" id="content_edit"><%=(new WikiPageDAO()).readPage(pageName)%></textarea>
	    <% } %>
	    
		<br />
		<button>submit</button>
		<button type="button" onclick="history.back();">cancel</button>
	</form>
</div>
