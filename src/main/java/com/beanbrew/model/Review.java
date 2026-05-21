package com.beanbrew.model;

public class Review {
    private int reviewId;
    private int userId;
    private String username;
    private String message;
    private int rating;
    private String createdAt;

    public int getReviewId(){ return reviewId; }
    public void setReviewId(int reviewId){ this.reviewId = reviewId; }

    public int getUserId(){ return userId; }
    public void setUserId(int userId){ this.userId = userId; }

    public String getUsername(){ return username; }
    public void setUsername(String u){ this.username = u; }

    public String getMessage(){ return message; }
    public void setMessage(String m){ this.message = m; }

    public int getRating(){ return rating; }
    public void setRating(int r){ this.rating = r; }

    public String getCreatedAt(){ return createdAt; }
    public void setCreatedAt(String c){ this.createdAt = c; }
}