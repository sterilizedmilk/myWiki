<%@ page language="java" contentType="text/plain; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="myWiki.WikiPageDTO"%>
<%@ page import="myWiki.WikiPageDAO"%>
<%@ page import="myWiki.WikiLogDAO"%>
<%
request.setCharacterEncoding("UTF-8");
String pageName = request.getParameter("pageName");
String nickname = (String) session.getAttribute("user");
String page_content = request.getParameter("page_content");
if (nickname == null) {
    
} else if (WikiPageDAO.getInstance().isPageExist(pageName)) {
    int oldLength = WikiPageDAO.getInstance().readPage(pageName).length();
    WikiLogDAO.getInstance().recordLog(pageName, nickname, "edited", page_content.length() - oldLength);
    WikiPageDAO.getInstance().updatePage(pageName, page_content);
} else {
    WikiPageDAO.getInstance().createPage(new WikiPageDTO(pageName, page_content));
    WikiLogDAO.getInstance().recordLog(pageName, nickname, "created", page_content.length());
}
response.sendRedirect("/myWiki/index.jsp?page=" + URLEncoder.encode(pageName, "UTF-8"));
%>
