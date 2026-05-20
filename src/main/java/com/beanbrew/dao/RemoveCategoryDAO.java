package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class RemoveCategoryDAO {
	
	private final static String query = "DELETE FROM category WHERE category_id = ?";
	
	public static boolean removeCategory(int category_id) throws SQLException {
		
		try(Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query)){
			
			preparedStatement.setInt(1, category_id);
			
			int rowsAffected = preparedStatement.executeUpdate();
			
			return rowsAffected == 1;	
		}
	}

}
