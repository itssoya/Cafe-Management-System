package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class RemoveUserDAO {
	
	private static final String query = "DELETE FROM users WHERE user_id = ?";
	
	public boolean removeUserByID(int userId) {
		
		try {
			Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query);
			
			preparedStatement.setInt(1, userId);
			
			int rowsAffected = preparedStatement.executeUpdate();
			
			preparedStatement.close();
			con.close();
			
			return rowsAffected == 1;
			
			
			
		} catch(ClassNotFoundException | SQLException e) {
			
			 e.printStackTrace();
			 return false;
			 
		}
	}

}
