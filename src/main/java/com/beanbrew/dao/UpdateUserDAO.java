package com.beanbrew.dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
 
import com.beanbrew.model.User;
import com.beanbrew.util.DBConnection;
 
public class UpdateUserDAO {
 
    private static final String query_update = "UPDATE users SET username = ?, email_id = ?, profileimageurl = ? WHERE user_id = ?";
 
    private static final String query_password = "UPDATE users SET password = ? WHERE user_id = ?";
 
    public boolean updateProfile(User user) throws SQLException {
 
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement preparedStatement = con.prepareStatement(query_update)) {
 
        	preparedStatement.setString(1, user.getUsername());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getProfileImageURL());
            preparedStatement.setInt(4, user.getUserId());
 
            int rowsAffected = preparedStatement.executeUpdate();
            
            return rowsAffected == 1;
        }
    }
 
    public boolean updatePassword(int userId, String hashedPassword) throws SQLException {
 
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement preparedStatement = con.prepareStatement(query_password)) {
 
        	preparedStatement.setString(1, hashedPassword);
            preparedStatement.setInt(2, userId);
 
            int rowsAffected = preparedStatement.executeUpdate();
            
            return rowsAffected == 1;
        }
    }
}