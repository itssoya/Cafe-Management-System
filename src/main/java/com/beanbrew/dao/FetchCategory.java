package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.beanbrew.model.Category;
import com.beanbrew.util.DBConnection;

public class FetchCategory {
	
	private static final String query = "SELECT * FROM category WHERE active_status = true ORDER BY category_name ASC";

	    public static List<Category> getAllActive() throws SQLException {

	        List<Category> list = new ArrayList<>();

	        try (Connection con = DBConnection.buildConnection();
	             PreparedStatement ps = con.prepareStatement(query);
	             ResultSet rs = ps.executeQuery()) {

	            while (rs.next()) {
	                Category cat = new Category();
	                cat.setCategoryId(rs.getInt("category_id"));
	                cat.setCategoryName(rs.getString("category_name"));
	                cat.setDescription(rs.getString("description"));
	                cat.setActiveStatus(rs.getBoolean("active_status"));
	                list.add(cat);
	            }
	        }

	        return list;
	    }
}
