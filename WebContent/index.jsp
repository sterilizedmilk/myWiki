<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
        <c:choose>
		    <c:when test="<%=\"login\".equals(mode)%>">
		        <jsp:include page="content/loginPage.jsp" />
		    </c:when>
		    
		    <c:when test="<%=\"register\".equals(mode)%>">
		        <jsp:include page="content/registerPage.jsp" />
		    </c:when>
		    
		    <c:when test="<%=\"log\".equals(mode)%>">
	            <jsp:include page="content/viewLog.jsp" />
		    </c:when>
		    
            <c:when test="<%=search != null%>">
                <c:choose>
                    <c:when test="<%=(new WikiPageDAO()).isPageExist(search)%>">
                        <c:redirect url="<%=\"index.jsp?page=\" + URLEncoder.encode(search, \"UTF-8\")%>"/>
                    </c:when>
                    
                    <c:otherwise>
        		        <jsp:include page="content/searchPage.jsp?search=<%=search%>"></jsp:include>
                    </c:otherwise>
                </c:choose>
            </c:when>
            
            <c:when test="<%=pageName == null || pageName.isEmpty()%>">
		        <jsp:include page="content/mainPage.jsp" />
            </c:when>
            
            <c:when test="<%=\"edit\".equals(mode)%>">
                <jsp:include page="content/editPage.jsp?page=<%=pageName%>" />
            </c:when>
            
            <c:when test="<%=!(new WikiPageDAO()).isPageExist(pageName)%>">
		        <jsp:include page="content/notFound.jsp" />
            </c:when>
            
            <c:otherwise>
		        <% String content = (new WikiPageDAO()).readPage(pageName);%>
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
            </c:otherwise>
        </c:choose>
    </div>
	<jsp:include page="component/header.jsp" />
	<jsp:include page="component/panel.jsp" />
	<jsp:include page="component/footer.jsp" />
</body>
</html>
