package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.beanbrew.model.StockItem;
import com.beanbrew.util.DBConnection;

public class CheckStockItemDAO {
	
	private static final String query = "SELECT * FROM stock_items WHERE stock_name = ?";
	
	public static StockItem checkStock(String stockName) throws SQLException {
		
		try(Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query)){
			
			preparedStatement.setString(1, stockName);
			
			ResultSet resultSet = preparedStatement.executeQuery();
			
			if(resultSet.next()) {
				
				StockItem stockItem = new StockItem();
				
				stockItem.setId(resultSet.getInt("stock_id"));
				stockItem.setName(resultSet.getString("stock_name"));
				stockItem.setQuantityInStock(resultSet.getDouble("quantity_in_stock"));
				stockItem.setUnit(resultSet.getString("stock_unit"));
				stockItem.setLastUpdatedDate(resultSet.getString("updated_at"));
				
				return stockItem;
			}
			return null;
		}
	}
}
