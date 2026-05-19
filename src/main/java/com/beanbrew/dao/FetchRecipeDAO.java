package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.beanbrew.model.RecipeItem;
import com.beanbrew.util.DBConnection;

public class FetchRecipeDAO {
	
	private static final String query = "SELECT * FROM recipe WHERE menu_item_id = ?";

	    public List<RecipeItem> getRecipeByMenuItemId(int menuItemId) throws SQLException {

	        List<RecipeItem> recipe = new ArrayList<>();

	        try (Connection con = DBConnection.buildConnection();
	             PreparedStatement preparedStatement = con.prepareStatement(query)) {

	        	preparedStatement .setInt(1, menuItemId);
	            ResultSet resultSet = preparedStatement .executeQuery();

	            while (resultSet.next()) {
	                RecipeItem item = new RecipeItem();
	                item.setStockItemId(resultSet.getInt("stock_item_id"));
	                item.setMenuItemId(resultSet.getInt("menu_item_id"));
	                item.setQuantityUsed(resultSet.getDouble("quantity_used"));
	                recipe.add(item);
	            }
	        }
	        return recipe;
	    }

}
