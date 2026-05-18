package com.beanbrew.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.beanbrew.dao.CheckStockItemDAO;
import com.beanbrew.dao.FetchMenuBySearchFilter;
import com.beanbrew.model.MenuItem;
import com.beanbrew.model.RecipeItem;
import com.beanbrew.model.StockItem;
import com.beanbrew.service.RecipeManagementService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.SessionUtil;

/**
 * Servlet implementation class AddRecipe
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/addrecipe" })
public class AddRecipeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RecipeManagementService recipeService = new RecipeManagementService();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddRecipeServlet() {
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
		
		String menuItemIdParam = request.getParameter("menuItemId");
        String searchStock     = request.getParameter("searchStock");
        String clearParam      = request.getParameter("clear");
        
        
        if (menuItemIdParam == null || menuItemIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/menumanagement");
            return;
        }
        
        int menuId = Integer.parseInt(menuItemIdParam);
        
        if ("true".equals(clearParam)) {
            request.getSession().removeAttribute("recipeIngredients_" + menuId);
        }
        
        try {
            FetchMenuBySearchFilter fetchMenu = new FetchMenuBySearchFilter();
            MenuItem menuItem = fetchMenu.getMenuById(menuId);
 
            if (menuItem == null) {
                response.sendRedirect(request.getContextPath() + "/menumanagement");
                return;
            }
 
            if (searchStock != null && !searchStock.trim().isEmpty()) {
                List<StockItem> searchResults = CheckStockItemDAO.searchStock(searchStock.trim());
                request.setAttribute("searchResults", searchResults);
                request.setAttribute("searchStock",   searchStock);
            }
 
            List<RecipeItem> ingredients = (List<RecipeItem>) SessionUtil.getAttribute( request, "recipe_" + menuId, List.class);
            if (ingredients == null) ingredients = new ArrayList<>();
 
            request.setAttribute("menuItem",    menuItem);
            request.setAttribute("menuItemId",  menuId);
            request.setAttribute("ingredients", ingredients);
 
        } catch (SQLException e) {
            request.setAttribute(MessageKeysUtil.ERROR, "Failed to load recipe page.");
        }
 
        request.getRequestDispatcher("/WEB-INF/pages/Recipe.jsp")
               .forward(request, response);
        
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
    @SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
    	
    	String action          = request.getParameter("action");
        String menuItemIdParam = request.getParameter("menuItemId");
 
        if (menuItemIdParam == null || menuItemIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/menumanagement");
            return;
        }
 
        int menuItemId = Integer.parseInt(menuItemIdParam);
 
        if ("addIngredient".equals(action)) {
 
            String stockId   = request.getParameter("stockId");
            String stockName = request.getParameter("stockName");
            String unit      = request.getParameter("unit");
            String quantity  = request.getParameter("quantity");
 
            if (quantity == null || quantity.trim().isEmpty()) {
            	response.sendRedirect(request.getContextPath() + "/addrecipe?menuItemId=" + menuItemId);
                return;
            }
 
            List<RecipeItem> list = (List<RecipeItem>) SessionUtil.getAttribute(request, "recipe_" + menuItemId, List.class);
            if (list == null) list = new ArrayList<>();
 
            int id = Integer.parseInt(stockId);
            boolean exists = list.stream().anyMatch(i -> i.getStockItemId() == id);
 
            if (!exists) {
            	
                RecipeItem item = new RecipeItem();
                item.setStockItemId(id);
                item.setStockName(stockName);
                item.setUnit(unit);
                item.setQuantityUsed(Double.parseDouble(quantity));
                list.add(item);
                SessionUtil.setAttribute(request, "recipe_" + menuItemId, list);
            }
 
            response.sendRedirect(request.getContextPath() + "/addrecipe?menuItemId=" + menuItemId);
            
            return;
        }
 
        // REMOVE one ingredient from session list
        if ("removeIngredient".equals(action)) {
 
            int stockId = Integer.parseInt(request.getParameter("stockId"));
            List<RecipeItem> list = (List<RecipeItem>) SessionUtil.getAttribute(request, "recipe_" + menuItemId, List.class);
 
            if (list != null) {
                list.removeIf(i -> i.getStockItemId() == stockId);
                SessionUtil.setAttribute(request, "recipe_" + menuItemId, list);
            }
 
            response.sendRedirect(request.getContextPath() + "/addrecipe?menuItemId=" + menuItemId);
            return;
        }
 
        if ("saveRecipe".equals(action)) {
 
        	List<RecipeItem> list = (List<RecipeItem>) SessionUtil.getAttribute(
                    request, "recipe_" + menuItemId, List.class);
 
            if (list == null || list.isEmpty()) {
                request.setAttribute(MessageKeysUtil.ERROR, "Add at least one ingredient.");
                request.setAttribute("menuItemId", menuItemId);
                request.getRequestDispatcher("/WEB-INF/pages/Recipe.jsp").forward(request, response);
                return;
            }
 
            List<String> names = new ArrayList<>();
            List<Double> qtys  = new ArrayList<>();
 
            for (RecipeItem item : list) {
                names.add(item.getStockName());
                qtys.add(item.getQuantityUsed());
            }
 
            try {
                recipeService.addRecipe(menuItemId, names, qtys);
                SessionUtil.removeAttribute(request, "recipe_" + menuItemId);
                response.sendRedirect(request.getContextPath() + "/menumanagement");
 
            } catch (ServiceException e) {
            	
                request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
                request.setAttribute("menuItemId",  menuItemId);
                request.setAttribute("ingredients", list);
                request.getRequestDispatcher("/WEB-INF/pages/Recipe.jsp").forward(request, response);
            }
            return;
        }
 
        response.sendRedirect(request.getContextPath() + "/menumanagement");
	}

}
