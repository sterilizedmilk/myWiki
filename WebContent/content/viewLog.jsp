<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="myWiki.WikiLogDAO"%>
<%@ page import="myWiki.WikiLogDTO"%>
<%@ page import="java.util.ArrayList"%>
<%
String pageName = request.getParameter("page");
ArrayList<WikiLogDTO> logList;
if (pageName != null) {
    logList = (new WikiLogDAO()).readLog(pageName);
} else {
    pageName = "All";
    logList = (new WikiLogDAO()).readLog();
}
%>
<h1><%=pageName%>: Log</h1>
<div>
    <c:choose>
        <c:when test="<%=logList == null || logList.isEmpty()%>">
            <div class="box_notice">there is no log about this page.</div>    
        </c:when>
        <c:otherwise>
        <ul>
        <%
        for (WikiLogDTO log : logList) {
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
            %>
            <li>
            <%=format.format(log.getLogTime())%> : <%=pageName.equals("All")? log.getPageName() +   " " : "" %>
            <%=log.getLogType()%> by <%=log.getNickname()%>
            (<span class="<%=log.getDiff() > 0 ? "log_increase" : log.getDiff() < 0 ? "log_decrease" : ""%>">
            <%=String.format("%+d", log.getDiff())%></span>)
            </li>
            <%
        }
        %>
        </ul>  
        </c:otherwise>
    </c:choose>
</div>
