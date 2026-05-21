package com.beanbrew.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.util.List;

import com.beanbrew.model.Order;
import com.beanbrew.model.User;
import com.beanbrew.service.UserDashboardService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.SessionUtil;

/**
 * Servlet implementation class UserDashboard
 */
@WebServlet("/UserDashboard")
public class UserDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserDashboardService userDashboardService = new UserDashboardService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserDashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		User currentUser = SessionUtil.getAttribute(request, "currentUser", User.class);
		
        if (currentUser == null) {
        	
            response.sendRedirect(request.getContextPath() + "/login");
            return;
            
        }
 
        String pageParam = request.getParameter("page");
        
        int currentPage  = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;
 
        try {
            
            User freshUser = userDashboardService.getUserById(currentUser.getUserId());
 
            List<Order> orders = userDashboardService.getUserOrders(currentUser.getUserId(), currentPage);
            int totalPages = userDashboardService.getTotalPages(currentUser.getUserId());
 
            request.setAttribute("currentUser", freshUser);
            request.setAttribute("orders", orders);
            request.setAttribute("totalPage",totalPages);
            request.setAttribute("currentPage", currentPage);
 
        } catch (ServiceException e) {
        	
            request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
        }
 
        request.getRequestDispatcher("/WEB-INF/pages/userdashboard.jsp")
               .forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		User currentUser = SessionUtil.getAttribute(request, "currentUser", User.class);
		
        if (currentUser == null) {
        	
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
 
        String action = request.getParameter("action");
        
        int userId    = currentUser.getUserId();
 
        if ("updateProfile".equals(action)) {
        	
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String existingImageUrl = request.getParameter("existingImageUrl");
            Part   imagePart  = request.getPart("profileImage");
 
            try {
            	
                User updatedUser = userDashboardService.updateProfile( userId, username, email, imagePart, existingImageUrl);
 
                
                SessionUtil.setAttribute(request, "currentUser", updatedUser);
                response.sendRedirect(request.getContextPath()
                        + "/userdashboard?success=Profile updated successfully.");
                
 
            } catch (ServiceException e) {
            	
                request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
                response.sendRedirect(request.getContextPath() + "/userdashboard");
                return;
            }
            
            return;
        }
 
        if ("deactivateAccount".equals(action)) {
            try {
                userDashboardService.disableUser(userId);
                
                SessionUtil.invalidateSession(request);
                response.sendRedirect(request.getContextPath() + "/login");
 
            } catch (ServiceException e) {
            	
                request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
                response.sendRedirect(request.getContextPath() + "/userdashboard");
                
            }
            return;
        }
 
        response.sendRedirect(request.getContextPath() + "/userdashboard");
	}

}
