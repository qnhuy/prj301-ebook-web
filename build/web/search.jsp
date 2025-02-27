<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Kết Quả Tìm Kiếm</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <h2>Kết quả tìm kiếm cho "${keyword}"</h2>
        <div class="book-list">
            <c:forEach var="book" items="${searchResults}">
                <div class="book">
                    <img src="${book.coverImage}" alt="${book.title}">
                    <h3>${book.title}</h3>
                    <p>Giá: ${book.price} VNĐ</p>
                    <a href="book?id=${book.bookId}">Chi tiết</a>
                </div>
            </c:forEach>
        </div>

        <!-- Phân trang -->
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="search?keyword=${keyword}&sort=${param.sort}&page=${currentPage - 1}">Trang trước</a>
            </c:if>
            <span>Trang ${currentPage}</span>
            <a href="search?keyword=${keyword}&sort=${param.sort}&page=${currentPage + 1}">Trang sau</a>
        </div>
    </body>
</html>