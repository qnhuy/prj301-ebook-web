<!DOCTYPE html>
<html lang="vi">
<head>
    <title>Register</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            background: url('home-background.jpg') no-repeat center center fixed;
            background-size: cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            backdrop-filter: blur(5px);
        }
        .card {
            width: 400px;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            background-color: rgba(255, 255, 255, 0.9);
        }
        .btn-success {
            background-color: #6a5acd;
            border: none;
        }
        .btn-success:hover {
            background-color: #483d8b;
        }
        h3 {
            color: #6a5acd;
        }
        .form-label{
            color:#9966FF;
        }
    </style>
</head>
<body>
    <div class="card">
        <h3 class="text-center">Register</h3>
        <form action="register" method="post">
            <div class="mb-3">
                <label class="form-label fw-bold">Username</label>
                <input type="text" name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Email</label>
                <input type="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            
            <button type="submit" class="btn btn-success w-100">Register</button>
        </form>
        <p class="mt-3 text-center"><a href="login.jsp" class="text-primary">Already have an account? Login</a></p>
    </div>
</body>
</html>