package com.beanbrew.dao;

import java.sql.*;
import java.util.*;
import com.beanbrew.model.Review;
import com.beanbrew.util.DBConnection;

public class FetchReviewsDAO {

	private static final String APPROVED_QUERY =
		    "SELECT r.review_id, r.user_id, u.username, r.message, r.rating, r.status, r.created_at " +
		    "FROM reviews r JOIN users u ON r.user_id = u.user_id " +
		    "WHERE r.status = 'APPROVED' ORDER BY r.rating DESC, r.created_at DESC";

    public List<Review> fetchApproved() throws SQLException {
        return fetch(APPROVED_QUERY);
    }


    private List<Review> fetch(String query) throws SQLException {
        List<Review> list = new ArrayList<>();
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement ps = con.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
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
}