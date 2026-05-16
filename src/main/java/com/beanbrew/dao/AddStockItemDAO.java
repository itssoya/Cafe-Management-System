package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.model.StockItem;
import com.beanbrew.util.DBConnection;

public class AddStockItemDAO {
	
	private static final String INSERT_STOCK_ITEM =
	        "INSERT INTO stock_items (stock_name, stock_unit, quantity_in_stock, updated_at, low_stock_threshold, is_bakery) " +
	        "VALUES (?, ?, ?, now(),?,?)";
	
	public boolean addStockItem(StockItem item) throws SQLException{
		
		try (Connection con = DBConnection.buildConnection();
			PreparedStatement preparedStatement = con.prepareStatement(INSERT_STOCK_ITEM)) {

			preparedStatement.setString(1, item.getName());
            preparedStatement.setString(2, item.getUnit());
            preparedStatement.setDouble(3, item.getQuantityInStock());
            preparedStatement.setDouble(4, item.getLowStockThreshold());
            preparedStatement.setBoolean(5, item.isBakery());

            int rowsAffected= preparedStatement.executeUpdate();


           return rowsAffected == 1;
        }
	}
}
