package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.beanbrew.model.User;
import com.beanbrew.util.DBConnection;

public class FetchUserBySearchFilter {
	
	
		public List <User> getUser  (int currentPageNumber, Boolean isAdmin, Boolean isVerified, String search) throws SQLException{
			
			StringBuilder query = new StringBuilder ( "SELECT * FROM users WHERE 1 = 1");
			int offset = (currentPageNumber - 1) * 10;
			
			 List<User> users = new ArrayList<> ();
			 
			 String patternSearch = null;
			
			if(isAdmin != null) {
				query.append(" AND is_admin = ? ");
			}
			
			if(isVerified != null) {
				query.append(" AND is_verified =?");
			}
			
			if (search != null && !search.isEmpty() ) {
	            query.append(" AND (username LIKE ?");
	            query.append(" OR email_id LIKE ?)");
	            
	            patternSearch = "%" + search + "%";
				
	        }
			
			query.append(" LIMIT ? OFFSET ?");
			
	
			try (Connection con = DBConnection.buildConnection();
				PreparedStatement preparedStatement = con.prepareStatement(query.toString())) {
				
				int index = 1;
				
				if(isAdmin != null) {
					preparedStatement.setBoolean(index++, isAdmin);
				}
				
				if(isVerified != null) {
					preparedStatement.setBoolean(index++, isVerified);
				}
				
				if (search != null && !search.isEmpty() ) {
					preparedStatement.setString(index++, patternSearch);
					preparedStatement.setString(index++, patternSearch);
		        }
				
				preparedStatement.setInt(index++, 10);
				preparedStatement.setInt(index, offset);
				
				ResultSet resultSet = preparedStatement.executeQuery();
				
				while (resultSet.next()) {
					
					User user = new User();
					
					user = new User();
					user.setUserId(resultSet.getInt("user_id"));
					user.setUsername(resultSet.getString("username"));
					user.setEmail(resultSet.getString("email_id"));
					user.setPassword(resultSet.getString("password"));
					user.setCreatedAt(resultSet.getString("created_at"));
					user.setIsAdmin(resultSet.getBoolean("is_admin"));
					user.setIsVerified(resultSet.getBoolean("is_verified"));
					user.setIsActive(resultSet.getBoolean("active_status"));
					
					users.add(user);
					
				}
				return users;
			}
		}
		
		
		public int countUserForFilter(Boolean isAdmin, Boolean isVerified, String search) throws SQLException {
			
			StringBuilder query = new StringBuilder("SELECT COUNT(*) FROM users WHERE 1=1");
			
			String patternSearch = null;
			
			int rowsCount = 0;
			
			if(isAdmin != null) {
				query.append(" AND is_admin = ?");
			}
			
			if(isVerified != null) {
				query.append(" AND is_verified = ?");
			}
			
			if(search != null && !search.isEmpty()) {
				query.append(" AND (username LIKE ?");
				query.append(" OR em"
						+ "ail_id LIKE ?)");
				
				patternSearch = "%" + search + "%";
			}
			
			try (Connection con = DBConnection.buildConnection();
				PreparedStatement preparedStatement = con.prepareStatement(query.toString())){
				
				int index = 1;
				
				if(isAdmin != null) {
					preparedStatement.setBoolean(index++, isAdmin);
				}
				
				if(isVerified != null) {
					preparedStatement.setBoolean(index++, isVerified);
				}
				
				if (search != null && !search.isEmpty() ) {
					preparedStatement.setString(index++, patternSearch);
					preparedStatement.setString(index++, patternSearch);
		        }
				
				ResultSet resultSet = preparedStatement.executeQuery();
				
				if (resultSet.next()) {
					
					rowsCount = resultSet.getInt(1);
					
				}
				
				resultSet.close();
				preparedStatement.close();
				con.close();
				
				return rowsCount;
				
				
			} 
		}
}
