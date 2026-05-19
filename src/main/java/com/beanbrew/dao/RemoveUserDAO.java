package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class RemoveUserDAO {
	
	private static final String query = "DELETE FROM users WHERE user_id = ?";
	
	/**
	 * Deletes a user from the database.
	 *
	 * @param userID The unique identifier of the user to be removed. 
	 * @return true if the user was successfully deleted (exactly one row affected),
	 *         false otherwise.
	 * @throws SQLException if a database access error occurs.
	 */
	
	public boolean removeUserByID(int userId) throws SQLException {
		
		try (Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query)){
			
			preparedStatement.setInt(1, userId);
			
			int rowsAffected = preparedStatement.executeUpdate();
			
			preparedStatement.close();
			con.close();
			
			return rowsAffected == 1;	
			
		} 
	}
}
