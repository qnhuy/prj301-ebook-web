/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Cart;
import util.DatabaseUtil;

/**
 *
 * @author owner
 */
public class CartDAO {

    BookDAO bookDAO = new BookDAO();

    public boolean addToCart(Cart c) {
        Boolean isSuccess = false;

        String sql = "INSERT INTO [dbo].[Cart]\n"
                + "           ([user_id]\n"
                + "           ,[book_id]\n"
                + "           ,[quantity])\n"
                + "     VALUES\n"
                + "           (?,?,?)";

        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, c.getUserId());
            stmt.setInt(2, c.getBook().getBookId());
            stmt.setInt(3, c.getQuantity());

            int i = stmt.executeUpdate();
            if (i == 1) {
                isSuccess = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return isSuccess;
    }

    // Kiểm tra sản phẩm có trong giỏ hàng hay không
    public Cart getCartByUserAndBook(int userId, int bookId) throws SQLException {
        String sql = "SELECT * FROM Cart WHERE user_id = ? AND book_id = ?";

        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, bookId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Cart(
                        rs.getInt("cart_id"),
                        rs.getInt("user_id"),
                        bookDAO.getBookById(rs.getInt("book_id")),
                        rs.getInt("quantity")
                );
            }
        }
        return null;
    }
    
    
    public Cart getCartById(int cartId) throws SQLException {
        String sql = "SELECT * FROM Cart WHERE cart_id = ?";

        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return new Cart(
                        rs.getInt("cart_id"),
                        rs.getInt("user_id"),
                        bookDAO.getBookById(rs.getInt("book_id")),
                        rs.getInt("quantity")
                );
            }
        }
        return null;
    }

// Cập nhật số lượng sản phẩm trong giỏ hàng
    public boolean updateCart(Cart cart) throws SQLException {
        String sql = "UPDATE Cart SET quantity = ? WHERE cart_id = ?";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cart.getQuantity());
            ps.setInt(2, cart.getCartId());
            return ps.executeUpdate() > 0;
        }
    }

    public List<Cart> getAllCartByUserId(int userId) throws SQLException {
        List<Cart> cartList = new ArrayList<>();
        String sql = "SELECT * FROM Cart WHERE user_id = ?";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Cart cart = new Cart();
                cart.setCartId(rs.getInt("cart_id"));
                cart.setUserId(rs.getInt("user_id"));
                cart.setQuantity(rs.getInt("quantity"));
                cart.setBook(bookDAO.getBookById(rs.getInt("book_id")));
                cartList.add(cart);
            }
        }
        return cartList;
    }

    public boolean removeFromCart(int cartId) throws SQLException {
        String sql = "DELETE FROM Cart WHERE cart_id = ?";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            return ps.executeUpdate() > 0;
        }
    }

    public Boolean existsCartById(int cartId) {
        Boolean isExist = false;

        String sql = "SELECT * FROM Cart WHERE cart_id = ?";
        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                isExist = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isExist; // Không tìm thấy book
    }

}
