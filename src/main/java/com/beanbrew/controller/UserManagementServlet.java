package com.beanbrew.controller;


import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.beanbrew.model.User;
import com.beanbrew.service.UserManagementService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.SessionUtil;

/**
 * Servlet implementation class AuthenticateUserServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/usermanagement" })
public class UserManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserManagementService userManagementService = new UserManagementService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserManagementServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String search = request.getParameter("search");
		String isAdminParam = request.getParameter("isAdmin");
		String isVerifiedParam = request.getParameter("isVerified");
		String pageParam = request.getParameter("page");
		
		Boolean isAdmin = (isAdminParam != null && !isAdminParam.isEmpty()) ? Boolean.parseBoolean(isAdminParam) : null;
		Boolean isVerified = (isVerifiedParam != null && !isVerifiedParam.isEmpty()) ? Boolean.parseBoolean(isVerifiedParam) : null;
		int page = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) :  1;
		
		
		
		List<User> users = userManagementService.fetchUser();
		
		int total = users.size();
		long verified = users.stream().filter(User::isVerified).count();
		long pending = total-verified;
		long admins = users.stream().filter(User::isAdmin).count();
		long pendingPercent = 0;
		
		if (total != 0) {
			pendingPercent = Math.round((pending * 100.0) / total);
		}
		
		try {
			
			List<User> fetchFilteredUser = userManagementService.fetchFilteredUser(page, isAdmin,  isVerified,  search);
			int totalPages = userManagementService.getTotalPages(isAdmin, isVerified, search);
			
			request.setAttribute("Users", fetchFilteredUser);
			request.setAttribute("totalPages", totalPages);
			request.setAttribute("page", page);
			
			request.setAttribute("totalUsers", total);
			request.setAttribute("verifiedUser", verified);
			request.setAttribute("pendingUser", pending);
			request.setAttribute("pendingPercent", pendingPercent);
			request.setAttribute("totalAdmin", admins);
			
		} catch(ServiceException e) {
			
			SessionUtil.setAttribute(request, MessageKeysUtil.ERROR, e.getMessage());
		}
		
		request.setAttribute("search",         search != null ? search : "");
		request.setAttribute("filterVerified", isVerifiedParam != null ? isVerifiedParam : "");
		request.setAttribute("filterAdmin",    isAdminParam    != null ? isAdminParam    : "");
		request.setAttribute("currentPage",    page);
		
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/UserManagement.jsp");
		rd .forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String action = request.getParameter("action");
        int userId = Integer.parseInt(request.getParameter("userId"));
        
        if ( action == null || action.isBlank()) {
        	
        	SessionUtil.setAttribute(request, MessageKeysUtil.ERROR, "Invalid action.");
        }
        
        try {
        	switch(action) {
	        case "verify" -> userManagementService.verifyUser(userId);
	        case "makeAdmin" -> userManagementService.provideAdminPrivilege(userId);
	        case "removeAdmin" -> userManagementService.removeAdminPrivilege(userId);
	        case "removeUser" -> userManagementService.removeUser(userId);
	        case "makeActive" -> userManagementService.activateUser(userId);
	        case "removeActive" -> userManagementService.disableUser(userId);
	        default -> {
	        	
	        	SessionUtil.setAttribute(request, MessageKeysUtil.ERROR, "Unknown action: " + action);
                response.sendRedirect(request.getContextPath() + "/usermanagement");
                return;
            }
        }
        	
        request.getSession().setAttribute(MessageKeysUtil.SUCCESS, "Action applied successfully.");
        
        } catch (ServiceException e) {
        	
        	SessionUtil.setAttribute(request, MessageKeysUtil.ERROR, e.getMessage());
        }
       
        response.sendRedirect(request.getContextPath() + "/usermanagement");

	}

}
