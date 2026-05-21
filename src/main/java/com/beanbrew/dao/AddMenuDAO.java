package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.model.MenuItem;
import com.beanbrew.util.DBConnection;

public class AddMenuDAO {

	private String query = "INSERT INTO menu ( item_name, category_id, item_price, item_description, item_img_url, file_extension, createdDate) "
			+ "VALUES (?, ?, ?, ?, ?, ?, now())";

	/**
	 * Adds a new menu item to the database.
	 *
	 * @param item The MenuItem object containing the name, category ID, price,
	 *             description, image URL, and file extension to be inserted.
	 * @return true if the menu item was successfully added (exactly one row
	 *         affected), false otherwise.
	 * @throws SQLException if a database access error occurs.
	 */

	public boolean addItem(MenuItem item) throws SQLException {

		try (Connection con = DBConnection.buildConnection();
				PreparedStatement preparedStatment = con.prepareStatement(query)) {

			preparedStatment.setString(1, item.getItemName());
			preparedStatment.setInt(2, item.getCategoryId());
			preparedStatment.setDouble(3, item.getPrice());
			preparedStatment.setString(4, item.getDescription());
			preparedStatment.setString(5, item.getImageUrl());
			preparedStatment.setString(6, item.getFileExtension());

			int rowsAffected = preparedStatment.executeUpdate();

			return rowsAffected == 1;

		}
	}
}
