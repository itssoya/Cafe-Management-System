package com.beanbrew.service;

import java.sql.SQLException;

import com.beanbrew.dao.LoginDAO;
import com.beanbrew.model.User;
import com.beanbrew.util.PasswordUtil;
import com.beanbrew.util.ServiceException;

public class LoginService {

    private final LoginDAO dao = new LoginDAO();

    public User validateUser(String username, String password) {

        try {

            User user = dao.login(username);

            if (user == null) {
                throw new ServiceException("Invalid username or password");
            }

            boolean isValidPassword =
                    PasswordUtil.checkHashPassword(password, user.getPassword());

            if (!isValidPassword) {
                throw new ServiceException("Invalid username or password");
            }

            return user;

        } catch (SQLException e) {
        	
        	e.printStackTrace();
            throw new ServiceException("Something went wrong! Please try again later", e);
        }
    }
}