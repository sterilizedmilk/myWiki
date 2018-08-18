<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%String pageName = request.getParameter("page").replaceAll("&", "&amp;").replaceAll("<", "&lt;");%>
<h2>Page dose not exist.</h2>
<div class="box_notice">
	<a href="index.jsp?page=<%=pageName%>&mode=edit">
	   Create page <%=pageName%>
	</a><br/>
	<a href="index.jsp?search=<%=pageName%>">
	Search for page <%=pageName%>
    </a>
</div>
