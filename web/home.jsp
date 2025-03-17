<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Trang Chủ - BookStore</title>
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- CSS tùy chỉnh -->
        <link rel="stylesheet" href="css/style.css">
        <!-- Font Awesome for icons -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    </head>
    <body class="d-flex flex-column min-vh-100 bg-light">
        <!-- Header -->
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
                    <i class="fas fa-user-circle text-white fs-3"></i>
                </div>
            </div>
        </nav>

        <!-- Sidebar và Nội dung chính -->
        <div class="container-fluid mt-3 flex-grow-1">
            <div class="row">
                <!-- Sidebar -->
                <nav class="col-md-3 col-lg-2 d-md-block bg-white sidebar shadow">
                    <div class="position-sticky pt-3">
                        <ul class="nav flex-column">
                            <!-- Mục cho người dùng chung -->
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="home">
                                    <i class="fas fa-home me-2"></i> Home
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="search">
                                    <i class="fas fa-search me-2"></i> Search Books
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="cart">
                                    <i class="fas fa-shopping-cart me-2"></i> Cart
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="orders">
                                    <i class="fas fa-box-open me-2"></i> Orders
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-dark" href="profile">
                                    <i class="fas fa-user me-2"></i> Profile
                                </a>
                            </li>

                            <!-- Mục cho Admin (ẩn/hiện dựa trên role) -->
                            <c:if test="${sessionScope.user.role == 'admin'}">
                                <li class="nav-item mt-3">
                                    <a class="nav-link text-dark" href="admin/products">
                                        <i class="fas fa-cogs me-2"></i> Manage Products
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-dark" href="statistics">
                                        <i class="fas fa-chart-bar me-2"></i> Statistics
                                    </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link text-dark" href="upload">
                                        <i class="fas fa-upload me-2"></i> Upload Image
                                    </a>
                                </li>
                            </c:if>

                            <!-- Nút nâng cao -->
                            <li class="nav-item mt-3">
                                <button class="btn btn-primary w-100">Settings <i class="fas fa-arrow-right"></i></button>
                            </li>
                        </ul>
                    </div>
                </nav>

                <!-- Nội dung chính -->
                <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
                    <!-- Banner (tạm thời) -->
                    <div class="bg-gradient-purple text-white p-4 rounded mb-4 text-center shadow-sm">
                        <h3>Hi, VanHy</h3>
                        <p>Mua sách của bọn tao ngay đi</p>
                    </div>

                    <!-- Sản phẩm nổi bật -->
                    <h2 class="text-primary">Popular</h2>
                    <div class="row row-cols-1 row-cols-md-3 g-4 mb-4">
                        <c:forEach var="book" items="${featuredBooks}">
                            <div class="col">
                                <div class="card book-card h-100 shadow-sm border-0">
                                    <img src="${pageContext.request.contextPath}/coverimg/${book.coverPath}" class="card-img-top" alt="${book.title}" style="height: 200px; object-fit: cover;">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">${book.title}</h5>
                                        <p class="card-text text-danger fw-bold">Giá: ${book.price} VNĐ</p>
                                        <a href="bookdetail?id=${book.bookId}" class="btn btn-success">Chi tiết</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Sản phẩm mới -->
                    <h2 class="text-primary">Ongoing</h2>
                    <div class="row row-cols-1 row-cols-md-3 g-4 mb-4">
                        <c:forEach var="book" items="${newBooks}">
                            <div class="col">
                                <div class="card book-card h-100 shadow-sm border-0">
                                    <img src="${book.coverImage}" class="card-img-top" alt="${book.title}" style="height: 200px; object-fit: cover;">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">${book.title}</h5>
                                        <p class="card-text text-danger fw-bold">Giá: ${book.price} VNĐ</p>
                                        <a href="bookdetail?id=${book.bookId}" class="btn btn-success">Chi tiết</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <!-- Sản phẩm bán chạy -->
                    <h2 class="text-primary">Best Sales</h2>
                    <div class="row row-cols-1 row-cols-md-3 g-4 mb-4">
                        <c:forEach var="book" items="${bestSellingBooks}">
                            <div class="col">
                                <div class="card book-card h-100 shadow-sm border-0">
                                    <img src="${book.coverImage}" class="card-img-top" alt="${book.title}" style="height: 200px; object-fit: cover;">
                                    <div class="card-body text-center">
                                        <h5 class="card-title">${book.title}</h5>
                                        <p class="card-text text-danger fw-bold">Giá: ${book.price} VNĐ</p>
                                        <a href="bookdetail?id=${book.bookId}" class="btn btn-success">Chi tiết</a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </main>
            </div>
        </div>

        <!-- Footer -->
        <footer class="bg-primary text-white text-center py-3 mt-auto">
            <p>© 2025 BookStore - All Rights Reserved</p>
        </footer>

        <!-- Bootstrap JS và dependencies -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script>
    </body>
</html>