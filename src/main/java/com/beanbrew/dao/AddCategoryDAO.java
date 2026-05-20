package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.model.Category;
import com.beanbrew.util.DBConnection;

public class AddCategoryDAO {
	
	private static final String query = "INSERT INTO category (category_name, description, active_status) VALUES (?, ?, ?)";
	
	/**
	 * Adds a new category to the database.
	 *
	 * @param category The Category object containing the name, description, 
	 *                 and active status to be inserted.
	 * @return true if the category was successfully added (exactly one row affected),
	 *         false otherwise.
	 * @throws SQLException if a database access error occurs.
	 */

	
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
