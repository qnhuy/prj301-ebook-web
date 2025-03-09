/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import dao.BookDAO;
import dao.CartDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.util.List;
import model.Book;
import model.Cart;

/**
 *
 * @author owner
 */
@WebServlet(urlPatterns = {"/cart"})
public class CartServlet extends HttpServlet {

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
            out.println("<title>Servlet CartServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet CartServlet at " + request.getContextPath() + "</h1>");
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
            CartDAO cartDAO = new CartDAO();

//        User user = (User) session.getAttribute("user");
//        if (user == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }
            List<Cart> cartList = cartDAO.getAllCartByUserId(1); // user.getId()

            // Tính tổng giá trị giỏ hàng
            BigDecimal totalPrice = cartList.stream()
                    .map(cart -> cart.getBook().getPrice().multiply(BigDecimal.valueOf(cart.getQuantity())))
                    .reduce(BigDecimal.ZERO, BigDecimal::add);

            // Gửi dữ liệu đến JSP
            request.setAttribute("cartList", cartList);
            request.setAttribute("totalPrice", totalPrice);

            // Chuyển hướng đến cart.jsp
            RequestDispatcher dispatcher = request.getRequestDispatcher("cart.jsp");
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
        try {
            HttpSession session = request.getSession();
            BookDAO bookDAO = new BookDAO();
            CartDAO cartDAO = new CartDAO();

//            User user = (User) session.getAttribute("user");
//            if (user == null) {
//                response.sendRedirect("login.jsp");
//                return;
//            }
            String cartIdStr = request.getParameter("cartId");
            String bookIdStr = request.getParameter("bookId");
            String userIdStr = request.getParameter("userId");
            String quantityStr = request.getParameter("quantity");
            String action = request.getParameter("action");

            String cartMessage = "Something wrong on server.";

            // create new cart
            if (action.equals("addToCart") && bookIdStr != null && userIdStr != null && quantityStr != null) {
                int bookId = Integer.parseInt(bookIdStr);
                int userId = 1; // int userId = Integer.parseInt(userIdStr);
                int quantity = Integer.parseInt(quantityStr);

                // need check later: exist User
                if (bookDAO.existsBookById(bookId)) {
                    Book book = bookDAO.getBookById(bookId);
                    Cart existingCart = cartDAO.getCartByUserAndBook(userId, bookId);

                    if (existingCart != null) {
                        int newQuantity = existingCart.getQuantity() + quantity;

                        // Kiểm tra giới hạn stock
                        if (quantity < 1) {
                            cartMessage = "Cannot add quantity less than 1.";
                        } else if (newQuantity > book.getStockQuantity()) {
                            cartMessage = "Cannot add more than available stock.";
                        } else {
                            existingCart.setQuantity(newQuantity);
                            Boolean updateCart = cartDAO.updateCart(existingCart);

                            if (updateCart) {
                                cartMessage = "Update book quantity in cart successfully!";
                            } else {
                                cartMessage = "Something wrong when Update book quantity in cart.";
                            }
                        }

                    } else {
                        // Nếu sản phẩm chưa có trong giỏ hàng
                        if (quantity < 1) {
                            cartMessage = "Cannot add quantity less than 1.";
                        } else if (quantity > book.getStockQuantity()) {
                            cartMessage = "Not enough stock to add to cart.";
                        } else {
                            Cart newCart = new Cart();
                            newCart.setUserId(userId);
                            newCart.setBook(book);
                            newCart.setQuantity(quantity);

                            Boolean addCart = cartDAO.addToCart(newCart);

                            if (addCart) {
                                cartMessage = "Add book to cart successfully!";
                            } else {
                                cartMessage = "Something wrong when add book to cart.";
                            }
                        }
                    }
                } else {
                    cartMessage = "Book or User not exist.";
                }

            } else if (action.equals("updateQuantityInCart") && bookIdStr != null && userIdStr != null && quantityStr != null) {
                int cartId = Integer.parseInt(cartIdStr);
                int bookId = Integer.parseInt(bookIdStr);
                int userId = 1; // int userId = Integer.parseInt(userIdStr);
                int quantity = Integer.parseInt(quantityStr);

                // need check later: exist User
                if (bookDAO.existsBookById(bookId)) {
                    Book book = bookDAO.getBookById(bookId);
                    Cart existingCart = cartDAO.getCartByUserAndBook(userId, bookId);

                    if (existingCart != null) {
                        if (quantity < 1) {
                            Boolean removeSuccess = cartDAO.removeFromCart(cartId);
                            if (removeSuccess) {
                                cartMessage = "Remove cart successfully!";
                            } else {
                                cartMessage = "Something wrong when Remove cart.";
                            }

                        } else if (quantity > book.getStockQuantity()) {
                            cartMessage = "Cannot add more than available stock.";
                        } else {
                            existingCart.setQuantity(quantity);
                            Boolean updateCart = cartDAO.updateCart(existingCart);

                            if (updateCart) {
                                cartMessage = "Update book quantity in cart successfully!";
                            } else {
                                cartMessage = "Something wrong when Update book quantity in cart.";
                            }
                        }
                    } else {
                        cartMessage = "Not exist cart to update.";
                    }
                } else {
                    cartMessage = "Book or User not exist.";
                }

            } else if (action.equals("removeFromCart") && cartIdStr != null) {
                int cartId = Integer.parseInt(cartIdStr);

                // need check later: exist User
                if (cartDAO.existsCartById(cartId)) {
                    Boolean removeCart = cartDAO.removeFromCart(cartId);
                    if (removeCart) {
                        cartMessage = "Remove cart successfully!";
                    } else {
                        cartMessage = "Something wrong when Remove cart.";
                    }
                } else {
                    cartMessage = "Cart does not exist.";
                }
            }

            session.setAttribute("cartMessage", cartMessage);
            response.sendRedirect("/bookstore/cart");
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
