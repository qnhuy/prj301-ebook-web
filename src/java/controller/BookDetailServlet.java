package controller;

import dao.BookDAO;
import model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class BookDetailServlet extends HttpServlet {

    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("id"));
        Book book = bookDAO.getBookById(bookId);
        List<Book> similarBooks = bookDAO.getSimilarBooks(bookId, book.getCategoryId(), 4);

        request.setAttribute("book", book);
        request.setAttribute("similarBooks", similarBooks);
        request.getRequestDispatcher("/book-detail.jsp").forward(request, response);
    }
}
