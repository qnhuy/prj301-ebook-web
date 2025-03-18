<%-- 
    Document   : cart
    Created on : Mar 8, 2025, 12:56:46 PM
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
            .cart-container {
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

            .cart-item {
                border-bottom: 1px solid #ddd;
            }

            .cart-item img {
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

            .cart-total {
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

            .empty-cart {
                text-align: center;
                font-size: 1.2rem;
            }

            .cart-bottom {
                display: flex;
                justify-content: space-between;
                align-items: center;
                gap: 10px;
                position: sticky;
                bottom: 0;
                background: white;
                padding: 10px;
            }

            #cartTable {
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

            #cartTable tr.cart-item:hover {
                background: rgba(0, 123, 255, 0.1);
                transition: background 0.3s ease-in-out;
            }

            #cartTable th, #cartTable td {
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

            #cartTable td.item-info {
                max-width: 200px; /* Giới hạn độ rộng của cột tên sản phẩm */
                overflow: hidden;
                text-overflow: ellipsis;
                white-space: nowrap;
            }

            #cartTable td.item-price {
                width: 100px; /* Giới hạn độ rộng của giá */
            }

            #cartTable td img {
                max-width: 80px;
                height: auto;
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
                            <li class="nav-item active">
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
                    <div class="cart-container">
                        <h1>Your Shopping Cart</h1>

                        <!-- Kiểm tra giỏ hàng trống -->
                        <c:if test="${empty cartList}">
                            <p class="empty-cart">Your cart is empty. <a href="/bookstore/home">Continue Shopping</a></p>
                        </c:if>

                        <!-- Hiển thị giỏ hàng -->
                        <c:if test="${not empty cartList}">
                            <table id="cartTable" style="width: 100%">
                                <tr class="cart-item">
                                    <th><input type="checkbox" id="select-all"></th>
                                    <th>Image</th>
                                    <th>Product</th>
                                    <th>Quantity</th>
                                    <th>Price</th>
                                    <th>Action</th>
                                </tr>
                                <c:forEach var="cart" items="${cartList}">
                                    <tr data-id="${cart.cartId}" class="cart-item">
                                        <td>
                                            <input type="checkbox" class="cart-checkbox" data-id="${cart.cartId}">
                                        </td>
                                        <td>
                                            <img src="https://via.placeholder.com/80" alt="${cart.book.title}">
                                        </td>
                                        <td class="item-info">
                                            <div class="item-title">${cart.book.title}</div>
                                            <div class="item-price"><fmt:formatNumber value="${cart.book.price}" type="number" groupingUsed="true"/> VNĐ</div>
                                        </td>
                                        <td>
                                            <form class="item-quantity" action="cart" method="POST">
                                                <input type="hidden" name="cartId" value="${cart.cartId}">
                                                <input type="hidden" name="bookId" value="${cart.book.bookId}">
                                                <input type="hidden" name="userId" value="${sessionScope.user.id}">
                                                <input type="hidden" name="action" value="updateQuantityInCart">

                                                <button type="submit" name="quantity" value="${cart.quantity - 1}" ${cart.quantity == 1 ? 'disabled' : ''}>-</button>

                                                <div class="form-control text-center" style="max-width: 150px" >${cart.quantity}</div>

                                                <button type="submit" name="quantity" value="${cart.quantity + 1}" ${cart.quantity == cart.book.stockQuantity ? 'disabled' : ''}>+</button>
                                            </form>
                                        </td>
                                        <td>
                                            <div class="item-price"><span id="sub-price"><fmt:formatNumber value="${cart.book.price * cart.quantity}" type="number" groupingUsed="true"/></span> VNĐ</div>
                                        </td>
                                        <td>
                                            <form action="cart" method="POST">
                                                <input type="hidden" name="cartId" value="${cart.cartId}">
                                                <input type="hidden" name="action" value="removeFromCart">
                                                <button type="submit" class="remove-btn">Remove</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </table>

                            <div class="cart-bottom">
                                <div class="cart-total">Total: <span id="sub-total">0</span> VNĐ</div>
                                <button class="checkout-btn">Proceed to Checkout</button>
                            </div>

                            <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
                                <div class="offcanvas-header">
                                    <h5 class="offcanvas-title" id="offcanvasExampleLabel">Checkout infomation</h5>
                                    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                                </div>
                                <div class="offcanvas-body">
                                    <div class="d-flex align-items-center" style="flex-direction: column; height: 100%">
                                        <div class="mb-2" style="width: 100%">
                                            <label class="form-label">Fullname <span class="text-danger">(*)</span></label>
                                            <input type="text" class="form-control" id="fullname" placeholder="Nhập họ và tên" required>
                                        </div>
                                        <div class="mb-2" style="width: 100%">
                                            <label class="form-label">Phone number <span class="text-danger">(*)</span></label>
                                            <input type="tel" class="form-control" id="phone" placeholder="Nhập số điện thoại" required>
                                        </div>
                                        <div class="mb-2" style="width: 100%">
                                            <label class="form-label">Address <span class="text-danger">(*)</span></label>
                                            <input type="text" class="form-control" id="address" placeholder="Nhập địa chỉ" required>
                                        </div>
                                        <div class="mb-2" style="width: 100%">
                                            <label class="form-label">Email <span class="text-danger">(*)</span></label>
                                            <input type="email" class="form-control" id="email" placeholder="Nhập email" required>
                                        </div>

                                        <div class="d-grid gap-2" style="margin-top: auto; width: 100%">
                                            <button id="pay-offline" value="cod" class="btn btn-primary">Cash on Delivery</button>
                                            <button id="pay-online" value="online" class="btn btn-danger">Online payment</button>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>
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

        <c:if test="${not empty sessionScope.cartMessage}">
            <div id="toast">
                ${sessionScope.cartMessage}
            </div> 
            <c:remove var="cartMessage" scope="session"/>

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

        <script type="text/javascript">
            $(document).ready(function () {

                $(".checkout-btn").on("click", function () {
                    let selectedIds = $(".cart-checkbox:checked").map(function () {
                        return $(this).data("id");
                    }).get();

                    if (selectedIds.length === 0) {
                        alert("Vui lòng chọn ít nhất một sản phẩm trước khi thanh toán!");

                    } else {
                        var offcanvas = new bootstrap.Offcanvas(document.getElementById('offcanvasExample'));
                        offcanvas.show();
                    }
                });

                function handleCheckout(type) {
                    let fullname = document.getElementById("fullname").value.trim();
                    let phone = document.getElementById("phone").value.trim();
                    let address = document.getElementById("address").value.trim();
                    let email = document.getElementById("email").value.trim();

                    if (!fullname || !phone || !address || !email) {
                        alert("Vui lòng điền đầy đủ thông tin!");
                        return false;
                    }

                    let selectedIds = $(".cart-checkbox:checked").map(function () {
                        return $(this).data("id");
                    }).get();

                    let totalPrice = $("#sub-total").text().replaceAll('.', '');

                    if (type === "off") {
                        $.ajax({
                            type: "POST",
                            url: "/bookstore/checkout",
                            contentType: "application/json",
                            data: JSON.stringify({
                                selectedIds: selectedIds,
                                paymentInfo: {
                                    totalPrice: totalPrice,
                                    fullname: fullname,
                                    phone: phone,
                                    address: address,
                                    email: email
                                }
                            }),
                            success: function (response) {
                                if (response === "true") {
                                    window.location.href = "/bookstore/orders";
                                }
                            }
                        });
                    } else if (type === "online") {
                        alert("Bạn chọn: Thanh toán online.");
                    }

                }

                $("#pay-offline").on("click", () => handleCheckout("off"));
                $("#pay-online").on("click", () => handleCheckout("online"));

                function updateTotal() {
                    let total = 0;
                    $(".cart-checkbox:checked").each(function () {
                        let row = $(this).closest("tr");
                        let subtotal = parseFloat(row.find("#sub-price").text().replace(/,/g, ''));
                        total += subtotal;
                    });
                    $("#sub-total").text(total.toLocaleString('vi-VN'));
                }

                // select all
                $("#select-all").on("change", function () {
                    $(".cart-checkbox").prop("checked", $(this).prop("checked"));
                    updateTotal();
                });

                // Khi một checkbox trong danh sách thay đổi
                $(".cart-checkbox").on("change", function () {
                    if ($(".cart-checkbox:not(#select-all):checked").length === $(".cart-checkbox:not(#select-all)").length) {
                        $("#select-all").prop("checked", true);
                    } else {
                        $("#select-all").prop("checked", false);
                    }

                    let selectedIds = $(".cart-checkbox:checked").map(function () {
                        return $(this).data("id");
                    }).get();

                    updateTotal();
                });

            });

        </script>
    </body>
</html>


