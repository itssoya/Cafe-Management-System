package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class AdminPrivilegeDAO {

    private static final String query = "UPDATE users SET is_admin = ? WHERE user_id = ?";

    public boolean makeAdmin(int userId) throws ClassNotFoundException, SQLException{
    	
        return updateAdminStatus(userId, true);
        
    }

    public boolean removeAdmin(int userId) throws ClassNotFoundException, SQLException {
    	
        return updateAdminStatus(userId, false);
        
    }

    private boolean updateAdminStatus(int userId, boolean isAdmin) throws ClassNotFoundException, SQLException  {
    	
        try (Connection con = DBConnection.buildConnection();
        	
            PreparedStatement preparedStatement = con.prepareStatement(query)){

            preparedStatement.setBoolean(1, isAdmin);
            preparedStatement.setInt(2, userId);

            int rowsAffected = preparedStatement.executeUpdate();
			
            return rowsAffected == 1;

        } 
    }
}
