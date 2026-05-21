package com.beanbrew.dao;

import java.sql.*;
import java.util.*;
import com.beanbrew.model.Review;
import com.beanbrew.util.DBConnection;

public class FetchReviewsDAO {

    private static final int PAGE_SIZE = 6;

    public List<Review> fetchApprovedPaged(int page) throws SQLException {
        String sql = "SELECT r.review_id, r.user_id, u.username, r.message, r.rating, r.status, r.created_at " +
                     "FROM reviews r JOIN users u ON r.user_id = u.user_id " +
                     "WHERE r.status = 'APPROVED' ORDER BY r.rating DESC, r.created_at DESC " +
                     "LIMIT ? OFFSET ?";
        List<Review> list = new ArrayList<>();
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, PAGE_SIZE);
            ps.setInt(2,(page - 1) * PAGE_SIZE);
            ResultSet rs = ps.executeQuery();
            while (rs.next()){
                Review r = new Review();
                r.setReviewId(rs.getInt("review_id"));
                r.setUserId(rs.getInt("user_id"));
                r.setUsername(rs.getString("username"));
                r.setMessage(rs.getString("message"));
                r.setRating(rs.getInt("rating"));
                r.setStatus(rs.getString("status"));
                r.setCreatedAt(rs.getString("created_at"));
                list.add(r);
            }
        }
        return list;
    }

    public int countApproved() throws SQLException {
        String sql = "SELECT COUNT(*) FROM reviews WHERE status = 'APPROVED'";
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs= ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        }
        return 0;
    }



}