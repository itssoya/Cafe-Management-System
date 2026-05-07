package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.beanbrew.model.User;
import com.beanbrew.util.DBConnection;

public class FetchAllUserDAO {
	
	private static final String query = "SELECT * FROM users";
	
	public List <User> getAllUser() throws SQLException {
		
		 List<User> users = new ArrayList<> ();
		
		try (Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query);
			ResultSet resultSet = preparedStatement.executeQuery()){
			
			while (resultSet.next()) {
				
				User user = new User();
				
				user.setUserId(resultSet.getInt("user_id"));
				user.setUsername(resultSet.getString("username"));
				user.setEmail(resultSet.getString("email_id"));
				user.setPassword(resultSet.getString("password"));
				user.setCreatedAt(resultSet.getString("created_at"));
				user.setIsAdmin(resultSet.getBoolean("is_admin"));
				user.setIsVerified(resultSet.getBoolean("is_verified"));
				user.setIsActive(resultSet.getBoolean("active_status"));
				
				users.add(user);
			}
		}
		
		return users;
	}
}
