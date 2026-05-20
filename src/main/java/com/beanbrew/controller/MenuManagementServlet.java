package com.beanbrew.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.beanbrew.dao.FetchCategory;
import com.beanbrew.model.Category;
import com.beanbrew.model.MenuItem;
import com.beanbrew.service.MenuManagementService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;

/**
 * Servlet implementation class MenuManagementServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/menumanagement" })
public class MenuManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MenuManagementService menuManagementService = new MenuManagementService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MenuManagementServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String pageParam = request.getParameter("page");
		String search = request.getParameter("search");
		String categoryIdParam = request.getParameter("categoryId");
		
		int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) : 1;
		
		Integer categoryId = (categoryIdParam != null && !categoryIdParam.isEmpty()) ? Integer.parseInt(categoryIdParam) : null;
		
		
		try {
			
			List<Category> categories = FetchCategory.getAllcategory();
            List<MenuItem> menuItems  = menuManagementService.fetchMenuItem(categoryId, search, currentPage);
            int totalPages            = menuManagementService.countPageForFilter(categoryId, search);
            int totalItems            = menuManagementService.countAll();

            request.setAttribute("categories",  categories);
            request.setAttribute("menuItems",   menuItems);
            request.setAttribute("totalPage",   totalPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("search",      search);
            request.setAttribute("categoryId",  categoryId);
            request.setAttribute("totalItems",  totalItems);

			
		} catch (ServiceException e) {
			
			request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
			
		} catch (SQLException e) {
			
			request.setAttribute(MessageKeysUtil.ERROR, "Failed to load Menu");
		}
		
		request.getRequestDispatcher("/WEB-INF/pages/menumanagement.jsp") .forward(request, response); //
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		String action = request.getParameter("action");
		
		if("deleteMenu".equals(action)) {
			String idParam = request.getParameter("id");
			
			try {
				
                menuManagementService.deleteMenuItem(Integer.parseInt(idParam));
                request.setAttribute( MessageKeysUtil.SUCCESS, "Item deleted successfully.");
                
            } catch (ServiceException e) {
            	
                request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
                
            } catch (NumberFormatException e) {
            	
                request.setAttribute(MessageKeysUtil.ERROR, "Invalid item ID.");
            }
			
			response.sendRedirect(request.getContextPath() + "/menumanagement");
			return;
			
		}
		
		if ("editMenu".equals(action)) {
			
            String idParam = request.getParameter("id");
            
            try {
            	
                MenuItem item = menuManagementService.getMenuById(Integer.parseInt(idParam));
                
                if (item == null) {
                	
                    request.setAttribute( MessageKeysUtil.ERROR, "Item not found.");
                    response.sendRedirect(request.getContextPath() + "/menumanagement");
                    return;
                    
                }
                
                request.setAttribute("menuItem", item);
                request.getRequestDispatcher("/WEB-INF/pages/editmenu.jsp").forward(request, response);
                
            } catch (ServiceException e) {
            	
                request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
                response.sendRedirect(request.getContextPath() + "/menumanagement");
                
            }
            return;
        }
		doGet(request, response);
	}
	
}
