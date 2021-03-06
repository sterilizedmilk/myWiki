<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="myWiki.WikiPageDTO"%>
<%@ page import="myWiki.WikiPageDAO"%>
<%String keyword = request.getParameter("search").replaceAll("&", "&amp;").replaceAll("<", "&lt;");%>
<script>
    document.title = "Search (<%=keyword%>)";
</script>
<h1 class="heading" >
search for <%=keyword%>
</h1>
<div>
    <div class="box_notice">
	<%
	ArrayList<WikiPageDTO> list = WikiPageDAO.getInstance().search(keyword);
    if (list == null || list.isEmpty()) {
        %>
        <span>Page does not exist.</span><br/>
        <%
    }
    %>
        <a href="index.jsp?page=<%=keyword%>&mode=edit">
	    Create page "<%=keyword%>"</a><br/>
    </div>
    <ul>
    <%
    for (WikiPageDTO pg : list) {
        %>
        <li>
	        <div>
		        <h2><a href="index.jsp?page=<%=pg.getName()%>"><%=pg.getName().replaceAll("<", "&lt;")%></a></h2>
		        <%=pg.getContent().replaceAll("&", "&amp;")
                                  .replaceAll("<", "&lt;")
                                  .replaceAll("\"", "&quot;")
                                  .replaceAll(" ", "&nbsp;")
                                  .replaceAll("\r\n", "&nbsp;") // line break -> space
                %>
			</div>
        </li>
    <%
    }
	%>
	</ul>
</div>
