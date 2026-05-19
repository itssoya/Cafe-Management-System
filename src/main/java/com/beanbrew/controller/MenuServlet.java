package com.beanbrew.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import com.beanbrew.model.Cart;
import com.beanbrew.model.Category;
import com.beanbrew.model.MenuItem;
import com.beanbrew.model.User;
import com.beanbrew.service.MenuService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.SessionUtil;

/**
 * Servlet implementation class MenuServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/menu" })
public class MenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private MenuService menuService = new MenuService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MenuServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    @SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String search          = request.getParameter("search");
        String pageParam       = request.getParameter("page");
        String categoryIdParam = request.getParameter("categoryId");
 
        int currentPage = (pageParam != null && !pageParam.isEmpty())
                ? Integer.parseInt(pageParam) : 1;
 
        Integer categoryId = (categoryIdParam != null && !categoryIdParam.isEmpty())
                ? Integer.parseInt(categoryIdParam) : null;
 
        try {
            // Fetch menu items
            List<MenuItem> menuItems = menuService.getMenuItems(categoryId, search, currentPage);
            int totalPages           = menuService.getTotalPages(categoryId, search);
 
            // Fetch active categories for filter tabs
            List<Category> categories = menuService.getActiveCategories();
 
 
            List<Cart> cart = SessionUtil.getAttribute(request, "cart", List.class);
            int cartCount   = (cart != null) ? cart.size() : 0;
 
            // Current logged in user (null if not logged in)
            User currentUser = SessionUtil.getAttribute(request, "currentUser", User.class);
 
            request.setAttribute("menuItems",   menuItems);
            request.setAttribute("categories",  categories);
            request.setAttribute("totalPage",   totalPages);
            request.setAttribute("currentPage", currentPage);
            request.setAttribute("search",      search);
            request.setAttribute("categoryId",  categoryId);
            request.setAttribute("cartCount",   cartCount);
            request.setAttribute("currentUser", currentUser);
 
        } catch (ServiceException e) {
            request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
        }
 
        request.getRequestDispatcher("/WEB-INF/pages/Menu.jsp")
               .forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
