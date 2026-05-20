package com.beanbrew.service;

import java.sql.SQLException;

import com.beanbrew.dao.AddCategoryDAO;
import com.beanbrew.model.Category;
import com.beanbrew.util.ServiceException;

public class CategoryManagementService {
	
	public void addCategory(Category category) {
	        
	        try {
	            boolean success = AddCategoryDAO.addNewCategory(category);
	            
	            if (!success) {
	                throw new ServiceException("Failed to add category. Please try again.");
	            }
	            
	        } catch (SQLException e) {
	            
	            switch (e.getErrorCode()) {
	                
	                case 1062 -> {
	                    String msg = e.getMessage().toLowerCase();
	                    if (msg.contains("name")) {
	                        throw new ServiceException("Category name already exists.", e);
	                    }
	                }
	                
	                case 1048 ->
	                    throw new ServiceException("Required field missing.", e);
	                
	                case 1406 ->
	                    throw new ServiceException("Input value is too long.", e);
	                
	                default ->
	                    throw new RuntimeException("Unexpected database error occurred.", e);
	            }
	        }
	    }

}
