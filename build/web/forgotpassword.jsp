<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Random, java.net.URLEncoder" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Forgot Password</title>
</head>
<body>
    <h2>Forgot Password</h2>
    <form method="get">
        <label>Enter your email:</label>
        <input type="email" name="email" required>
        <button type="submit">Send Code</button>
    </form>

    <%
        // Lấy email từ request
        String email = request.getParameter("email");

        if (email != null && !email.isEmpty()) {
            // Tạo mã xác nhận 5 chữ số ngẫu nhiên
            Random rand = new Random();
            int code = 10000 + rand.nextInt(90000); 
            
            // Nội dung email
            String subject = "Reset Password";
            String body = "Your password reset code is: " + code;
            
            // Mã hóa URL để đảm bảo không có lỗi ký tự đặc biệt
            subject = URLEncoder.encode(subject, "UTF-8");
            body = URLEncoder.encode(body, "UTF-8");
            
            // Link mở Gmail
            String gmailLink = "https://mail.google.com/mail/?view=cm&fs=1&to=" + email + "&su=" + subject + "&body=" + body;
    %>
        <p>Click the link below to open Gmail and send the email:</p>
        <a href="<%= gmailLink %>" target="_blank">Send mail</a>
    <%
        }
    %>
</body>
</html>
