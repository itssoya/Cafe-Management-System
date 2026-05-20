package com.beanbrew.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.beanbrew.dao.AddRecipeDAO;
import com.beanbrew.dao.CheckStockItemDAO;
import com.beanbrew.dao.RemoveCategoryDAO;
import com.beanbrew.model.RecipeItem;
import com.beanbrew.model.StockItem;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.ServiceExecutor;

public class RecipeManagementService {
	
	public void addRecipe(int menuItemId, List<String> ingredientNames, List<Double> ingredientQtys) {
		
		if (ingredientNames == null || ingredientNames.isEmpty())
            throw new ServiceException("At least one ingredient is required.");

        if (ingredientNames.size() != ingredientQtys.size())
            throw new ServiceException("Please!! Enter the same Number of Quantity and Ingredients");
        
        List<RecipeItem> ingredients = new ArrayList<>();

        for (int i = 0; i < ingredientNames.size(); i++) {

            String name = ingredientNames.get(i).trim();
            double qty  = ingredientQtys.get(i);

            if (name.isEmpty())
                throw new ServiceException("Ingredient name cannot be empty.");

            if (qty <= 0)
                throw new ServiceException(
                    "Quantity for '" + name + "' must be greater than 0."
                );
            try {
                
                StockItem stockItem = CheckStockItemDAO.checkStock(name);

                if (stockItem == null)
                    throw new ServiceException(
                        "Ingredient '" + name + "' not found in stock. Add it first."
                    );

                RecipeItem recipeItem = new RecipeItem();
                recipeItem.setMenuItemId(menuItemId);
                recipeItem.setStockItemId(stockItem.getId()); 
                recipeItem.setQuantityUsed(qty);
                ingredients.add(recipeItem);

            } catch (SQLException e) {
                throw new ServiceException("Database error checking: " + name);
            }
        }
            
            try {
            	AddRecipeDAO.addRecipes(menuItemId, ingredients);

            } catch (SQLException e) {
            	switch (e.getErrorCode()) {

    	        case 1048 ->
    	            throw new ServiceException(
    	                "Required field missing", e);

    	        case 1406 ->
    	            throw new ServiceException(
    	                "Input is too long", e);

    	        default ->
    	            throw new RuntimeException(
    	                "Something went wrong", e);
    			}
            }
	
	}
	
}
