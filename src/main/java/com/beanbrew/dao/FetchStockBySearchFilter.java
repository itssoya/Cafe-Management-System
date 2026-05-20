package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.beanbrew.model.StockItem;
import com.beanbrew.util.DBConnection;

public class FetchStockBySearchFilter {
	
	private String query3 = "SELECT * FROM stock_items";
	
	public List<StockItem> getStock(int currentPageNumber, Boolean isBakery, String search) throws SQLException{
		
		StringBuilder query = new StringBuilder ( "SELECT * FROM stock_items WHERE 1 = 1");
		
		int offset = (currentPageNumber - 1) * 10;
		
		List<StockItem> stockItemList = new ArrayList<> ();
		
		String patternSearch = null;
		
		if (isBakery != null) {
			query.append(" AND is_bakery = ? ");
		}
		
		if(search != null && !search.isEmpty()) {
			query.append(" AND stock_name LIKE ?");
			
			patternSearch = "%"+search+"%";
		}
		
		query.append(" LIMIT ? OFFSET ?");
		
		try(Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query.toString())){
			
			int index = 1;
			
			if(isBakery != null) {
				preparedStatement.setBoolean(index++, isBakery);
			}
			
			if(search != null && !search.isEmpty()) {
				preparedStatement.setString(index++, patternSearch);
			}
			
			preparedStatement.setInt(index++, 10);
			preparedStatement.setInt(index++, offset);
			
			ResultSet resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				
				StockItem stockItem = new StockItem();
				stockItem.setId(resultSet.getInt("stock_id"));
				stockItem.setName(resultSet.getString("stock_name"));
				stockItem.setQuantityInStock(resultSet.getDouble("quantity_in_stock"));
				stockItem.setUnit(resultSet.getString("stock_unit"));
				stockItem.setLowStockThreshold(resultSet.getDouble("low_stock_threshold"));
				stockItem.setLastUpdatedDate(resultSet.getString("updated_at"));
				stockItem.setBakery(resultSet.getBoolean("is_bakery"));
				
				stockItemList.add(stockItem);
				
			}
			
			return stockItemList;
		}
		
	}
	
	public int countUserForFilter(Boolean isBakery, String search) throws SQLException {
		
		StringBuilder query2 = new StringBuilder("SELECT COUNT(*) FROM stock_items WHERE 1=1");
		
		String patternSearch = null;
		
		int rowsCount = 0;
		
		if (isBakery != null) {
			query2.append(" AND is_bakery = ? ");
		}
		
		if(search != null && !search.isEmpty()) {
			query2.append(" AND stock_name LIKE ?");
			
			patternSearch = "%"+search+"%";
		}
		
		try (Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query2.toString())){
			
			int index = 1;
			
			if(isBakery != null) {
				preparedStatement.setBoolean(index++, isBakery);
			}
			
			if(search != null && !search.isEmpty()) {
				preparedStatement.setString(index++, patternSearch);
			}
			
			ResultSet resultSet = preparedStatement.executeQuery();
			
			if (resultSet.next()) {
				
				rowsCount = resultSet.getInt(1);
				
			}
			
			return rowsCount;
			
			
		} 
	}
	
	public List <StockItem> getAllStockItem() throws SQLException {
		
		 List<StockItem> allItem = new ArrayList<> ();
		
		try (Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query3);
			ResultSet resultSet = preparedStatement.executeQuery()){
			
			while (resultSet.next()) {
				
				StockItem stockItem = new StockItem();
				stockItem.setId(resultSet.getInt("stock_id"));
				stockItem.setName(resultSet.getString("stock_name"));
				stockItem.setQuantityInStock(resultSet.getDouble("quantity_in_stock"));
				stockItem.setUnit(resultSet.getString("stock_unit"));
				stockItem.setLowStockThreshold(resultSet.getDouble("low_stock_threshold"));
				stockItem.setLastUpdatedDate(resultSet.getString("updated_at"));
				stockItem.setBakery(resultSet.getBoolean("is_bakery"));
				
				allItem.add(stockItem);
			}
		}
		
		return allItem;
	}
	
	public StockItem getStockById(int id) throws SQLException {

	    String query = "SELECT * FROM stock_items WHERE stock_id = ?";

	    try (Connection con = DBConnection.buildConnection();
	         PreparedStatement preparedStatement = con.prepareStatement(query)) {

	        preparedStatement.setInt(1, id);
	        ResultSet resultSet = preparedStatement.executeQuery();

	        if (resultSet.next()) {
	            StockItem stockItem = new StockItem();
	            stockItem.setId(resultSet.getInt("stock_id"));
	            stockItem.setName(resultSet.getString("stock_name"));
	            stockItem.setQuantityInStock(resultSet.getDouble("quantity_in_stock"));
	            stockItem.setUnit(resultSet.getString("stock_unit"));
	            stockItem.setLowStockThreshold(resultSet.getDouble("low_stock_threshold"));
	            stockItem.setLastUpdatedDate(resultSet.getString("updated_at"));
	            stockItem.setBakery(resultSet.getBoolean("is_bakery"));
	            return stockItem;
	        }

	        return null;
	    }
	}

}
