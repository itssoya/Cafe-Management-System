package com.beanbrew.dao;
 
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
 
import com.beanbrew.model.User;
import com.beanbrew.util.DBConnection;
 
public class FetchUserByIdDAO {
 
    private static final String query = "SELECT * FROM users WHERE user_id = ?";
 
    public User getUserById(int userId) throws SQLException {
 
        try (Connection con = DBConnection.buildConnection();
             PreparedStatement preparedStatement = con.prepareStatement(query)) {
 
        	preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
 
            if (resultSet.next()) {
            	
                User user = new User();
                user.setUserId(resultSet.getInt("user_id"));
                user.setUsername(resultSet.getString("username"));
                user.setEmail(resultSet.getString("email_id"));
                user.setPassword(resultSet.getString("password"));
                user.setProfileImageURL(resultSet.getString("profileimageurl"));
                user.setCreatedAt(resultSet.getString("created_at"));
                user.setIsAdmin(resultSet.getBoolean("is_admin"));
                user.setIsVerified(resultSet.getBoolean("is_verified"));
                user.setIsActive(resultSet.getBoolean("active_status"));
                
                return user;
            }
            return null;
        }
    }
}