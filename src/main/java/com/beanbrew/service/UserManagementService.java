package com.beanbrew.service;

import java.util.List;

import com.beanbrew.dao.ActivateUserDAO;
import com.beanbrew.dao.AdminPrivilegeDAO;
import com.beanbrew.dao.DisableUserDAO;
import com.beanbrew.dao.FetchAllUserDAO;
import com.beanbrew.dao.FetchUserBySearchFilter;
import com.beanbrew.dao.RemoveUserDAO;
import com.beanbrew.dao.VerifyUserDAO;
import com.beanbrew.model.User;

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
		
		return fau.getAllUser();		
	}
	
	public boolean removeUser(int userId) {
		
		boolean attempt = ru.removeUserByID(userId);
		
		return attempt;
		
	}
	
	public boolean verifyUser(int userId) {
		
		boolean attempt = vu.verifyUserById(userId);
		
		return attempt;
	}
	
	public boolean provideAdminPrivilege(int userId) {
		
		boolean attempt = apd.makeAdmin(userId);
		
		return attempt;
		
	}
	
	public boolean removeAdminPrivilege(int userId) {
			
			
			boolean attempt = apd.removeAdmin(userId);
			
			return attempt;
			
		}
	
	public List<User> fetchFilteredUser(int currentPageNumber, Boolean isAdmin, Boolean isVerified, String search){
		
			return fetchUserBySearchFilter.getUser(currentPageNumber, isAdmin, isVerified, search);
		
	}
	
	public int getTotalPages(Boolean isAdmin, Boolean isVerified, String search){
			
			int total = fetchUserBySearchFilter.countUserForFilter(isAdmin, isVerified, search);
			
			return (int) Math.ceil ((double) total/userPerPage);
			
		}
	
	public boolean disableUser(int userId) {
		
		boolean userStatus = disableUserDAO.disableUser(userId);
		
		
		return userStatus;
		
	}
	
	public boolean activateUser(int userId) {
			
			boolean userStatus = activateUserDAO.activateUser(userId);
			
			return userStatus;
			
		}
	
}
