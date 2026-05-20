package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import com.beanbrew.model.RecipeItem;
import com.beanbrew.util.DBConnection;

public class AddRecipeDAO {
	
	public static boolean addRecipes(int menuItemId, List<RecipeItem> ingredients)
	        throws SQLException {

	    try (Connection con = DBConnection.buildConnection()) {
	        con.setAutoCommit(false);

	        try (PreparedStatement ps = con.prepareStatement(
	                "INSERT INTO recipe (menu_item_id, stock_item_id, quantity_used) VALUES (?, ?, ?)")) {

	            for (RecipeItem ingredient : ingredients) {
	                ps.setInt(1, menuItemId);
	                ps.setInt(2, ingredient.getStockItemId());
	                ps.setDouble(3, ingredient.getQuantityUsed());
	                ps.addBatch();
	            }

	            ps.executeBatch();
	            con.commit();
	            return true;

	        } catch (SQLException e) {
	            con.rollback();
	            throw e;
	        }
	    }
	}

}
