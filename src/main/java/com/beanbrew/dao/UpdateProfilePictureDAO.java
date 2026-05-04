package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.beanbrew.util.DBConnection;

public class UpdateProfilePictureDAO {
	
	private static final String query = "UPDATE users SET profileimageurl = ? WHERE user_id = ?";
	
	private 
	
	public static boolean updateProfilePicture(String profileImageUrl) {
		
		
		try(Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query) ){
			
			preparedStatement.setString(1, profileImageUrl);
			preparedStatement.setInt(2, user_id);
			
		}
	}

}
