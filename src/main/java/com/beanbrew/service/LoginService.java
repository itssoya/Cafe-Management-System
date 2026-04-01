package com.beanbrew.service;

import com.beanbrew.dao.LoginDAO;
import com.beanbrew.model.User;
import com.beanbrew.util.PasswordUtil;

public class LoginService{
	
	private LoginDAO dao = new LoginDAO();
	
	public User validateUser(String username, String password) {
		
		User user = dao.login(username);
		boolean validatePassword = PasswordUtil.checkHashPassword(password, user.getPassword());
		
		if(user != null && validatePassword  ) {
			
			return user;
		}
		
		return null;
	}
}