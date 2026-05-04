package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class AdminPrivilegeDAO {

    private static final String query = "UPDATE users SET is_admin = ? WHERE user_id = ?";

    public boolean makeAdmin(int userId) {
    	
        return updateAdminStatus(userId, true);
        
    }

    public boolean removeAdmin(int userId) {
    	
        return updateAdminStatus(userId, false);
        
    }

    private boolean updateAdminStatus(int userId, boolean isAdmin) {
    	
        try {
        	
        	Connection con = DBConnection.buildConnection();
        	
            PreparedStatement preparedStatement = con.prepareStatement(query);

            preparedStatement.setBoolean(1, isAdmin);
            preparedStatement.setInt(2, userId);

            int rowsAffected = preparedStatement.executeUpdate();
            
            preparedStatement.close();
			con.close();
			
            return rowsAffected == 1;

        } catch (ClassNotFoundException | SQLException e) {
        	
            e.printStackTrace(); 
            return false;
            
        }
    }
}
