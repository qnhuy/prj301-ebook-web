<%-- 
    Document   : change_password
    Created on : Mar 5, 2025, 3:41:49 AM
    Author     : Minh Thu
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Change Password</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="d-flex justify-content-center align-items-center vh-100">
    <div class="card p-4 shadow-lg" style="width: 400px;">
        <h3 class="text-center">Change Password</h3>
        <form action="change-password" method="post">
            <div class="mb-3">
                <label class="form-label">Old Password</label>
                <input type="password" name="oldPassword" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label">New Password</label>
                <input type="password" name="newPassword" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-warning w-100">Change Password</button>
        </form>
<<<<<<< HEAD
        <p class="mt-3 text-center"><a href="home.jsp">Back to Home</a></p>
=======
        <p class="mt-3 text-center"><a href="customer-home.jsp">Back to Home</a></p>
>>>>>>> c9e900d0c36f013d0207467e8440dc15170dfdab
    </div>
</body>
</html>

