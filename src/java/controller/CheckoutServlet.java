/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import dao.CheckoutDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import model.Order;
import model.Payment;

/**
 *
 * @author owner
 */
class CheckoutData {

    String[] selectedIds;
    PaymentInfo paymentInfo;

    class PaymentInfo {

        String fullname;
        String phone;
        String address;
        String email;
    }
}

@WebServlet(name = "CheckoutServlet", urlPatterns = {"/checkout"})
public class CheckoutServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Checkout</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Checkout at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {

            HttpSession session = request.getSession();
            CheckoutDAO checkoutDAO = new CheckoutDAO();

//            User user = (User) session.getAttribute("user");
//            if (user == null) {
//                response.sendRedirect("login.jsp");
//                return;
//            }
            BufferedReader reader = request.getReader();
            Gson gson = new Gson();
            JsonObject jsonObject = gson.fromJson(reader, JsonObject.class);

            // Lấy danh sách Cart ID
            JsonArray selectedIdsJson = jsonObject.getAsJsonArray("selectedIds");
            List<Integer> selectedCartIds = new ArrayList<>();
            for (JsonElement element : selectedIdsJson) {
                selectedCartIds.add(element.getAsInt());
            }

            // Lấy thông tin thanh toán
            JsonObject paymentInfoJson = jsonObject.getAsJsonObject("paymentInfo");
            BigDecimal totalPrice = paymentInfoJson.get("totalPrice").getAsBigDecimal();
            String fullname = paymentInfoJson.get("fullname").getAsString();
            String phone = paymentInfoJson.get("phone").getAsString();
            String address = paymentInfoJson.get("address").getAsString();
            String email = paymentInfoJson.get("email").getAsString();

//            // Gọi DAO để tạo đơn hàng
            Order order = new Order();
            order.setUserId(1);
            order.setTotalPrice(totalPrice);
            order.setStatus("Processing");

            Payment payment = new Payment();
            payment.setPaymentMethod("Cash");
            payment.setStatus("Sucessfull");
            payment.setFullname(fullname);
            payment.setPhone(phone);
            payment.setAddress(address);
            payment.setEmail(email);

            int orderId = checkoutDAO.createOrder(selectedCartIds, order, payment);

            if (orderId > 0) {
                session.setAttribute("orderMessage", "Checkout successfully!");
                response.getWriter().write("true");
            } else {
                session.setAttribute("orderMessage", "Something wrong on server.");
                response.getWriter().write("false");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
