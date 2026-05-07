package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class VerifyUserDAO {
	
	private static final String query  = "UPDATE users SET is_verified = ? WHERE user_id = ?";
	
	/**
	 * Marks a user as verified in the database.
	 *
	 * @param userID The unique identifier of user
	 * @return true if the user was successfully verified (exactly one row updated),
	 *         false otherwise
	 * @throws ClassNotFoundException if the database driver class is not found
	 * @throws SQLException if a database access error occurs
	 */
	
	public boolean verifyUserById (int userID) throws ClassNotFoundException, SQLException {
		
		try (Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query)){
			
			preparedStatement.setBoolean(1, true);
			preparedStatement.setInt(2, userID);
			
			int rowsAffected = preparedStatement.executeUpdate();
			
			
			preparedStatement.close();
			con.close();
			
			return rowsAffected == 1;
			
		}			
	}
}
