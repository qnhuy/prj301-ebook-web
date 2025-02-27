package dao;

import model.Book;
import util.DatabaseUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookDAO {

    // Lấy sách nổi bật (dựa trên stock_quantity, ví dụ: còn hàng nhiều nhất)
    public List<Book> getFeaturedBooks(int limit) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Books WHERE status = 'Available' ORDER BY stock_quantity DESC";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    // Lấy sách mới (dựa trên published_date)
    public List<Book> getNewBooks(int limit) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Books WHERE status = 'Available' ORDER BY published_date DESC";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    // Lấy sách bán chạy (dựa trên OrderDetails)
    public List<Book> getBestSellingBooks(int limit) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT TOP (?) b.*, SUM(od.quantity) as total_sold " +
                     "FROM Books b " +
                     "JOIN OrderDetails od ON b.book_id = od.book_id " +
                     "GROUP BY b.book_id, b.title, b.author_id, b.category_id, b.publisher_id, " +
                     "b.price, b.stock_quantity, b.description, b.cover_image, b.status, b.published_date " +
                     "ORDER BY total_sold DESC";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    // Tìm kiếm sách với phân trang
    public List<Book> searchBooks(String keyword, String sort, int page, int pageSize) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM Books WHERE (title LIKE ? OR description LIKE ?) AND status = 'Available'";
        if ("price_asc".equals(sort)) sql += " ORDER BY price ASC";
        else if ("price_desc".equals(sort)) sql += " ORDER BY price DESC";
        else if ("title".equals(sort)) sql += " ORDER BY title ASC";
        else sql += " ORDER BY book_id ASC";
        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        int offset = (page - 1) * pageSize;
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            stmt.setString(2, "%" + keyword + "%");
            stmt.setInt(3, offset);
            stmt.setInt(4, pageSize);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    // Lấy chi tiết sách theo ID
    public Book getBookById(int bookId) {
        String sql = "SELECT * FROM Books WHERE book_id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, bookId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapResultSetToBook(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Lấy sách tương tự (cùng category_id)
    public List<Book> getSimilarBooks(int bookId, int categoryId, int limit) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT TOP (?) * FROM Books WHERE category_id = ? AND book_id != ? AND status = 'Available'";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, categoryId);
            stmt.setInt(3, bookId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                books.add(mapResultSetToBook(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    // Ánh xạ ResultSet sang Book
    private Book mapResultSetToBook(ResultSet rs) throws SQLException {
        return new Book(
            rs.getInt("book_id"),
            rs.getString("title"),
            rs.getInt("author_id"),
            rs.getInt("category_id"),
            rs.getInt("publisher_id"),
            rs.getBigDecimal("price"),
            rs.getInt("stock_quantity"),
            rs.getString("description"),
            rs.getString("cover_image"),
            rs.getString("status"),
            rs.getDate("published_date")
        );
    }
}