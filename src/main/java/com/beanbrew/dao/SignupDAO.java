package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.beanbrew.model.User;
import com.beanbrew.util.DBConnection;

public class SignupDAO {
	
	private String query = "INSERT INTO users ( username, email_id, password, created_at, is_admin) VALUES ( ?, ?, ?, now(), ?)";
	
	public  void signUp(User user) {
		
		try {
			
			Connection con = DBConnection.buildConnection();
			
			PreparedStatement preparedStatement = con.prepareStatement(query);
			
			
			preparedStatement.setString(1, user.getUsername());
			preparedStatement.setString(2, user.getEmail());
			preparedStatement.setString(3, user.getPassword());
			preparedStatement.setBoolean(4, user.getIsAdmin());
			
			preparedStatement.execute();
			preparedStatement.close();
			con.close();
			
		} catch (Exception e) {
			
			System.out.println(e.getMessage());
			
		}
	}
}
