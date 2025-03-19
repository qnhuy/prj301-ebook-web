package model;


import java.math.BigDecimal;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author owner
 */
public class OrderDetails {
    private int orderDetailsId;
    private int orderId;
    private Book book;
    private int quantity;
    private BigDecimal price;

    public OrderDetails() {
    }

    public OrderDetails(int orderDetailsId, int orderId, Book book, int quantity, BigDecimal price) {
        this.orderDetailsId = orderDetailsId;
        this.orderId = orderId;
        this.book = book;
        this.quantity = quantity;
        this.price = price;
    }

    public int getOrderDetailsId() {
        return orderDetailsId;
    }

    public void setOrderDetailsId(int orderDetailsId) {
        this.orderDetailsId = orderDetailsId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public Book getBook() {
        return book;
    }

    public void setBook(Book book) {
        this.book = book;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    
    
}
