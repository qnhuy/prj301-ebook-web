package model;

import java.math.BigDecimal;
import java.util.Date;

public class Book {

    private int bookId;
    private String title;
    private int authorId;
    private int categoryId;
    private int publisherId;
    private BigDecimal price;
    private int stockQuantity;
    private String description;
    private int coverId;
    private String status;
    private Date publishedDate;
    private String coverPath;

    public Book() {
    }

    public Book(int bookId, String title, int authorId, int categoryId, int publisherId,
            BigDecimal price, int stockQuantity, String description, int coverId,
            String coverPath, String status, Date publishedDate) {
        this.bookId = bookId;
        this.title = title;
        this.authorId = authorId;
        this.categoryId = categoryId;
        this.publisherId = publisherId;
        this.price = price;
        this.stockQuantity = stockQuantity;
        this.description = description;
        this.coverId = coverId;
        this.coverPath = coverPath;
        this.status = status;
        this.publishedDate = publishedDate;
    }

    public String getCoverPath() {
        return coverPath;
    }

    public void setCoverPath(String coverPath) {
        this.coverPath = coverPath;
    }

    // Getter và Setter
    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getAuthorId() {
        return authorId;
    }

    public void setAuthorId(int authorId) {
        this.authorId = authorId;
    }

    public int getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(int categoryId) {
        this.categoryId = categoryId;
    }

    public int getPublisherId() {
        return publisherId;
    }

    public void setPublisherId(int publisherId) {
        this.publisherId = publisherId;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getCoverId() {
        return coverId;
    }

    public void setCoverId(int coverImage) {
        this.coverId = coverId;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Date getPublishedDate() {
        return publishedDate;
    }

    public void setPublishedDate(Date publishedDate) {
        this.publishedDate = publishedDate;
    }
}
