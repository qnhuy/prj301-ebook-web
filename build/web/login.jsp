<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
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
        .btn-primary {
            background-color: #6a5acd;
            border: none;
        }
        .btn-primary:hover {
            background-color: #6a5acd;
        }
        .fw-bold{
            color: #9966FF;
        }
        .bookstore-title {
            color: #6a5acd; 
        }
    </style>
</head>
<body>
    <div class="card">
        <h3 class="text-center bookstore-title">BookStore</h3>
        <p class="text-center text-muted">Welcome back! Please login to continue.</p>
        <form action="login" method="post">
            <div class="mb-3">
                <label class="form-label fw-bold">Username</label>
                <input type="text" name="username" class="form-control" required>
            </div>
            <div class="mb-3">
                <label class="form-label fw-bold">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>
            <div class="mb-3 form-check">
                <input type="checkbox" name="remember" class="form-check-input">
                <label class="form-check-label">Remember me</label>
            </div>
            <button type="submit" class="btn btn-primary w-100">Login</button>
        </form>
        <p class="mt-3 text-center">
            <a href="register.jsp" class="text-primary">Create an account</a>
            <a href="forgotpassword.jsp" class="text-danger">Forgot password?</a>
        </p>
    </div>
</body>
</html>
