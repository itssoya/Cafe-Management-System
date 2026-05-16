package com.beanbrew.controller;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.beanbrew.model.Category;
import com.beanbrew.service.CategoryManagementService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;

/**
 * Servlet implementation class AddCategory
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/addcategory" })
public class AddCategory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCategory() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String categoryName = request.getParameter("categoryName").trim().toLowerCase();
		String description = request.getParameter("categoryDescription").trim();
		String activeStatus = request.getParameter("activeStatus");
		
		if (categoryName == null || categoryName.trim().isEmpty()
			|| description == null || description.trim().isEmpty()) {
            
			request.setAttribute(MessageKeysUtil.ERROR, "All fields required");
			request.getRequestDispatcher("/WEB-INF/pages/").forward(request, response);
			
        }
		
		 Category category = new Category();
		 category.setCategoryName(categoryName);
		 category.setDescription(description);
		 category.setActiveStatus(Boolean.parseBoolean(activeStatus));
		 
		 try {
			 
			 CategoryManagementService categoryManagementService = new CategoryManagementService();
			 categoryManagementService.addCategory(category);
		 }catch(ServiceException e) {
			 
			 request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
			 request.getRequestDispatcher("/WEB-INF/pages/").forward(request, response);
		 }
		 
		//doGet(request, response);
	}

}
