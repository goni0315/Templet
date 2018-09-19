<%@page import="java.net.URLEncoder"%>
<%@ page contentType="text/html; charset=UTF-8" %>

<%
	//String id = request.getParameter("userId");
	//String name = request.getParameter("userName");
	String name = "이윤호";
	//System.out.println(name);
	name = URLEncoder.encode(name, "UTF-8");
	response.sendRedirect(request.getContextPath()+"/main.do?userName="+name);
%>     