package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class DisableUserDAO {
	
	private static final String query = "UPDATE users SET active_status = ? WHERE user_id = ?";
	
	public boolean disableUser( int userID) throws ClassNotFoundException, SQLException  {
				
			try (Connection con = DBConnection.buildConnection();	
				PreparedStatement preparedStatement = con.prepareStatement(query)){
					
				preparedStatement.setBoolean(1, false);
				preparedStatement.setInt(2, userID);
					
				int rowsAffected = preparedStatement.executeUpdate();
					
				return rowsAffected == 1;
					
				}
					
			}
}
