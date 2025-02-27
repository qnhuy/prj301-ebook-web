package controller;

import dao.BookDAO;
import model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class HomeServlet extends HttpServlet {

    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Book> featuredBooks = bookDAO.getFeaturedBooks(5);
        List<Book> newBooks = bookDAO.getNewBooks(5);
        List<Book> bestSellingBooks = bookDAO.getBestSellingBooks(5);

        request.setAttribute("featuredBooks", featuredBooks);
        request.setAttribute("newBooks", newBooks);
        request.setAttribute("bestSellingBooks", bestSellingBooks);

        request.getRequestDispatcher("/home.jsp").forward(request, response);
    }
}
