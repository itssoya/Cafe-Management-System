package com.beanbrew.dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
 
import com.beanbrew.model.MenuItem;
import com.beanbrew.util.DBConnection;
 
public class UpdateMenuDAO {
 
    private static final String query = "UPDATE menu SET item_name = ?, category_id = ?, item_price = ?, " +
    									"item_description = ?, item_img_url = ?, file_extension = ? " +
    									"WHERE item_id = ?";
 
    public boolean updateItem(MenuItem item) throws SQLException {
 
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement preparedStatement = con.prepareStatement(query)) {
 
        	preparedStatement .setString(1, item.getItemName());
        	preparedStatement .setInt(2, item.getCategoryId());
        	preparedStatement .setDouble(3, item.getPrice());
        	preparedStatement .setString(4, item.getDescription());
        	preparedStatement .setString(5, item.getImageUrl());
            preparedStatement .setString(6, item.getFileExtension());
            preparedStatement .setInt(7, item.getItemId());
 
            int rowsAffected = preparedStatement.executeUpdate();
            
            return rowsAffected == 1;
        }
    }
}