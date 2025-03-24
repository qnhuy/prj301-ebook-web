
-- Bảng Users: Lưu thông tin người dùng (admin & customer)
CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) UNIQUE NOT NULL,
    email NVARCHAR(100) UNIQUE NOT NULL,
    password_hash NVARCHAR(255) NOT NULL,
    role NVARCHAR(20) DEFAULT 'customer' CHECK (role IN ('admin', 'customer'))
);
drop table Users

-- Bảng Authors: Lưu thông tin tác giả
CREATE TABLE Authors (
    author_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    bio NVARCHAR(MAX)
);
drop table Authors

-- Bảng Publishers: Lưu thông tin nhà xuất bản
CREATE TABLE Publishers (
    publisher_id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    address NVARCHAR(MAX)
);
drop table Publishers

-- Bảng Categories: Lưu thông tin thể loại sách
CREATE TABLE Categories (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name NVARCHAR(255) NOT NULL UNIQUE
);
drop table Categories

-- Bảng CoverImages: Lưu đường dẫn ảnh cover
create table CoverImages (
	cover_id int not null primary key,
	cover_name nvarchar(255),
	cover_path nvarchar(max)
);
drop table CoverImages

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
    cover_path nvarchar(max),
    status NVARCHAR(50) DEFAULT 'Available' CHECK (status IN ('Available', 'OutOfStock', 'Discontinued')),
    published_date DATE, 
    FOREIGN KEY (author_id) REFERENCES Authors(author_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) ON DELETE CASCADE,
    FOREIGN KEY (publisher_id) REFERENCES Publishers(publisher_id) ON DELETE CASCADE,
    FOREIGN KEY (cover_id) REFERENCES CoverImages(cover_id) ON DELETE CASCADE
);
drop table Books
select * from Books

-- Bảng Orders: Lưu thông tin đơn hàng
CREATE TABLE Orders (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,  -- Người đặt hàng
    order_date DATETIME DEFAULT GETDATE(),
    total_price DECIMAL(10,2) NOT NULL,
    status NVARCHAR(50) DEFAULT 'Pending' CHECK (status IN ('Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled')),
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE
);
drop table Orders

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
drop table OrderDetails

-- Bảng Cart: Lưu giỏ hàng của khách hàng
CREATE TABLE Cart (
    cart_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,  -- Người thêm vào giỏ
    book_id INT,
    quantity INT NOT NULL DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES Users(user_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES Books(book_id) ON DELETE CASCADE
);
drop table Cart

-- Bảng Payments: Lưu thông tin thanh toán
CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT,
    payment_method NVARCHAR(50) NOT NULL CHECK (payment_method IN ('VNPAY', 'MOMO', 'Cash')),
    status NVARCHAR(50) DEFAULT 'Pending',
    payment_date DATETIME DEFAULT GETDATE(),
	fullname nvarchar(50),
	phone varchar(20),
	address nvarchar(50),
	email nvarchar(50);
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE
);
--add fullname, phone, address, email
drop table Payments
select * from Payments

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
drop table Reviews

﻿use BookStoreTest;
-- Thêm 5 Admin
INSERT INTO Users (username, email, password_hash, role)
VALUES 
(N'Huong', N'huong@gmail.com', N'123', N'admin'),
(N'Quang Huy', N'quanghuy@gmail.com', N'123', N'admin'),
(N'Van Huy', N'vanhuy@gmail.com', N'123', N'admin'),
(N'Minh Thu', N'minhthu@gmail.com', N'123', N'admin'),
(N'The Minh', N'theminh@gmail.com', N'123', N'admin');

-- Thêm 4 Customers
INSERT INTO Users (username, email, password_hash, role)
VALUES 
(N'MinhThuUser', N'minhthuuser@gmail.com', N'456', N'customer'),
(N'VanHuyUser', N'vanhuyuser@gmail.com', N'789', N'customer'),
(N'HuyNguyenUser', N'huynguyenuser@gmail.com', N'890', N'customer'),
(N'TheMinhUser', N'theminhuser@gmail.com', N'012', N'customer');

select * from Users

-- Thêm tác giả
INSERT INTO Authors (name, bio)
VALUES 
(N'Đặng Hoàng Giang', N'Nhà văn và nhà nghiên cứu nổi tiếng về tâm lý và xã hội'),
(N'Robin Sharma', N'Tác giả sách phát triển bản thân nổi tiếng'),
(N'Ryan Holiday', N'Chuyên gia về triết lý Stoic'),
(N'Marcus Aurelius', N'Hoàng đế La Mã và triết gia Stoic'),
(N'Eckhart Tolle', N'Nhà văn về tâm linh và triết học cuộc sống');

select * from Authors

-- Thêm nhà xuất bản
INSERT INTO Publishers (name, address)
VALUES 
(N'Nhà Xuất Bản Trẻ', N'12 Nguyễn Thị Minh Khai, TP.HCM'),
(N'NXB Kim Đồng', N'55 Quang Trung, Hà Nội'),
(N'NXB Thế Giới', N'45 Lý Thường Kiệt, Hà Nội');

-- Thêm thể loại sách
INSERT INTO Categories (category_name)
VALUES 
(N'Triết lý sống'),
(N'Selfhelp');

select * from Categories

-- Thêm đường dẫn ảnh bìa
insert into CoverImages (cover_id, cover_name, cover_path)
values
	(01, N'Đọc vị bất kỳ ai', 'doc-vi-bat-ky-ai.jpg'),
	(02, N'Bí mật của may mắn', 'bi-mat-cua-may-man.jpg'),
	(03, N'Nhà giả kim', 'nha-gia-kim.jpg'),
	(04, N'Đời ngắn đừng ngủ dài', 'doi-ngan-dung-ngu-dai.jpg'),
	(05, N'Tư duy như một nhà sư', 'tu-duy-nhu-mot-nha-su.jpg');

select * from CoverImages
drop table CoverImages


-- Thêm 15 cuốn sách về triết lý sống
INSERT INTO Books (title, author_id, category_id, publisher_id, price, stock_quantity, description, cover_path, status, published_date)
VALUES  
(N'Đọc vị bất kỳ ai', 1, 1, 1, 120000, 50, N'Cách thấu hiểu con người qua ngôn ngữ cơ thể', N'doc-vi-bat-ky-ai.jpg', N'Available', '2023-05-10'),
(N'Bí mật của may mắn', 2, 1, 2, 95000, 40, N'Câu chuyện về cách tạo ra may mắn trong cuộc sống', N'bi-mat-cua-may-man.jpg', N'Available', '2022-07-15'),
(N'Nhà giả kim', 2, 1, 1, 150000, 35, N'Tiểu thuyết huyền thoại về hành trình khám phá bản thân', N'nha-gia-kim.jpg', N'Available', '1995-10-20'),
(N'Đời ngắn đừng ngủ dài', 2, 1, 3, 130000, 30, N'Bài học ý nghĩa về cách sống trọn vẹn', N'doi-ngan-dung-ngu-dai.jpg', N'Available', '2018-03-12'),
(N'Tư duy như một nhà sư', 3, 2, 2, 170000, 25, N'Bài học từ triết lý nhà sư giúp con người sống an nhiên', N'tu-duy-nhu-mot-nha-su.jpg', N'Available', '2021-01-05');

select * from Books

insert into Books(title, )
