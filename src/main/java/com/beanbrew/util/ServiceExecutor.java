package com.beanbrew.util;

import java.sql.SQLException;

public class ServiceExecutor {
	
	@FunctionalInterface
	public interface DatabaseAction <T>{
		public T executeAction() throws SQLException;
	}
	
	/*@FunctionalInterface
	public interface DatabaseQuery{
		
	}*/
	
	public static <T> T execute(DatabaseAction <T> action, String errorMessage) {
		
		try {

            return action.executeAction();

        } catch (SQLException e) {

            e.printStackTrace();
            throw new ServiceException(errorMessage, e);
        }
    }

}
