package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.model.User;
import com.beanbrew.util.DBConnection;

public class UpdateProfilePictureDAO {
	
	private static final String query = "UPDATE users SET profileimageurl = ? WHERE user_id = ?";
	
	private User user = new User();
	
	
	public boolean updateProfilePicture (String profileImageUrl)  {
		
		
		try(Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query) ){
			
			preparedStatement.setString(1, profileImageUrl);
			preparedStatement.setInt(2, user.getUserId());
			
			int rowsAffected = preparedStatement.executeUpdate();
			
			return rowsAffected == 1;
		
			
		} catch (SQLException e){
			
			e.printStackTrace();
			return false;
		}
	}

}
