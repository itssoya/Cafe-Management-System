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
	
	/**
	 * Adds a new stock item record to the database.
	 *
	 * @param item The StockItem object containing the name, unit, quantity in stock,
	 *             low stock threshold, and bakery flag to be inserted.
	 * @return true if the stock item was successfully added (exactly one row affected),
	 *         false otherwise.
	 * @throws SQLException if a database access error occurs.
	 */
	
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
