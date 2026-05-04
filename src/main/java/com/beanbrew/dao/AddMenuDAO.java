package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.beanbrew.model.MenuItem;
import com.beanbrew.util.DBConnection;

public class AddMenuDAO {
	
	private String query = "INSERT INTO MENU ( item_name, item_category, item_price, item_description, item_img_url, file_extension, createdDate) VALUES (?, ?, ?, ?, ?, ?, now())";
	
	public boolean addItem(MenuItem item) {
		
		try{
			
			Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatment = con.prepareStatement(query);
			
			preparedStatment.setString(1, item.getItemName());
			preparedStatment.setString(2, item.getCategory());
			preparedStatment.setDouble(3, item.getPrice());
			preparedStatment.setString(4, item.getDescription());
			preparedStatment.setString(5, item.getImageUrl());
			preparedStatment.setString(6, item.getFileExtension());
			
			int rowsAffected = preparedStatment.executeUpdate();
			
			preparedStatment.close();
			con.close();
			
			return rowsAffected == 1;	
			
		} catch(Exception e) {
			
			e.printStackTrace();
			return false;
		}
	}

}
