package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class AdminPrivilegeDAO {

    private static final String query = "UPDATE users SET is_admin = ? WHERE user_id = ?";
    
    /**
     * Grants administrative privileges to a user by setting the is_admin to true.
     *
     * @param userId The unique identifier of the user.
     * @return true if the admin status was successfully updated (exactly one row affected),
     *         false otherwise.
     * @throws SQLException if a database access error occurs.
     */

    public boolean makeAdmin(int userId) throws SQLException{
    	
        return updateAdminStatus(userId, true);
        
    }
    
    /**
     * Revokes administrative privileges from a user by setting the is_admin to false.
     *
     * @param userId The unique identifier of the user whose is_admin to marked false.
     * @return true if the admin status was successfully updated (exactly one row affected),
     *         false otherwise.
     * @throws SQLException if a database access error occurs.
     */

    public boolean removeAdmin(int userId) throws SQLException {
    	
        return updateAdminStatus(userId, false);
        
    }
    
    /**
     * Updates the administrative status of a user in the database.
     *
     * @param userId  The unique identifier of the user.
     * @param isAdmin The new admin status to be applied (true for admin, false for non-admin).
     * @return true if the admin status was successfully updated (exactly one row affected),
     *         false otherwise.
     * @throws SQLException if a database access error occurs.
     */

    private boolean updateAdminStatus(int userId, boolean isAdmin) throws SQLException  {
    	
        try (Connection con = DBConnection.buildConnection();
        	
            PreparedStatement preparedStatement = con.prepareStatement(query)){

            preparedStatement.setBoolean(1, isAdmin);
            preparedStatement.setInt(2, userId);

            int rowsAffected = preparedStatement.executeUpdate();
			
            return rowsAffected == 1;

        } 
    }
}
