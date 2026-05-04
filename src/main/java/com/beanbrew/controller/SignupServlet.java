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

/**
 * Servlet implementation class SignupServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/signup" })
@MultipartConfig
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/Signup.jsp");
		rd.forward(request,response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		try {
			
			User user = new User();
			user.setUsername(request.getParameter("username"));
			user.setEmail(request.getParameter("email_id"));
			user.setPassword(request.getParameter("password"));
			user.setIsAdmin(Boolean.parseBoolean(request.getParameter("is_admin")));
			
			Part imagePart = request.getPart("profile_image");
		
			SignupService obj = new SignupService();
			obj.addUser(user, imagePart);
		
			response.getWriter().println("Registered successfully!");
			
		/*doGet(request, response);*/
		}
		
		catch(Exception e) {
			e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
		}
		
	}	
	

}
