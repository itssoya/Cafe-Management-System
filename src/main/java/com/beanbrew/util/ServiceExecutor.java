package com.beanbrew.util;

import java.sql.SQLException;

public class ServiceExecutor {
	
	@FunctionalInterface
	public interface DatabaseAction{
		public boolean executeAction() throws SQLException;
	}
	
	public static void execute(DatabaseAction action, String errorMessage) {
		
		try {
			
			if(!action.executeAction()) {
				 throw new ServiceException(errorMessage);
				 
			}
		} catch (SQLException e) {
			
			e.printStackTrace();
			throw new ServiceException(errorMessage, e);
		}
		
	}

}
