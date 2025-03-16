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
import model.Order;
import model.OrderDetails;
import model.Payment;
import util.DatabaseUtil;

/**
 *
 * @author owner
 */
public class OrderDAO {

    BookDAO bookDAO = new BookDAO();

    public List<Order> getAllOrderByUserId(int userId) throws SQLException {
        List<Order> orderList = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE user_id = ? order by order_date desc";

        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Order order = new Order();
                order.setOrderId(rs.getInt("order_id"));
                order.setUserId(rs.getInt("user_id"));
                order.setOrderDate(rs.getString("order_date").toString());
                order.setTotalPrice(rs.getBigDecimal("total_price"));
                order.setStatus(rs.getString("status"));
                orderList.add(order);
            }
        }
        return orderList;
    }

    public List<OrderDetails> getAllOrderDetailsByUserId(int userId, String orderId) throws SQLException {
        String sql = "SELECT OrderDetails.order_detail_id, OrderDetails.order_id, Orders.user_id, OrderDetails.book_id, OrderDetails.quantity, OrderDetails.price\n"
                + "FROM OrderDetails INNER JOIN Orders \n"
                + "ON OrderDetails.order_id = Orders.order_id\n"
                + "where OrderDetails.order_id = ? and Orders.user_id = ?";
        List<OrderDetails> orderDetailsList = new ArrayList<>();

        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, orderId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                OrderDetails d = new OrderDetails(
                        rs.getInt("order_detail_id"),
                        rs.getInt("order_id"),
                        bookDAO.getBookById(rs.getInt("book_id")),
                        rs.getInt("quantity"),
                        rs.getBigDecimal("price")
                );

                orderDetailsList.add(d);
            }
        }

        return orderDetailsList;
    }

    public Payment getPaymentByOrderAndUserId(int userId, String orderId) throws SQLException {
        String sql = "SELECT Payments.payment_id, Payments.order_id, Orders.user_id, Payments.payment_method, Payments.payment_date, Payments.status, Payments.fullname, Payments.phone, Payments.address, Payments.email\n"
                + "FROM  Orders INNER JOIN Payments \n"
                + "ON Orders.order_id = Payments.order_id\n"
                + "where Payments.order_id = ? and Orders.user_id = ?";

        try (Connection conn = DatabaseUtil.getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, orderId);
            ps.setInt(2, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Payment(
                        rs.getInt("payment_id"),
                        rs.getInt("order_id"),
                        rs.getString("payment_method"),
                        rs.getString("payment_date"),
                        rs.getString("status"),
                        rs.getString("fullname"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getString("email")
                );
            }
        }
        return null;
    }
}
