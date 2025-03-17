<%-- 
    Document   : logout
    Created on : Mar 5, 2025, 3:25:28 AM
    Author     : Minh Thu
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession sessionLogout = request.getSession(false);
    if (sessionLogout != null) {
        sessionLogout.invalidate();
    }
    response.sendRedirect("login.jsp");
%>
