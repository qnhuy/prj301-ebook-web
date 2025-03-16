/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.math.BigDecimal;
import java.sql.Statement;
import util.DatabaseUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import model.Cart;
import model.Order;
import model.Payment;

/**
 *
 * @author owner
 */
public class CheckoutDAO {

    private Connection connection;

    public CheckoutDAO() {
        try {
            connection = DatabaseUtil.getConnection();
        } catch (Exception e) {
        }
    }

    public int createOrder(List<Integer> cartIds, Order order, Payment payment) {
        int orderId = -1;
        CartDAO cartDAO = new CartDAO();

        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            // 2. Tạo đơn hàng (Orders)
            String orderQuery = "INSERT INTO Orders (user_id, order_date, total_price, status) VALUES (?, GETDATE(), ?, ?)";
            try (PreparedStatement orderStmt = connection.prepareStatement(orderQuery, Statement.RETURN_GENERATED_KEYS)) {
                orderStmt.setInt(1, order.getUserId());
                orderStmt.setBigDecimal(2, BigDecimal.valueOf(0));
                orderStmt.setString(3, order.getStatus());

                orderStmt.executeUpdate();

                ResultSet rs = orderStmt.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
            }

            // 3. Thêm chi tiết đơn hàng (OrderDetails)
            BigDecimal totalPrice = BigDecimal.valueOf(0);
            String orderDetailQuery = "INSERT INTO OrderDetails (order_id, book_id, quantity, price) VALUES (?, ?, ?, ?)";
            try (PreparedStatement orderDetailStmt = connection.prepareStatement(orderDetailQuery)) {
                for (int cartId : cartIds) {
                    Cart item = cartDAO.getCartById(cartId);
                    
                    BigDecimal itemPrice = item.getBook().getPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
                    totalPrice = totalPrice.add(itemPrice);

                    orderDetailStmt.setInt(1, orderId);
                    orderDetailStmt.setInt(2, item.getBook().getBookId());
                    orderDetailStmt.setInt(3, item.getQuantity());
                    orderDetailStmt.setBigDecimal(4, itemPrice);
                    orderDetailStmt.addBatch();
                }
                orderDetailStmt.executeBatch();
            }

            // 4. Cập nhật tổng giá trị đơn hàng
            String updateOrderQuery = "UPDATE Orders SET total_price = ? WHERE order_id = ?";
            try (PreparedStatement updateOrderStmt = connection.prepareStatement(updateOrderQuery)) {
                updateOrderStmt.setBigDecimal(1, totalPrice);
                updateOrderStmt.setInt(2, orderId);
                updateOrderStmt.executeUpdate();
            }

            // 5. Lưu thông tin thanh toán (Payments)
            String paymentQuery = "INSERT INTO Payments (order_id, payment_method, payment_date, status, fullname, phone, address, email) VALUES (?, ?, GETDATE(), ?, ?, ?, ?, ?)";
            try (PreparedStatement paymentStmt = connection.prepareStatement(paymentQuery)) {
                paymentStmt.setInt(1, orderId);
                paymentStmt.setString(2, payment.getPaymentMethod());
                paymentStmt.setString(3, payment.getStatus());
                paymentStmt.setString(4, payment.getFullname());
                paymentStmt.setString(5, payment.getPhone());
                paymentStmt.setString(6, payment.getAddress());
                paymentStmt.setString(7, payment.getEmail());
                
                paymentStmt.executeUpdate();
            }

            // 6. Xóa các mục trong giỏ hàng
            String deleteCartQuery = "DELETE FROM Cart WHERE cart_id = ?";
            try (PreparedStatement deleteCartStmt = connection.prepareStatement(deleteCartQuery)) {
                for (int cartId : cartIds) {
                    deleteCartStmt.setInt(1, cartId);
                    deleteCartStmt.addBatch();
                }
                deleteCartStmt.executeBatch();
            }

            connection.commit(); // Xác nhận transaction
        } catch (Exception e) {
            try {
                connection.rollback(); // Hoàn tác nếu có lỗi
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return orderId;
    }
}
