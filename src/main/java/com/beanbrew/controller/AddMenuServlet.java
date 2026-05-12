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
import java.util.List;

import com.beanbrew.model.MenuItem;
import com.beanbrew.model.User;
import com.beanbrew.service.AddMenuService;
import com.beanbrew.service.UserManagementService;

/**
 * Servlet implementation class AddMenuServlet
 */
@MultipartConfig
@WebServlet(asyncSupported = true, urlPatterns = { "/addmenu" })
public class AddMenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddMenuServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/addmenu.jsp");
		rd.forward(request, response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		MenuItem menuItem = new MenuItem();
		
		menuItem.setItemName(request.getParameter("itemName"));
		menuItem.setCategory(request.getParameter("category"));
		menuItem.setPrice(Double.parseDouble(request.getParameter("price")));
		menuItem.setDescription(request.getParameter("description"));
		//menuItem.setImage(request.getPart("image"));
		
		Part imagePart = request.getPart("image");
		String category = request.getParameter("category");
		
		AddMenuService service = new AddMenuService();
	    boolean result = service.addItem(menuItem, imagePart, category);
	    
	    if(result){
	        response.getWriter().println("Item Added Successfully");
	    } else {
	        response.getWriter().println("Failed to Add Item");
	    }
	}

}
