package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.model.User;
import com.beanbrew.util.DBConnection;

public class UpdateProfilePictureDAO {
	
	private static final String query = "UPDATE users SET profileimageurl = ? WHERE user_id = ?";
	
	private User user = new User();
	
	/**
	 * Uploads the profile image URL (from the local machine) to the database.
	 *
	 * @param profileImageUrl The URL of the profile image to be stored.
	 * @return true if the profile image was successfully uploaded (exactly one row affected),
	 *         false otherwise.
	 * @throws SQLException if a database access error occurs.
	 */

	
	public boolean updateProfilePicture (String profileImageUrl) throws SQLException  {
		
		
		try(Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query) ){
			
			preparedStatement.setString(1, profileImageUrl);
			preparedStatement.setInt(2, user.getUserId());
			
			int rowsAffected = preparedStatement.executeUpdate();
			
			return rowsAffected == 1;
		
			
		} 
	}

}
