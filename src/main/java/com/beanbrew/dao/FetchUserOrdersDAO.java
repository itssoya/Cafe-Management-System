package com.beanbrew.dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
 
import com.beanbrew.model.Order;
import com.beanbrew.util.DBConnection;
 
public class FetchUserOrdersDAO {
 
    private static final String query1 = "SELECT order_id, user_id, total_amount, order_status, created_at " +
										        "FROM orders WHERE user_id = ? " +
										        "ORDER BY created_at DESC " +
										        "LIMIT ? OFFSET ?";
 
    private static final String query2 = "SELECT COUNT(*) FROM orders WHERE user_id = ?";
 
    public List<Order> getOrdersByUserId(int userId, int currentPage, int pageSize) throws SQLException {
 
        List<Order> orders = new ArrayList<>();
        
        int offset = (currentPage - 1) * pageSize;
 
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement preparedStatement = con.prepareStatement(query1)) {
 
        	preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, pageSize);
            preparedStatement.setInt(3, offset);
 
            ResultSet resultSet = preparedStatement.executeQuery();
 
            while (resultSet.next()) {

            	Order order = new Order();
                order.setOrderId(resultSet.getInt("order_id"));
                order.setUserId(resultSet.getInt("user_id"));
                order.setTotalAmount(resultSet.getDouble("total_amount"));
                order.setStatus(resultSet.getString("order_status"));
                order.setCreatedAt(resultSet.getString("created_at"));
                orders.add(order);
            }
        }
        return orders;
    }
 
    public int countOrdersByUserId(int userId) throws SQLException {
 
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement presparedStatement = con.prepareStatement(query2)) {
 
        	presparedStatement.setInt(1, userId);
            ResultSet resultSet = presparedStatement.executeQuery();
 
            int rowsCount = 0;
			
			if (resultSet.next()) {
				
				rowsCount = resultSet.getInt(1);
				
			}
			
			return rowsCount;
        }
    }
}