package com.beanbrew.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

import com.beanbrew.model.User;
import com.beanbrew.service.SignupService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;

@WebServlet(asyncSupported = true, urlPatterns = { "/signup" })
@MultipartConfig
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public SignupServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/pages/Signup.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            String username = request.getParameter("username");
            String email    = request.getParameter("email");
            String password = request.getParameter("password");

            boolean usernameEmpty = (username == null || username.trim().isEmpty());
            boolean emailEmpty    = (email == null || email.trim().isEmpty());
            boolean passwordEmpty = (password == null || password.trim().isEmpty());

            // All fields empty
            if (usernameEmpty && emailEmpty && passwordEmpty) {
                request.setAttribute(MessageKeysUtil.ERROR, "All fields are required.");
                request.getRequestDispatcher("/WEB-INF/pages/Signup.jsp").forward(request, response);
                return;
            }

            boolean hasError = false;

            if (usernameEmpty) {
                request.setAttribute("errorUsername", "Username is required.");
                hasError = true;
            } else if (Character.isDigit(username.trim().charAt(0))) {
                request.setAttribute("errorUsername", "Username cannot start with a number.");
                hasError = true;
            }

            if (emailEmpty) {
                request.setAttribute("errorEmail", "Email is required.");
                hasError = true;
            } else if (!email.trim().matches("^[^@\\s]+@[^@\\s]+\\.[^@\\s]+$")) {
                request.setAttribute("errorEmail", "Please enter a valid email address.");
                hasError = true;
            }

            if (passwordEmpty) {
                request.setAttribute("errorPassword", "Password is required.");
                hasError = true;
            } else if (password.length() < 8) {
                request.setAttribute("errorPassword", "Password must be at least 8 characters.");
                hasError = true;
            }

            if (hasError) {
                request.setAttribute("username", username);
                request.setAttribute("email", email);
                request.getRequestDispatcher("/WEB-INF/pages/Signup.jsp").forward(request, response);
                return;
            }

            User user = new User();
            user.setUsername(username.trim());
            user.setEmail(email.trim());
            user.setPassword(password);
            user.setIsAdmin(Boolean.parseBoolean(request.getParameter("is_admin")));

            Part imagePart = request.getPart("profile_image");

            SignupService obj = new SignupService();
            obj.addUser(user, imagePart);

            response.sendRedirect(request.getContextPath() + "/login");

        } catch (ServiceException e) {
            request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
            request.getRequestDispatcher("/WEB-INF/pages/Signup.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}