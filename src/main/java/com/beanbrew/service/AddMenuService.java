package com.beanbrew.service;

import com.beanbrew.dao.AddMenuDAO;
import com.beanbrew.model.MenuItem;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

public class AddMenuService {
	
	public boolean addItem(MenuItem item, HttpServletRequest request) {
		
		try {
		
		Part imgPart = item.getImage();
		
		String orginalName = imgPart.getSubmittedFileName().trim();
		String extension = orginalName.substring(orginalName.lastIndexOf("."));
		
		String imgName = "Img_" + System.currentTimeMillis() + extension;
		
		String directoryPath = "C:/Users/eliti/eclipse-workspace/Cafe_Management_System/src/main/webapp/Product_Image{id}";
		
		System.out.println("File is being saved to : " + directoryPath);
		
		imgPart.write(directoryPath + java.io.File.separator + imgName);
		
		String imageUrl = "Product_Image/" + imgName;
		item.setImageUrl(imageUrl);
		
		item.setFileExtension(extension);
		
		AddMenuDAO addMenuDAO = new AddMenuDAO();
		boolean success = addMenuDAO.addItem(item);
		
		return success;
		
		} catch (Exception e) {
			
			 e.printStackTrace();
			 
			 return false;
		}
		
	}

}
