package com.beanbrew.service;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.beanbrew.dao.DisableUserDAO;
import com.beanbrew.dao.FetchUserByIdDAO;
import com.beanbrew.dao.FetchUserOrdersDAO;
import com.beanbrew.dao.UpdateUserDAO;
import com.beanbrew.model.Order;
import com.beanbrew.model.User;
import com.beanbrew.util.FileUploadUtil;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.ServiceExecutor;
import com.beanbrew.util.TypeMismatchException;

import jakarta.servlet.http.Part;

public class UserDashboardService {
	
	private static final int order_per_page = 5;
    private static final String UPLOAD_DIR = System.getProperty("user.home") + File.separator + "webapp_uploads/user_img";
    private FetchUserByIdDAO  fetchUserDAO  = new FetchUserByIdDAO();
    private UpdateUserDAO     updateUserDAO = new UpdateUserDAO();
    private FetchUserOrdersDAO ordersDAO    = new FetchUserOrdersDAO();
    private DisableUserDAO    disableUserDAO = new DisableUserDAO();
	
	public void disableUser(int userId) {
			
			ServiceExecutor.execute(
					() -> disableUserDAO.disableUser(userId), "Failed to Delete account");
			
			
		}
	
	public int getTotalPages(int userId){
		
		int total = ServiceExecutor.execute(
				() -> ordersDAO.countOrdersByUserId(userId), "Falied to Fetch order");
		
		return (int) Math.ceil ((double) total/order_per_page);
		
	}
	
		public User getUserById(int userId) {
			
		    return ServiceExecutor.execute(
		    		() -> { User user = fetchUserDAO.getUserById(userId);
		        if (user == null) {throw new ServiceException("User not found.");}
		        
		        return user;
		        
		    }, "Failed to load user profile.");
		}
	 
	    public User updateProfile(int userId, String username, String email, Part imagePart, String existingImageUrl) {
	    	
	        try {
	        	
	            if (username == null || username.trim().isEmpty()) throw new ServiceException("Username cannot be empty.");
	            
	            if (email == null || email.trim().isEmpty()) throw new ServiceException("Email cannot be empty.");
	 
	            User user = fetchUserDAO.getUserById(userId);
	            if (user == null) throw new ServiceException("User not found.");
	 
	            user.setUsername(username.trim());
	            
	            user.setEmail(email.trim());
	 
	            if (imagePart != null && imagePart.getSize() > 0) {
	            	
	                try {
	                	
	                    FileUploadUtil.isValidType(imagePart);
	                    if (FileUploadUtil.isImage(imagePart)) {
	                    	
	                        String extension = FileUploadUtil.getFileExtension(imagePart.getSubmittedFileName());
	                        String fileName = "profile_" + userId + "_"
	                        		
	                                + System.currentTimeMillis() + extension;
	                        FileUploadUtil.saveFile(imagePart, UPLOAD_DIR, fileName);
	                        user.setProfileImageURL(fileName);
	                        
	                    }
	                    
	                } catch (TypeMismatchException e) {
	                	
	                    throw new ServiceException("Only image files are allowed.");
	                    
	                } catch (IOException e) {
	                	
	                    throw new ServiceException("Failed to save profile image.");
	                }
	            } else {
	            	
	                user.setProfileImageURL(existingImageUrl);
	                
	            }
	 
	            boolean success = updateUserDAO.updateProfile(user);
	            
	            if (!success) throw new ServiceException("Failed to update profile.");
	 
	            return user; 
	 
	        } catch (SQLException e) {
	        	
	            throw new ServiceException("Something went wrong");
	        }
	    }
	    
	    public List<Order> getUserOrders(int userId, int currentPage) {
	    	
	        return ServiceExecutor.execute(
	        		
	        		() ->  ordersDAO.getOrdersByUserId(userId, currentPage, order_per_page),
	        		"Failed to load orders."
	        );
	    }
	    

}
