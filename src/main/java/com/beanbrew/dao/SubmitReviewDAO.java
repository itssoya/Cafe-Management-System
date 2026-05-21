package com.beanbrew.dao;

import java.sql.*;
import com.beanbrew.model.Review;
import com.beanbrew.util.DBConnection;

public class SubmitReviewDAO{

    private static final String QUERY =
            "INSERT INTO reviews (user_id, message, rating) VALUES (?, ?, ?)";

    public boolean submit(Review review) throws SQLException{
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement ps = con.prepareStatement(QUERY)){
            ps.setInt(1, review.getUserId());
            ps.setString(2, review.getMessage());
            ps.setInt(3, review.getRating());
            return ps.executeUpdate() == 1;
        }
    }
}