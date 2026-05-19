package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class UpdateOrderStatusDAO {
	
	private static final String query = "UPDATE orders SET order_status = ? WHERE order_id = ?";

	    public boolean updateStatus(int orderId, String status) throws SQLException {

	        try (Connection con = DBConnection.buildConnection();
	             PreparedStatement preparedStatement = con.prepareStatement(query)) {

	        	preparedStatement.setString(1, status);
	        	preparedStatement.setInt(2, orderId);

	            return preparedStatement.executeUpdate() == 1;
	        }
	    }

}
