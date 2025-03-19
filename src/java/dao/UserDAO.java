/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

package dao;


import java.util.*;
import java.lang.*;
import java.io.*;
import model.User;
import util.DatabaseUtil;
import java.sql.*;

/**
 *
 * @author Minh Thu
 */
public class UserDAO {
    public User getUserByUsername(String username) {
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT * FROM Users WHERE username=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new User(
                    rs.getInt("user_id"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password_hash"),
                    rs.getString("role")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public static void main(String[] args) {
        UserDAO dao = new UserDAO();
        System.out.println(dao.registerUser("jjjj", "nhhh@gmail.com", "abc", "customer"));
    }

    public boolean registerUser(String username, String email, String password, String role) {
    try (Connection conn = DatabaseUtil.getConnection()) {
        String sql = "INSERT INTO Users (username, email, password_hash, role) VALUES (?, ?, ?, ?)";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, username);
        ps.setString(2, email);
        ps.setString(3, password);
        ps.setString(4, role);
        
        

        int rowsAffected = ps.executeUpdate();
        conn.commit();  // ✅ Đảm bảo dữ liệu được lưu vào database
        return rowsAffected > 0;
    } catch (Exception e) {
        e.printStackTrace();
    }
    return false;
}

    public boolean changePassword(String username, String newPasswordHash) {
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "UPDATE Users SET password_hash=? WHERE username=?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, newPasswordHash);
            stmt.setString(2, username);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
