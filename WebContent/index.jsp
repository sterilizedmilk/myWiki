<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="myWiki.WikiPageDAO"%>
<!DOCTYPE html>
<html>
<%
    String pageName = request.getParameter("page");
    String search = request.getParameter("search");
    String mode = request.getParameter("mode");
%>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
 	<script src="http://code.jquery.com/jquery-2.2.4.min.js"></script>
	<link rel="stylesheet" type="text/css" href="css/general.css">
	<script>
        function deletePage() {
            if (confirm("are you real?")) {
	            $.ajax({
	                url: "util/delete.jsp?page=<%=pageName%>",
	                type: "get",
	                success: function(result) {
	                    result = $.trim(result);
	                    if(result == "SUCCESS") {
	                        alert("Successfully deleted");
	                        location.href = "index.jsp";
	                    } else if (result == "NOT_LOGIN") {
	                        alert("You have to login first!");
	                        location.href = "index.jsp?mode=login&from<%=pageName%>";
	                    } else {
	                        alert("Failed to delete");
	                    }
	                }
	            });
            }
        }
    </script>
</head>
<body>
    <div id="content">
        <%
        /*
         * select content type by parameter.
         * content is included from /content
         */
	    if ("login".equals(mode)) { // login
	    %>
	        <jsp:include page="content/loginPage.jsp"></jsp:include>
	    <%
	    } else if ("register".equals(mode)) { // register
	    %>
	        <jsp:include page="content/registerPage.jsp"></jsp:include>
	    <%
        } else if ("log".equals(mode)) { // view log
        %>
            <jsp:include page="content/viewLog.jsp"></jsp:include>
        <%
	    } else if (search != null) {
	        if ((new WikiPageDAO()).isPageExist(search)) { // found exactly matching page
	            response.sendRedirect("index.jsp?page=" + URLEncoder.encode(search, "UTF-8"));
	        } else { // search page
	    %>
	        <jsp:include page="content/searchPage.jsp?search=<%=search%>"></jsp:include>
	    <%
	        }
	    } else if (pageName == null || pageName.isEmpty()) { // main page
	    %>
	        <jsp:include page="content/mainPage.jsp"></jsp:include>
	    <%
	    } else if ("edit".equals(mode)) { // edit page
	        %>
	        <jsp:include page="content/editPage.jsp?page=<%=pageName%>"></jsp:include>
	        <%
	    } else if (!(new WikiPageDAO()).isPageExist(pageName)) { // page was not found
	        %>
	        <jsp:include page="content/notFound.jsp"></jsp:include>
	        <%
	    } else { // view page
	            String content = (new WikiPageDAO()).readPage(pageName);
	    %>
                <h1 class="heading">
                    <%=pageName.replaceAll("&", "&amp;").replaceAll("<", "&lt;")%>
			    </h1>
				<br />
				<div class="contentBody">
				        <%=content.replaceAll("&", "&amp;")
				                  .replaceAll("<", "&lt;")
				                  .replaceAll("\"", "&quot;")
				                  .replaceAll(" ", "&nbsp;")
				                  .replaceAll("\r\n", "<br/>")
				        %>
				</div>
				<div>
			       <button onclick="location.href='index.jsp?page=<%=pageName%>&mode=edit'">edit</button>
		    	   <button onclick="deletePage();">delete</button>
		    	   <button onclick="location.href='index.jsp?page=<%=pageName%>&mode=log'">log</button>
				</div>
	    <%
	    }
	    %>
    </div>
	<jsp:include page="component/header.jsp"></jsp:include>
	<jsp:include page="component/panel.jsp"></jsp:include>
	<jsp:include page="component/footer.jsp"></jsp:include>
</body>
</html>
