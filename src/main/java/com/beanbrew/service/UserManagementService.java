package com.beanbrew.service;

import java.sql.SQLException;
import java.util.List;

import com.beanbrew.dao.ActivateUserDAO;
import com.beanbrew.dao.AdminPrivilegeDAO;
import com.beanbrew.dao.DisableUserDAO;
import com.beanbrew.dao.FetchAllUserDAO;
import com.beanbrew.dao.FetchUserBySearchFilter;
import com.beanbrew.dao.RemoveUserDAO;
import com.beanbrew.dao.VerifyUserDAO;
import com.beanbrew.model.User;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.ServiceExecutor;

public class UserManagementService {
	
	private FetchAllUserDAO fau = new FetchAllUserDAO();
	private FetchUserBySearchFilter fetchUserBySearchFilter = new FetchUserBySearchFilter();
	private RemoveUserDAO ru = new RemoveUserDAO();
	private VerifyUserDAO vu = new VerifyUserDAO();
	private AdminPrivilegeDAO apd = new AdminPrivilegeDAO();
	private DisableUserDAO disableUserDAO = new DisableUserDAO();
	private ActivateUserDAO activateUserDAO = new ActivateUserDAO();
	private static final int userPerPage = 10;
	
	
	public List<User> fetchUser(){
		
		try {
			return fau.getAllUser();
			
		} catch(SQLException e) {
			 
			e.printStackTrace();
			throw new ServiceException("Failed to load Data", e);
		}
				
	}
	
	public void removeUser(int userId) {
		
		ServiceExecutor.execute( 
				() -> ru.removeUserByID(userId), "User removal unsuccessful");
		}
	
	public void verifyUser(int userId) {
		
		ServiceExecutor.execute(
				() -> vu.verifyUserById(userId), "Failed to verify User");
		}
	
	public void provideAdminPrivilege(int userId) {
		
		ServiceExecutor.execute(
				() -> apd.makeAdmin(userId), "Failed to provide privilege");
	}
	
	public void removeAdminPrivilege(int userId) {
		
		ServiceExecutor.execute(
				()-> apd.removeAdmin(userId), "Failed to remove admin privilege" );
		
		}
	
	public List<User> fetchFilteredUser(int currentPageNumber, Boolean isAdmin, Boolean isVerified, String search){
		
			try {
				
				return fetchUserBySearchFilter.getUser(currentPageNumber, isAdmin, isVerified, search);
				
			} catch (SQLException e) {
				
				throw new ServiceException("Failed to Fetch User");
			}
		
	}
	
	public int getTotalPages(Boolean isAdmin, Boolean isVerified, String search){
		
		try {
			
			int total = fetchUserBySearchFilter.countUserForFilter(isAdmin, isVerified, search);
			
			return (int) Math.ceil ((double) total/userPerPage);
			
		} catch (SQLException e) {
			
			throw new ServiceException("Falied to Fetch User");
		}	
	}
	
	public void disableUser(int userId) {
		
		ServiceExecutor.execute(
				() -> disableUserDAO.disableUser(userId), "Failed to Disable user");
		
		
	}
	
	public void activateUser(int userId) {
		
		ServiceExecutor.execute(
				() -> activateUserDAO.activateUser(userId), "Failed to activate user");
			
	}
	
}
