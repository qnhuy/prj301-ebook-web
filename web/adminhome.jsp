<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Homepage - BookStore</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- CSS tùy chỉnh -->
        <link rel="stylesheet" href="css/style.css">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            body {
                height: 100vh; /* Chiếm toàn bộ chiều cao màn hình */
                overflow: hidden; /* Tránh thanh cuộn */
            }
            .btn-container {
                display: flex;
                flex-direction: row; /* Xếp nút thành hàng ngang */
                justify-content: center; /* Căn giữa theo chiều ngang */
                align-items: center; /* Căn giữa theo chiều dọc */
                height: 50vh; /* Giảm chiều cao để đẩy lên trên */
                gap: 20px; /* Khoảng cách giữa các nút */
                position: relative;
                top: -20vh; /* Đẩy lên trên một chút */
            }
            .btn-custom {
                width: 220px; /* Tăng chiều rộng */
                height: 90px; /* Tăng chiều cao */
                font-size: 20px; /* Tăng kích thước chữ */
            }
        </style>
    </head>

    <body class="d-flex flex-column min-vh-100 bg-light">
        <!-- start header -->
        <nav class="navbar navbar-expand-lg navbar-light bg-primary shadow-sm">
            <div class="container-fluid">
                <a class="navbar-brand text-white" href="home">
                    <i class="fas fa-book"></i> BookStore
                </a>
                <form class="d-flex ms-auto" action="search" method="get">
                    <input class="form-control me-2" type="search" name="keyword" placeholder="Tìm kiếm sách..." aria-label="Search">
                    <select class="form-select me-2" name="sort">
                        <option value="">Sắp xếp</option>
                        <option value="price_asc">Giá tăng dần</option>
                        <option value="price_desc">Giá giảm dần</option>
                        <option value="title">Tên sách</option>
                    </select>
                    <button class="btn btn-outline-light" type="submit">Tìm</button>
                </form>
                <div class="ms-3">
                    <!-- Hiển thị tên người dùng nếu đã đăng nhập -->
                    <div class="dropdown">
                        <button class="btn btn-outline-light dropdown-toggle" type="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle"></i> ${sessionScope.user.username}
                        </button>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="profile">Profile</a></li>
                            <li><a class="dropdown-item" href="logout">Logout</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </nav>
        <!-- end header -->

        <!-- banner -->
        <div class="container-fluid mt-3 flex-grow-1">
            <div class="row">
                <main class="col-md-9 ms-sm-auto col-lg-12 px-md-4">
                    <div class="bg-gradient-purple text-white p-4 rounded mb-4 text-center shadow-sm">
                        <h3>Hi, Admin VanHy</h3>
                    </div>
                </main>
            </div>
        </div>

        <!-- Main content with centered buttons -->
        <div class="container d-flex justify-content-center align-items-center min-vh-100">
            <div class="btn-container">
                <a href="addbook"><button class="btn btn-primary btn-custom"><i class="fas fa-plus"></i> Add Book</button></a>
                <a href="viewbook"><button class="btn btn-success btn-custom"><i class="fas fa-eye"></i> View Books</button></a>
                <a href="deletebook"><button class="btn btn-danger btn-custom"><i class="fas fa-trash"></i> Delete Book</button></a>
                <a href="updatebook"><button class="btn btn-warning btn-custom"><i class="fas fa-edit"></i> Update Book</button></a>
                <a href="bookstatistic"><button class="btn btn-info btn-custom"><i class="fas fa-chart-bar"></i> Books Statistic</button></a>
            </div>
        </div>
    </body>
</html>
