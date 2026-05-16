package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class RestockItem {
	
	private static final String query = "UPDATE stock_items SET quantity_in_stock = ?, updated_at = now() WHERE stock_id = ?";
	
	public static boolean restockItem(Double newStockQuantity, int userId) throws SQLException{
		
		try(Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query)){
			
			preparedStatement.setDouble(1, newStockQuantity);
			preparedStatement.setInt(2, userId);
			
			int rowsAffected = preparedStatement.executeUpdate();
			
			return rowsAffected == 1;
		}
		
	}

}
