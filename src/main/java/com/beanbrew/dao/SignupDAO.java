package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.model.User;
import com.beanbrew.util.DBConnection;

public class SignupDAO {
	
	private static final String query = "INSERT INTO users ( username, email_id, password, created_at, is_admin, profileimageurl) VALUES ( ?, ?, ?, now(), ?, ?)";
	
	public  boolean signUp(User user) {
		
		try (Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query)){
			
			
			preparedStatement.setString(1, user.getUsername());
			preparedStatement.setString(2, user.getEmail());
			preparedStatement.setString(3, user.getPassword());
			preparedStatement.setBoolean(4, user.isAdmin());
			preparedStatement.setString(5, user.getProfileImageURL());
			
			preparedStatement.execute();
			
			int rowsAffected = preparedStatement.executeUpdate();
			
			return rowsAffected == 1;
			
		} catch (SQLException | ClassNotFoundException e) {
			
			e.printStackTrace();
			
			return false;
			
		}
	}
}
