package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.beanbrew.model.Order;
import com.beanbrew.util.DBConnection;

public class AddOrderDAO {
	
	private static final String query = "INSERT INTO orders (user_id, total_amount, order_status, created_at) VALUES (?, ?, ?, now())";
	
	/**
	 * Creates a new order record in the database.
	 *
	 * @param order The Order object containing the user ID, total amount, 
	 *              and order status to be inserted.
	 * @return true if the order was successfully created (exactly one row affected),
	 *         false otherwise.
	 * @throws SQLException if a database access error occurs.
	 */
	
	public int createOrder(Order order) throws SQLException{
		
		try(Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query, PreparedStatement.RETURN_GENERATED_KEYS)){
			
			preparedStatement.setInt(1, order.getUserId());
			preparedStatement.setDouble(2, order.getTotalAmount());
			preparedStatement.setString(3, order.getStatus());
			
			preparedStatement.executeUpdate();
			
			ResultSet keys = preparedStatement.getGeneratedKeys();
			
	        if (keys.next()) {
	            return keys.getInt(1); 
	        }
	        throw new SQLException("Failed to get generated order_id");	

		}
	}

}
