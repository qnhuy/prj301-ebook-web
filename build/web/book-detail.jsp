<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <title>${book.title}</title>
        <link rel="stylesheet" href="css/style.css">
    </head>
    <body>
        <h2>${book.title}</h2>
        <img src="${book.coverImage}" alt="${book.title}">
        <p>Giá: ${book.price} VNĐ</p>
        <p>Mô tả: ${book.description}</p>

        <h3>Sách Tương Tự</h3>
        <div class="book-list">
            <c:forEach var="similar" items="${similarBooks}">
                <div class="book">
                    <img src="${similar.coverImage}" alt="${similar.title}">
                    <h3>${similar.title}</h3>
                    <p>Giá: ${similar.price} VNĐ</p>
                    <a href="book?id=${similar.bookId}">Chi tiết</a>
                </div>
            </c:forEach>
        </div>
    </body>
</html>