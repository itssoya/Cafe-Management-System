package com.beanbrew.service;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import com.beanbrew.dao.AddMenuDAO;
import com.beanbrew.dao.CheckCategoryDAO;
import com.beanbrew.model.Category;
import com.beanbrew.model.MenuItem;
import com.beanbrew.util.FileUploadUtil;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.TypeMismatchException;

import jakarta.servlet.http.Part;

public class AddMenuService {
	
	private static final String UPLOAD_DIR = System.getProperty("user.home") + File.separator + "webapp_uploads/menu_items";
	
	public void addItem(MenuItem item, Part imagePart, String categoryName) {
		
		try {
			if(imagePart != null&& imagePart.getSize() > 0) {
				
				FileUploadUtil.isValidType(imagePart);
				
				if(FileUploadUtil.isImage(imagePart) ) {
				
					String extension = FileUploadUtil.getFileExtension(imagePart.getSubmittedFileName());
					String fileName = "Img_" + System.currentTimeMillis() + extension;
	                FileUploadUtil.saveFile(imagePart, UPLOAD_DIR, fileName);
	                
	                String imageUrl =  fileName;
	        		item.setImageUrl(imageUrl);
				
				}
			}
			
		} catch(TypeMismatchException e) {
			
				throw e;
				
		}catch(IOException e) {
			
			 e.printStackTrace();
			 throw new ServiceException("File Not Found");
		}
		
		
		try {
			
			Category categoryOBJ = CheckCategoryDAO.checkCatgeory(categoryName);
			
			if(categoryOBJ == null) throw new ServiceException("Category doesn't exists");
			
			if(!categoryOBJ.isActiveStatus()) throw new ServiceException("Category is not active");
			
			item.setCategoryId(categoryOBJ.getCategoryId());
		
		
		} catch (SQLException e) {
			
			 throw new ServiceException("Database error checking category.");
		}
		
		try {
			
			AddMenuDAO addMenuDAO = new AddMenuDAO();
			boolean success = addMenuDAO.addItem(item);
			
			if(!success)throw new ServiceException("Failed to save menu item. Please try again.");
			
			
		} catch (SQLException e) {
			
			switch (e.getErrorCode()) {
            case 1062 -> throw new ServiceException("A menu item with this name already exists.");
            case 1048 -> throw new ServiceException("Required field missing.");
            case 1406 -> throw new ServiceException("Input value is too long.");
            default   -> throw new RuntimeException("Unexpected database error.", e);
        }	
		}
	}
}
