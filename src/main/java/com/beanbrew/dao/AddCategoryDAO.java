package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.model.Category;
import com.beanbrew.util.DBConnection;

public class AddCategoryDAO {
	
	private static final String query = "INSERT INTO category (category_name, description, active_status) VALUES (?, ?, ?)";
	
	public static boolean addNewCategory(Category category) throws SQLException {
		
		try (Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query)){
			
			preparedStatement.setString(1, category.getCategoryName());
			preparedStatement.setString(2, category.getDescription());
			preparedStatement.setBoolean(3, category.isActiveStatus());
			
			int rowsAffected = preparedStatement.executeUpdate();
			
			return rowsAffected == 1;
		}
	}
}
