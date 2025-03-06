-- Tạo Database
CREATE DATABASE BookStore;
GO
USE BookStore;
GO

-- Bảng Users: Lưu thông tin người dùng (admin & customer)
CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) UNIQUE NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    password_hash NVARCHAR(255) NOT NULL,
    role NVARCHAR(20) DEFAULT 'customer' CHECK (role IN ('admin', 'customer'))
);

-- Bảng Authors: Lưu thông tin tác giả
CREATE TABLE Authors (
    author_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    bio NVARCHAR(MAX)
);

-- Bảng Publishers: Lưu thông tin nhà xuất bản
CREATE TABLE Publishers (
    publisher_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    address NVARCHAR(MAX)
);

-- Bảng Categories: Lưu thông tin thể loại sách
CREATE TABLE Categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name NVARCHAR(255) NOT NULL UNIQUE
);

-- Bảng Books: Lưu thông tin sách
CREATE TABLE Books (
    book_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(255) NOT NULL,
    author_id INT,
    category_id INT,
    publisher_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL,
    description NVARCHAR(MAX),
    cover_image NVARCHAR(255),
    status NVARCHAR(50) DEFAULT 'Available' CHECK (status IN ('Available', 'OutOfStock', 'Discontinued')),
    published_date DATE, 
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE,
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id) ON DELETE CASCADE
);

-- Bảng Orders: Lưu thông tin đơn hàng
CREATE TABLE Orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,  -- Người đặt hàng
    order_date DATETIME DEFAULT GETDATE(),
    total_price DECIMAL(10,2) NOT NULL,
    status NVARCHAR(50) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);

-- Bảng OrderDetails: Lưu chi tiết đơn hàng
CREATE TABLE OrderDetails (
    order_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    book_id INT,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- Bảng Cart: Lưu giỏ hàng của khách hàng
CREATE TABLE Cart (
    cart_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,  -- Người thêm vào giỏ
    book_id INT,
    quantity INT NOT NULL DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);

-- Bảng Payments: Lưu thông tin thanh toán
CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    payment_method NVARCHAR(50) NOT NULL CHECK (payment_method IN ('VNPAY', 'MOMO', 'Cash')),
    status NVARCHAR(50) DEFAULT 'Pending',
    payment_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);

-- Bảng Reviews: Lưu đánh giá sách
CREATE TABLE Reviews (
    review_id INT IDENTITY(1,1) PRIMARY KEY,
    book_id INT,
    user_id INT,
    rating INT CHECK (rating >= 1 AND rating <= 5),
    comment NVARCHAR(MAX),
    review_date DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
