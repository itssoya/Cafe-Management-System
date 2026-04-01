package com.beanbrew.service;

import com.beanbrew.dao.SignupDAO;
import com.beanbrew.model.User;
import com.beanbrew.util.PasswordUtil;

public class SignupService {
	
	public void addUser(User user) throws Exception {
		
		String hashedPassword = PasswordUtil.hashPassword(user.getPassword());
		
		user.setPassword(hashedPassword);
		
		SignupDAO dao = new SignupDAO();
		dao.signUp(user);
		
	}
}
