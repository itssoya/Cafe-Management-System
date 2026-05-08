package com.beanbrew.service;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import com.beanbrew.dao.SignupDAO;
import com.beanbrew.model.User;
import com.beanbrew.util.PasswordUtil;
import com.beanbrew.util.TypeMismatchException;
import com.beanbrew.util.FileUploadUtil;
import com.beanbrew.util.ServiceException;


import jakarta.servlet.http.Part;

public class SignupService {
	
	private SignupDAO dao = new SignupDAO();

	private static final String UPLOAD_DIR = System.getProperty("user.home") + File.separator + "webapp_uploads";
	
	
	public void addUser(User user, Part imagePart)  {
		
		String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
		
		user.setPassword(hashedPassword);
		
		try {
			if(imagePart != null&& imagePart.getSize() > 0) {
				
				FileUploadUtil.isValidType(imagePart);
				
				if(FileUploadUtil.isImage(imagePart) ) {
				
					String extension = FileUploadUtil.getFileExtension(imagePart.getSubmittedFileName());
					String fileName = "Img_" + System.currentTimeMillis() + extension;
	                FileUploadUtil.saveFile(imagePart, UPLOAD_DIR, fileName);
	                
	                String imageUrl =  fileName;
	        		user.setProfileImageURL(imageUrl);
				
				}
			}
			
		} catch(TypeMismatchException e) {
				throw e;
			}
		catch(IOException e) {
			
			 e.printStackTrace();
			 throw new ServiceException("File Not Found");
		}
		
		
		try {
			
			if (!dao.signUp(user)) throw new ServiceException ("Failed to Register"); 
		}
		catch (SQLException e) {
			
			switch (e.getErrorCode()) {
			
			case 1062 ->
	            throw new ServiceException(
	                "Email already exists", e);

	        case 1048 ->
	            throw new ServiceException(
	                "Required field missing", e);

	        case 1406 ->
	            throw new ServiceException(
	                "Input is too long", e);

	        case 2002 ->
	            throw new ServiceException(
	                "Database server unavailable", e);

	        default ->
	            throw new ServiceException(
	                "Something went wrong", e);
			}
		}
		;
		
	}
}
