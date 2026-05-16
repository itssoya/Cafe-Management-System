package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.beanbrew.model.MenuItem;
import com.beanbrew.util.DBConnection;

public class FetchMenuBySearchFilter {
	
	public List<MenuItem> fetchMenu(String search, Integer categoryId, int currentPageNumber ) throws SQLException{
		
		StringBuilder query = new StringBuilder("SELECT * FROM menu WHERE 1 = 1");
		int offset = (currentPageNumber - 1) * 10;
		
		List<MenuItem> menu = new ArrayList<>();
		
		String patternSearch = null;
		
		if(categoryId != null) {
			
			query.append("AND category_id");
		}
		
		if(search != null && search.isEmpty()) {
			
			query.append("AND item_name = ?");
			patternSearch = "%"+search+"%";
			
		}
		
		query.append(" LIMIT ? OFFSET ?");
		
		try (Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query.toString())){
			
			int index = 1;
			
			if(categoryId != null) {
				
				preparedStatement.setInt(index++, categoryId );
			}
			
			if(search != null && search.isEmpty()) {
				
				preparedStatement.setString(index, patternSearch);
				
			}
			
			preparedStatement.setInt(index++, 10);
			preparedStatement.setInt(index, offset);
			
			ResultSet resultSet = preparedStatement.executeQuery();
			
			while(resultSet.next()) {
				
				MenuItem menuObj = new MenuItem();
				menuObj.setItemId(resultSet.getInt("item_id"));
				menuObj.setItemName(resultSet.getString("item_name"));
				menuObj.setCategoryId(resultSet.getInt("category_id"));
				menuObj.setPrice(resultSet.getDouble("item_price"));
				menuObj.setDescription(resultSet.getString("item_description"));
				menuObj.setImageUrl(resultSet.getString("img_url"));
				menuObj.setFileExtension(resultSet.getString("file_extension"));
				menuObj.setCreatedDate(resultSet.getString("active_status"));
				
				menu.add(menuObj);
			}
			
		}
		return menu;
	}
	
	public int countMenuForFilter(String search, Integer categoryId) throws SQLException {
			
			StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM menu WHERE 1=1");
			
			String patternSearch = null;
			
			int rowsCount = 0;
			
			if(categoryId != null) {
				
				query.append("AND category_id");
			}
			
			if(search != null && search.isEmpty()) {
				
				query.append("AND item_name = ?");
				patternSearch = "%"+search+"%";
				
			}
			
			try (Connection con = DBConnection.buildConnection();
				PreparedStatement preparedStatement = con.prepareStatement(query.toString())){
				
				int index = 1;
				
				if(categoryId != null) {
					
					preparedStatement.setInt(index++, categoryId );
				}
				
				if(search != null && search.isEmpty()) {
					
					preparedStatement.setString(index, patternSearch);
					
				}
				
				ResultSet resultSet = preparedStatement.executeQuery();
				
				if (resultSet.next()) {
					
					rowsCount = resultSet.getInt(1);
					
				}
				
				return rowsCount;
		} 
	}
	
	public MenuItem getaMenuById(int id) throws SQLException {

	    String query = "SELECT * FROM menu WHERE item_id = ?";

	    try (Connection con = DBConnection.buildConnection();
	         PreparedStatement preparedStatement = con.prepareStatement(query)) {

	        preparedStatement.setInt(1, id);
	        ResultSet resultSet = preparedStatement.executeQuery();

	        if (resultSet.next()) {
	        	MenuItem menuObj = new MenuItem();
				menuObj.setItemId(resultSet.getInt("item_id"));
				menuObj.setItemName(resultSet.getString("item_name"));
				menuObj.setCategoryId(resultSet.getInt("category_id"));
				menuObj.setPrice(resultSet.getDouble("item_price"));
				menuObj.setDescription(resultSet.getString("item_description"));
				menuObj.setImageUrl(resultSet.getString("img_url"));
				menuObj.setFileExtension(resultSet.getString("file_extension"));
				menuObj.setCreatedDate(resultSet.getString("active_status"));
				
				return menuObj;
	        }

	        return null;
	    }
	}

}
