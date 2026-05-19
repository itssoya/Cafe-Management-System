package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import com.beanbrew.model.OrderItem;
import com.beanbrew.util.DBConnection;

public class AddOrderItems {
	
	 private static final String query = "INSERT INTO order_items (order_id, menu_item_id, quantity) VALUES (?, ?, ?)";
	 
	 /**
	  * Adds multiple order items to the database for a given order.
	  *
	  * @param orderId The unique identifier of the order to which the items belong.
	  * @param items   A list of OrderItem objects containing the menu item ID and quantity
	  *                to be inserted.
	  * @return true if the order items were successfully added, false otherwise.
	  * @throws SQLException if a database access error occurs.
	  */
	 
	 public boolean addOrder(int orderId, List<OrderItem> items) throws SQLException {
		 
		 try(Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(query)){
					
			 for (OrderItem item : items) {

				 preparedStatement.setInt(1, orderId);
				 preparedStatement.setInt(2, item.getMenuItemId());
				 preparedStatement.setInt(3, item.getQuantity());

				 preparedStatement.addBatch();
			    }

			 preparedStatement.executeBatch();

			    return true;
	 }
	 }
}
