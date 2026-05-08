package com.beanbrew.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.beanbrew.model.User;
import com.beanbrew.service.LoginService;
import com.beanbrew.util.SessionUtil;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/login" })
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/pages/Login.jsp");
		rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");
	
		try {
			
			LoginService service = new LoginService();
			User user = service.validateUser(username, password);
			
			if(user != null){
				
				SessionUtil.setAttribute(request, "currentUser", user, 3600);
				response.sendRedirect(request.getContextPath() + "/index");
				
			} else{
				
				request.setAttribute("errorMessage", "Invalid username or password");
				RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/pages/Login.jsp");
				rd.forward(request, response);
				
			}	
			
		} catch(Exception e) {
			
			e.printStackTrace();
			request.setAttribute("errorMessage", "Something went wrong. Please try again");
			RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/pages/Login.jsp");
			rd.forward(request, response);
		}
		
		
		//doGet(request, response);
	}

}
