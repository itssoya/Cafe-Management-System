package com.beanbrew.dao;

import java.sql.*;

import com.beanbrew.model.User;
import com.beanbrew.util.DBConnection;

public class LoginDAO {
	
	private static final String query = "SELECT * FROM users WHERE username = ?  ";
	
	private User user = null;
	
	public User login(String username) throws SQLException {

		
		try (Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query)){
			
			preparedStatement.setString(1, username);
			
			try (ResultSet resultSet = preparedStatement.executeQuery()){
			
				if (resultSet.next()) {
					
					user = new User();
					user.setUserId(resultSet.getInt("user_id"));
					user.setUsername(resultSet.getString("username"));
					user.setEmail(resultSet.getString("email_id"));
					user.setPassword(resultSet.getString("password"));
					user.setCreatedAt(resultSet.getString("created_at"));
					user.setIsAdmin(resultSet.getBoolean("is_admin"));
					
				}
			}		
		} 
		
		return user;
	}
}
