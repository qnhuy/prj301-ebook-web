/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import dao.BookDAO;
import dao.CartDAO;
import dao.OrderDAO;
import jakarta.servlet.RequestDispatcher;
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
import model.Cart;
import model.Order;
import model.OrderDetails;
import model.Payment;

/**
 *
 * @author owner
 */
@WebServlet(name = "OrdersServlet", urlPatterns = {"/orders"})
public class OrdersServlet extends HttpServlet {

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
            out.println("<title>Servlet Orders</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Orders at " + request.getContextPath() + "</h1>");
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
        try {
            HttpSession session = request.getSession();
            OrderDAO orderDAO = new OrderDAO();

//        User user = (User) session.getAttribute("user");
//        if (user == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
            String orderIdStr = request.getParameter("orderId");
            Boolean isOrderList = false;

            if (orderIdStr != null) {
                List<OrderDetails> orderDetailsList = orderDAO.getAllOrderDetailsByUserId(1, orderIdStr);
                Payment paymentInfo = orderDAO.getPaymentByOrderAndUserId(1, orderIdStr);

                if (orderDetailsList.isEmpty() || paymentInfo == null) {
                    isOrderList = true;
                    session.setAttribute("orderMessage", "Order details ID not exist!");

                } else {
                    BigDecimal totalPrice = BigDecimal.valueOf(0);
                    
                    for (OrderDetails item : orderDetailsList) {
                        totalPrice = totalPrice.add(item.getPrice());
                    }

                    request.setAttribute("orderDetailsList", orderDetailsList);
                    request.setAttribute("paymentInfo", paymentInfo);
                    request.setAttribute("totalPrice", totalPrice);
                }
            } else {
                isOrderList = true;
            }

            if (isOrderList) {
                List<Order> orderList = orderDAO.getAllOrderByUserId(1);
                request.setAttribute("orderList", orderList);
            }

            request.setAttribute("isOrderList", isOrderList);

            RequestDispatcher dispatcher = request.getRequestDispatcher("orders.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
        }
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
        processRequest(request, response);
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
