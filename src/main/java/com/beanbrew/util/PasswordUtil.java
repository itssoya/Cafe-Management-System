package com.beanbrew.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
	
	public static String hashPassword(String Password) {
		
		String newHashPassword = BCrypt.hashpw(Password, BCrypt.gensalt(12));
		
		return newHashPassword ;
	}
	
	public static boolean checkHashPassword(String plainTextPassword, String hashedPassword) {
		
		boolean checkingHashPassword = BCrypt.checkpw(plainTextPassword, hashedPassword);
		
		return checkingHashPassword;
	}

}
