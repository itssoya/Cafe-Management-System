package com.beanbrew.dao;

import java.sql.*;
import com.beanbrew.util.DBConnection;

public class AdminReviewActionDAO {

    public boolean updateStatus(int reviewId, String status) throws SQLException {
        String query = "UPDATE reviews SET status = ? WHERE review_id = ?";
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, reviewId);
            return ps.executeUpdate() == 1;
        }
    }

    public boolean delete(int reviewId) throws SQLException {
        String query = "DELETE FROM reviews WHERE review_id = ?";
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, reviewId);
            return ps.executeUpdate() == 1;
        }
    }
}