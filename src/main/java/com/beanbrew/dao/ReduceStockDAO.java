package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class ReduceStockDAO {
	
	private static final String query = "UPDATE stock_items SET quantity_in_stock = quantity_in_stock - ? WHERE stock_id = ?";
	
	public boolean reduceStock (double quantityInStock, int stockId) throws SQLException{
		
		try(Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query)){
			
			preparedStatement.setDouble(1, quantityInStock);
			preparedStatement.setInt(2, stockId);
			
			int rowsAffected = preparedStatement.executeUpdate();
			
			return rowsAffected == 1;
		}
	}

}
