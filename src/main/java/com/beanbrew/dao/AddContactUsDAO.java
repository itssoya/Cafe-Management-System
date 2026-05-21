package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.model.ContactUs;
import com.beanbrew.util.DBConnection;

public class AddContactUsDAO {
	
	private static final String query = "INSERT INTO contactus (name, email, subject, message) VALUES (?, ?, ?, ?)";
	
	public static boolean addContactDetails(ContactUs contactUs) throws SQLException {
			
			try (Connection con = DBConnection.buildConnection();
				PreparedStatement preparedStatement = con.prepareStatement(query)){
				
				preparedStatement.setString(1, contactUs.getName());
				preparedStatement.setString(2, contactUs.getEmail());
				preparedStatement.setString(3, contactUs.getSubject());
				preparedStatement.setString(4, contactUs.getMessage());
				
				int rowsAffected = preparedStatement.executeUpdate();
				
				return rowsAffected == 1;
			}
		}

}
