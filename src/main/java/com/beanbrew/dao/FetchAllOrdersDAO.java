package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.beanbrew.model.Order;
import com.beanbrew.util.DBConnection;

public class FetchAllOrdersDAO {

    private static final String query = "SELECT o.*, u.username FROM orders o LEFT JOIN users u ON o.user_id = u.user_id ORDER BY o.created_at DESC";

    public List<Order> getAllOrders() throws SQLException {

        List<Order> orders = new ArrayList<>();

        try (Connection con = DBConnection.buildConnection();
             PreparedStatement preparedStatemen = con.prepareStatement(query)) {

            ResultSet resultSet = preparedStatemen.executeQuery();

            while (resultSet.next()) {
            	
                Order order = new Order();
                order.setOrderId(resultSet.getInt("order_id"));
                order.setUserId(resultSet.getInt("user_id"));
                order.setTotalAmount(resultSet.getDouble("total_amount"));
                order.setStatus(resultSet.getString("order_status"));
                order.setCreatedAt(resultSet.getString("created_at"));
                order.setUsername(resultSet.getString("username"));
                orders.add(order);
            }
        }
        
        return orders;
    }
}