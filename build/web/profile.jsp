<%-- 
    Document   : profile
    Created on : Mar 19, 2025, 9:24:49 AM
    Author     : Minh Thu
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân</title>
</head>
<body>
    <h2>Thông tin cá nhân</h2>
    <p><b>Tên đăng nhập:</b> <%= user.getUsername() %></p>
    <p><b>Email:</b> <%= user.getEmail() %></p>
    <p><b>Vai trò:</b> <%= user.getRole() %></p>

    <a href="edit_profile.jsp">✏ Chỉnh sửa thông tin</a> |
    <a href="changepassword.jsp">🔒 Đổi mật khẩu</a> |
    <a href="logout">🚪 Đăng xuất</a>

    <% if ("customer".equals(user.getRole())) { %>
        <h3>🛒 Lịch sử đơn hàng</h3>
        <a href="order_history.jsp">Xem chi tiết</a>
    <% } %>

    <% if ("admin".equals(user.getRole())) { %>
        <h3>🔧 Quản lý người dùng</h3>
        <a href="admin_user_management.jsp">Xem danh sách</a>
    <% } %>
</body>
</html>
