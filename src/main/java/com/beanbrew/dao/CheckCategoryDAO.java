package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.beanbrew.model.Category;
import com.beanbrew.util.DBConnection;

public class CheckCategoryDAO {
	
	private static final String query = "SELECT * FROM category WHERE category_id = ?";
	
	public static Category checkCatgeory(String category_name) throws SQLException {
		
		try(Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query)){
			
			preparedStatement.setString(1, category_name);
			
			ResultSet resultSet = preparedStatement.executeQuery();
			
			Category category = new Category();
			
			if(resultSet.next()) {
				
				category.setActiveStatus(resultSet.getBoolean("active_status"));
				category.setCategoryName(resultSet.getString("category_name"));
				category.setCategoryId(resultSet.getInt("category_id"));
				category.setDescription(resultSet.getString("description"));
				
				return category;
			}
			
			return null;
			
		}
	}

}
