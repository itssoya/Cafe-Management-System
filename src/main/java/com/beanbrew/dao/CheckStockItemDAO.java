package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.beanbrew.model.StockItem;
import com.beanbrew.util.DBConnection;

public class CheckStockItemDAO {
	
	private static final String query = "SELECT * FROM stock_items WHERE stock_name = ?";
	private static String searchQuery = "SELECT * FROM stock_items WHERE stock_name LIKE ?";
	
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
	
	public static List<StockItem> searchStock(String search) throws SQLException {
	    
	    List<StockItem> results = new ArrayList<>();
	    
	    String pattern = "%" + search + "%";

	    try (Connection con = DBConnection.buildConnection();
	         PreparedStatement ps = con.prepareStatement(searchQuery)) {

	        ps.setString(1, pattern);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	        	
	            StockItem item = new StockItem();
	            item.setId(rs.getInt("stock_id"));
	            item.setName(rs.getString("stock_name"));
	            item.setQuantityInStock(rs.getDouble("quantity_in_stock"));
	            item.setUnit(rs.getString("stock_unit"));
	            item.setLastUpdatedDate(rs.getString("updated_at"));
	            results.add(item);
	            
	        }
	    }
	    return results;
	}
}
