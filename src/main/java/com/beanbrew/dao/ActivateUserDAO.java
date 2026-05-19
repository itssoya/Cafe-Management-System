package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class ActivateUserDAO {
	
	private static final String query = "UPDATE users SET active_status = ? WHERE user_id = ?";
	
	/**
	 * Activates a user account in the database by setting the active status to true.
	 *
	 * @param userID The unique identifier of the user to be activated.
	 * @return true if the user was successfully activated (exactly one row affected),
	 *         false otherwise.
	 * @throws SQLException if a database access error occurs.
	 */

	
		public boolean activateUser( int userID) throws SQLException {
				
				try (Connection con = DBConnection.buildConnection();
					
					PreparedStatement preparedStatement = con.prepareStatement(query)){
					
					preparedStatement.setBoolean(1, true);
					preparedStatement.setInt(2, userID);
					
					int rowsAffected = preparedStatement.executeUpdate();
					
					
					preparedStatement.close();
					con.close();
					
					return rowsAffected == 1;
					
				}		
			}
		}
