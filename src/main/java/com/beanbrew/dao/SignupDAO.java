package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.model.User;
import com.beanbrew.util.DBConnection;

public class SignupDAO {
	
	private static final String query = "INSERT INTO users ( username, email_id, password, created_at, is_admin, profileimageurl) VALUES ( ?, ?, ?, now(), ?, ?)";
	
	/**
	 * This method adds used in database.
	 *
	 * @param user is an instance of User. 
	 * @return true if the user was successfully added (exactly one row updated),
	 *         false otherwise
	 * @throws SQLException if a database access error occurs
	 */
	
	public  boolean signUp(User user) throws SQLException {
		
		try (Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query)){
			
			
			preparedStatement.setString(1, user.getUsername());
			preparedStatement.setString(2, user.getEmail());
			preparedStatement.setString(3, user.getPassword());
			preparedStatement.setBoolean(4, user.isAdmin());
			preparedStatement.setString(5, user.getProfileImageURL());
			
			
			int rowsAffected = preparedStatement.executeUpdate();
			
			return rowsAffected == 1;
			
		} 
	}
}
