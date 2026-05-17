package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class DeleteMenuItemDAO {
	
	private static final String query = "DELETE FROM menu WHERE item_id = ?";

    public static boolean delete(int itemId) throws SQLException {
    	
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement preparedStatement = con.prepareStatement(query)) {
        	
        	preparedStatement.setInt(1, itemId);
            
            int rowsAffected = preparedStatement.executeUpdate();
            
            return rowsAffected == 1;
        }
    }

}
