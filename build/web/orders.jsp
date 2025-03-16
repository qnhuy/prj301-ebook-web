<%-- 
    Document   : orders
    Created on : Mar 16, 2025, 9:31:40 AM
    Author     : owner
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Cart Page</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <style>
            .orders-container {
                margin: auto;
                background: #ffffff;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
                border-radius: 16px;
                padding: 20px;
                margin-bottom: 50px;
            }

            h1 {
                text-align: center;
                font-size: 26px;
                line-height: normal;
                margin-bottom: 20px;
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                opacity: 0.9;
                background-image: linear-gradient(to right, #e317ae, #ff266d, #ff7525, #f1b600, #a8eb12);
            }

            .order-item {
                border-bottom: 1px solid #ddd;
            }

            .order-item img {
                width: 80px;
                height: 80px;
                border-radius: 12px;
                object-fit: cover;
            }

            .item-info {
                flex: 1;
                margin-left: 20px;
            }

            .item-title {
                font-weight: bold;
                margin-bottom: 5px;
            }

            .item-price {
                color: #16a085;
                font-size: 1.1rem;
            }

            .item-quantity {
                display: flex;
                align-items: center;
                justify-content: space-between;
                padding: 0 15px;
            }

            .item-quantity button {
                padding: 5px 10px;
                margin: 0 5px;
                border: none;
                border-radius: 8px;
                background: #16a085;
                color: white;
                cursor: pointer;
                transition: background 0.3s;
            }

            .item-quantity button:hover {
                background: #12876f;
            }

            .item-quantity input {
                width: 50px;
                padding: 5px;
                text-align: center;
                border: 1px solid #aaa;
                border-radius: 8px;
            }

            .remove-btn {
                background: #e74c3c;
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 8px;
                cursor: pointer;
                transition: background 0.3s;
            }

            .remove-btn:hover {
                background: #c0392b;
            }

            .order-total {
                text-align: right;
                margin-top: 20px;
                font-size: 1.5rem;
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                opacity: 0.9;
                background-image: linear-gradient(to right, #e81a19, #cd7600, #a3a900, #6fce63, #12ebbe);
            }

            .checkout-btn {
                display: block;
                text-align: center;
                background: #3498db;
                color: white;
                padding: 15px;
                font-size: 1.2rem;
                border-radius: 12px;
                margin-top: 20px;
                text-decoration: none;
                transition: background 0.3s;
                border: 0;
            }

            .checkout-btn:hover {
                background: #2980b9;
            }

            .empty-order {
                text-align: center;
                font-size: 1.2rem;
            }

            .order-bottom {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 10px;
                position: sticky;
                bottom: 0;
                background: white;
                padding: 10px;
            }

            #orderTable {
                width: 100%;
                border-collapse: collapse;
                background: #f9f9f9;
                border-radius: 8px;
                overflow: hidden;

                th {
                    background: #007bff;
                    color: white;
                    font-weight: bold;
                }
                td {
                    padding: 10px;
                }

                img {
                    max-width: 80px;
                    height: auto;
                }
            }

            #orderTable th, #orderTable td {
                text-align: center;
                padding: 10px;
                vertical-align: middle;
                overflow: hidden; /* Ẩn nội dung tràn */
                text-overflow: ellipsis; /* Hiển thị dấu "..." nếu nội dung quá dài */
                white-space: nowrap; /* Không cho phép xuống dòng */
                padding: 12px 16px;
                border-bottom: 1px solid #ddd;
                text-align: center;
            }

            #orderTable td.item-info {
                max-width: 200px; /* Giới hạn độ rộng của cột tên sản phẩm */
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            #orderTable td.item-price {
                width: 100px; /* Giới hạn độ rộng của giá */
            }

            #orderTable td img {
                max-width: 80px;
                height: auto;
            }
            #orderTable tr.order-item:hover {
                background: rgba(0, 123, 255, 0.1);
                transition: background 0.3s ease-in-out;
            }


            .details-container {
                display: flex;
                flex-wrap: wrap;
                gap: 20px;
                justify-content: space-between;
            }

            #detailsTable {
                width: 100%;
                border-collapse: collapse;
                background: #f9f9f9;
                border-radius: 8px;
                overflow: hidden;
            }

            #detailsTable tr.details-item:hover {
                background: rgba(0, 123, 255, 0.1);
                transition: background 0.3s ease-in-out;
            }

            #detailsTable th, #detailsTable td {
                padding: 12px 16px;
                border-bottom: 1px solid #ddd;
                text-align: center;
            }

            #detailsTable th {
                background: #007bff;
                color: white;
                font-weight: bold;
            }

            .details-item img {
                width: 80px;
                height: auto;
                border-radius: 6px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .details-item-title {
                font-size: 16px;
                font-weight: bold;
                color: #333;
            }

            .details-item-price {
                font-size: 14px;
                color: #ff5722;
                font-weight: bold;
            }

            .text-center {
                text-align: center;
            }

            .details-container .d-flex {
                background: #f9f9f9;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                width: 100%;
                max-width: 400px;
            }

            .details-container .d-flex label {
                font-weight: bold;
                color: #333;
                margin-bottom: 5px;
            }

            .details-container .d-flex div {
                padding: 10px;
                background: #fff;
                border-radius: 6px;
                border: 1px solid #ddd;
            }

            /* Payment Section */
            .payment-info {
                background: #f9f9f9;
                padding: 15px;
                border-radius: 8px;
                margin-bottom: 20px;
            }

            /* === Payment Groups === */
            .payment-group {
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
                gap: 15px;
                margin-bottom: 10px;
                padding: 10px;
                background: #ffffff;
                border-radius: 5px;
                box-shadow: 0px 2px 5px rgba(0, 0, 0, 0.1);
            }

            .payment-item {
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            /* === Thêm màu cho tiêu đề (label) === */
            .field-title {
                font-weight: 500;
                color: mediumseagreen;
                text-transform: uppercase;
                display: block;
                margin-bottom: 5px;
            }

            /* === Payment Status Color === */
            .payment-status {
                padding: 5px 10px;
                border-radius: 4px;
            }

            .payment-status:contains("Completed") {
                background: #28a745;
            }

            .payment-status:contains("Pending") {
                background: #ffc107;
                color: #333;
            }

            .payment-status:contains("Failed") {
                background: #dc3545;
            }
        </style>
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
                            <li class="nav-item active">
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
                    <div class="orders-container">
                        <c:choose>
                            <c:when test="${isOrderList}">
                                <h1>Your Orders</h1>

                                <!-- Kiểm tra giỏ hàng trống -->
                                <c:if test="${empty orderList}">
                                    <p class="empty-order">Your order is empty. <a href="/bookstore/home">Continue Shopping</a></p>
                                </c:if>

                                <c:if test="${not empty orderList}">
                                    <table id="orderTable" style="width: 100%">
                                        <tr class="order-item">
                                            <th>Order ID</th>
                                            <th>Order Date</th>
                                            <th>Total Price</th>
                                            <th>Order Status</th>
                                            <th>Action</th>
                                        </tr>
                                        <c:forEach var="order" items="${orderList}">
                                            <tr class="order-item">
                                                <td class="item-info">
                                                    <div class="item-title">${order.orderId}</div>
                                                </td>
                                                <td>
                                                    <div class="">${order.orderDate}</div>
                                                </td>
                                                <td>
                                                    <div class="item-price"><span id="sub-price"><fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true"/></span> VNĐ</div>
                                                </td>
                                                <td>
                                                    <div class="">${order.status}</div>
                                                </td>
                                                <td>
                                                    <button type="submit" class="remove-btn">
                                                        <a style="color: white" href="/bookstore/orders?orderId=${order.orderId}">View details</a>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </c:if>
                            </c:when>
                            <c:otherwise>
                                <h1>Your Order Details</h1>

                                <div class="details-container row d-flex">
                                    <div class="payment-info">
                                        <!-- Group 1: Payment Method, Date, Status -->
                                        <div class="payment-group">
                                            <div class="payment-item">
                                                <label class="field-title">Payment Method</label>
                                                <div>${paymentInfo.paymentMethod}</div>
                                            </div>
                                            <div class="payment-item">
                                                <label class="field-title">Payment Date</label>
                                                <div>${paymentInfo.paymentDate}</div>
                                            </div>
                                            <div class="payment-item">
                                                <label class="field-title">Payment Status</label>
                                                <div class="payment-status">${paymentInfo.status}</div>
                                            </div>
                                        </div>

                                        <!-- Group 2: Personal Information -->
                                        <div class="payment-group">
                                            <div class="payment-item">
                                                <label class="field-title">Full Name</label>
                                                <div>${paymentInfo.fullname}</div>
                                            </div>
                                            <div class="payment-item">
                                                <label class="field-title">Phone Number</label>
                                                <div>${paymentInfo.phone}</div>
                                            </div>
                                            <div class="payment-item">
                                                <label class="field-title">Address</label>
                                                <div>${paymentInfo.address}</div>
                                            </div>
                                            <div class="payment-item">
                                                <label class="field-title">Email</label>
                                                <div>${paymentInfo.email}</div>
                                            </div>
                                        </div>
                                    </div>

                                    <div>
                                        <table id="detailsTable" style="width: 100%">
                                            <tr class="details-item">
                                                <th>Order Details ID</th>
                                                <th>Image</th>
                                                <th>Product</th>
                                                <th>Quantity</th>
                                                <th>Total Price</th>
                                            </tr>
                                            <c:forEach var="orderDetails" items="${orderDetailsList}">
                                                <tr class="details-item">
                                                    <td>
                                                        <div>${orderDetails.orderDetailsId}</div>
                                                    </td>
                                                    <td>
                                                        <img src="https://via.placeholder.com/80" alt="${orderDetails.book.title}">
                                                    </td>
                                                    <td class="details-item-info">
                                                        <div class="details-item-title">${orderDetails.book.title}</div>
                                                        <div class="details-item-price"><fmt:formatNumber value="${orderDetails.book.price}" type="number" groupingUsed="true"/> VNĐ</div>
                                                    </td>
                                                    <td>
                                                        <div class="text-center" style="max-width: 150px" >${orderDetails.quantity}</div>
                                                    </td>
                                                    <td>
                                                        <div class="details-item-price"><span id="sub-price"><fmt:formatNumber value="${orderDetails.price}" type="number" groupingUsed="true"/></span> VNĐ</div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <tr class="details-item">
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td class="details-item-info">
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    <div class="details-item-price" style="font-size: 21px">Total: <span id="details-sub-price"><fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true"/></span> VNĐ</div>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>


                                </div>
                            </c:otherwise>
                        </c:choose>



                </main>
            </div>
        </div>

        <!-- Footer -->
        <footer class="bg-primary text-white text-center py-3 mt-auto">
            <p>© 2025 BookStore - All Rights Reserved</p>
        </footer>

        <!-- Bootstrap JS và dependencies -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"></script> 

        <c:if test="${not empty sessionScope.orderMessage}">
            <div id="toast">
                ${sessionScope.orderMessage}
            </div> 
            <c:remove var="orderMessage" scope="session"/>

            <script type="text/javascript">
                showToast();
                function showToast()
                {
                    const textM = $('#toast').text();
                    if (textM) {
                        $('#toast').addClass("display");

                        setTimeout(() => {
                            $("#toast").removeClass("display");
                            $('#toast').html("");
                        }, 3000);
                    }
                }
            </script> 
        </c:if>
    </body>
</html>



