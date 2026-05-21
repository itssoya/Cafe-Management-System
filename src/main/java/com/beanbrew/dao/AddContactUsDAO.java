package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.beanbrew.model.ContactUs;
import com.beanbrew.util.DBConnection;

public class AddContactUsDAO {
	
	private static final String query = "INSERT INTO contactus (name, email, subject, message) VALUES (?, ?, ?, ?)";
	
	/**
	 * Inserts a new contact inquiry into the database.
	 *
	 * @param contactUs The ContactUs object containing the name, email, subject,
	 *                  and message details to be stored.
	 * @return true if the contact details were successfully added (exactly one row affected),
	 *         false otherwise.
	 * @throws SQLException if a database access error occurs.
	 */
	
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
