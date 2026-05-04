package com.beanbrew.service;

import java.io.File;

import com.beanbrew.dao.SignupDAO;
import com.beanbrew.model.User;
import com.beanbrew.util.PasswordUtil;
import com.beanbrew.util.FileUploadUtil;


import jakarta.servlet.http.Part;

public class SignupService {
	

	private static final String UPLOAD_DIR = System.getProperty("user.home") + File.separator + "webapp_uploads";
	
	
	public void addUser(User user, Part imagePart) throws Exception {
		
		String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
		
		user.setPassword(hashedPassword);
		
		if(imagePart != null&& imagePart.getSize() > 0) {
			
			if(FileUploadUtil.isImage(imagePart) && FileUploadUtil.isValidType(imagePart)) {
			
				String extension = FileUploadUtil.getFileExtension(imagePart.getSubmittedFileName());
				String fileName = "Img_" + System.currentTimeMillis() + extension;
                FileUploadUtil.saveFile(imagePart, UPLOAD_DIR, fileName);
                
                String imageUrl =  fileName;
        		user.setProfileImageURL(imageUrl);
			
			}
		}
		
		SignupDAO dao = new SignupDAO();
		dao.signUp(user);
		
	}
}
