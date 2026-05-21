package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.beanbrew.model.Order;
import com.beanbrew.util.DBConnection;

public class FetchOrderBySearchFilterDAO {


    public List<Order> getOrder(int currentPageNumber, String orderStatus, String search) throws SQLException {
    	
    	StringBuilder query = new StringBuilder(
    			"SELECT o.order_id, o.user_id, o.total_amount, o.order_status, o.created_at, u.username " +
    				    "FROM orders o " +
    				    "JOIN users u ON o.user_id = u.user_id " +
    				    "LEFT JOIN order_items oi ON o.order_id = oi.order_id " +
    				    "LEFT JOIN menu m ON oi.menu_item_id = m.item_id " +
    				    "WHERE 1=1"
            );

        int offset = (currentPageNumber - 1) * 10;
        
        String patternSearch = null;

        if (orderStatus != null && !orderStatus.isEmpty()) {
        	
            query.append(" AND o.order_status = ?");
        }
        
        if(search != null && !search.isEmpty()) {
        	
			query.append(" AND (u.username LIKE ? OR m.item_name LIKE ?)");
			
			patternSearch = "%"+search+"%";
		}

        query.append(" LIMIT ? OFFSET ?");

        List<Order> orderList = new ArrayList<>();

        try (Connection con = DBConnection.buildConnection();
             PreparedStatement preparedStatement = con.prepareStatement(query.toString())) {

            int index = 1;

            if (orderStatus != null && !orderStatus.isEmpty()) {
            	
                preparedStatement.setString(index++, orderStatus);
            }

            if (patternSearch != null) {
            	
            	preparedStatement .setString(index++, patternSearch);
            	preparedStatement .setString(index++, patternSearch);
            }

            preparedStatement .setInt(index++, 10);
            preparedStatement .setInt(index++, offset);

            ResultSet resultSet = preparedStatement .executeQuery();

            while (resultSet.next()) {
                Order order = new Order();
                order.setOrderId(resultSet.getInt("order_id"));
                order.setUserId(resultSet.getInt("user_id"));
                order.setTotalAmount(resultSet.getDouble("total_amount"));
                order.setUsername(resultSet.getString("username"));
                order.setStatus(resultSet.getString("order_status"));
                order.setCreatedAt(resultSet.getString("created_at"));
                orderList.add(order);
            }
        }

        return orderList;
    }

    
    public int countOrdersForFilter(String orderStatus, String search) throws SQLException {


        StringBuilder query = new StringBuilder(
        		"SELECT o.order_id, o.user_id, o.total_amount, o.order_status, o.created_at, u.username " +
        			    "FROM orders o " +
        			    "JOIN users u ON o.user_id = u.user_id " +
        			    "LEFT JOIN order_items oi ON o.order_id = oi.order_id " +
        			    "LEFT JOIN menu m ON oi.menu_item_id = m.item_id " +
        			    "WHERE 1=1"
        );

        String patternSearch = null;

        if (orderStatus != null && !orderStatus.isEmpty()) {
        	
            query.append(" AND o.order_status = ?");
        }
        
        if(search != null && !search.isEmpty()) {
        	
			query.append(" AND (u.username LIKE ? OR m.item_name LIKE ?)");
			
			patternSearch = "%"+search+"%";
		}

        try (Connection con = DBConnection.buildConnection();
             PreparedStatement preparedStatement  = con.prepareStatement(query.toString())) {

            int index = 1;

            if (orderStatus != null && !orderStatus.isEmpty()) {
            	
                preparedStatement.setString(index++, orderStatus);
            }
            
            if (patternSearch != null) {
            	
            	preparedStatement .setString(index++, patternSearch); 
            	preparedStatement .setString(index++, patternSearch); 
            }

            ResultSet resultSet = preparedStatement.executeQuery();
            int rowsCount = 0;
			
			if (resultSet.next()) {
				
				rowsCount = resultSet.getInt(1);
				
			}
			
			return rowsCount;
        }
    }
}