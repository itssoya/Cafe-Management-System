package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.model.StockItem;
import com.beanbrew.util.DBConnection;

public class AddStockItem {
	
	private static final String INSERT_STOCK_ITEM =
	        "INSERT INTO stock_items (name, unit, quantity_in_stock, updated_at) " +
	        "VALUES (?, ?, ?, now())";
	
	public static boolean addStockItem(StockItem item) throws SQLException{
		
		try (Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(INSERT_STOCK_ITEM)) {
			
			con.setAutoCommit(false);

			preparedStatement.setString(1, item.getName());
            preparedStatement.setString(2, item.getUnit());
            preparedStatement.setDouble(3, item.getQuantityInStock());

            int rowsAffected= preparedStatement.executeUpdate();


           return rowsAffected == 1;
        }
	}
}
