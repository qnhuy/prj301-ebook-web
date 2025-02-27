package controller;

import dao.BookDAO;
import model.Book;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

public class SearchServlet extends HttpServlet {

    private BookDAO bookDAO;

    @Override
    public void init() throws ServletException {
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
        String sort = request.getParameter("sort");
        String pageStr = request.getParameter("page");
        int page = pageStr != null ? Integer.parseInt(pageStr) : 1;
        int pageSize = 10;

        List<Book> searchResults = bookDAO.searchBooks(keyword, sort, page, pageSize);
        request.setAttribute("searchResults", searchResults);
        request.setAttribute("keyword", keyword);
        request.setAttribute("currentPage", page);
        request.getRequestDispatcher("/search.jsp").forward(request, response);
    }
}
