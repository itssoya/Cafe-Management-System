package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.beanbrew.model.Order;
import com.beanbrew.util.DBConnection;

public class FetchOrderDAO {
	
	private static final String query = "SELECT * FROM orders WHERE order_id = ?";
	
	
	public Order getOrderById(int orderId) throws SQLException {
		
		try (Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query)){
				
				preparedStatement.setInt(1, orderId);
				
				ResultSet resultSet = preparedStatement.executeQuery();

			    if (resultSet.next()) {

			        Order order = new Order();
			        order.setOrderId(resultSet.getInt("order_id"));
			        order.setUserId(resultSet.getInt("user_id"));
			        order.setTotalAmount(resultSet.getDouble("total_amount"));
			        order.setStatus(resultSet.getString("order_status"));
			        order.setCreatedAt(resultSet.getString("created_at"));

			        return order;
			    }

			    return null;	
		}
		
	}

}
