package com.beanbrew.dao;

import java.sql.*;
import com.beanbrew.util.DBConnection;

public class DeleteReviewDAO {

    private static final String QUERY = "DELETE FROM reviews WHERE review_id = ? AND user_id = ?";

  
    public boolean delete(int reviewId, int userId) throws SQLException {
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement ps = con.prepareStatement(QUERY)) {
            ps.setInt(1, reviewId);
            ps.setInt(2, userId);
            return ps.executeUpdate() == 1;
        }
    }
}