package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class ActivateUserDAO {
	
	private static final String query = "UPDATE users SET active_status = ? WHERE user_id = ?";
	
		public boolean activateUser( int userID) {
				
				try{
					
					Connection con = DBConnection.buildConnection();
					
					PreparedStatement preparedStatement = con.prepareStatement(query);
					
					preparedStatement.setBoolean(1, true);
					preparedStatement.setInt(2, userID);
					
					int rowsAffected = preparedStatement.executeUpdate();
					
					
					preparedStatement.close();
					con.close();
					
					return rowsAffected == 1;
					
				}
				
				catch(ClassNotFoundException | SQLException e) {
					
					e.printStackTrace();
					return false;
				}
					
			}
	

}
