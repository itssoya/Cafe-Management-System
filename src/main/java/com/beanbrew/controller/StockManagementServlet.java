package com.beanbrew.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.beanbrew.dao.FetchStockBySearchFilter;
import com.beanbrew.model.StockItem;
import com.beanbrew.service.StockItemManagementService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;
import com.beanbrew.util.SessionUtil;

/**
 * Servlet implementation class MenuManagementServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/stockmanagement" })
public class StockManagementServlet extends HttpServlet {
	
	private FetchStockBySearchFilter fetchStockBySearchFilter = new FetchStockBySearchFilter();
	private StockItemManagementService stockItemManagementService = new StockItemManagementService();
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public StockManagementServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String action = request.getParameter("action");
		
		if ("addstock".equals(action)) {
            response.sendRedirect(request.getContextPath() + "/stockmanagement/addstock");
            return;
        }
 
        if ("restock".equals(action)) {
        	
        	 String id = request.getParameter("id");
        	    try {
        	        StockItem item = fetchStockBySearchFilter.getStockById(Integer.parseInt(id));
        	        request.setAttribute("stockItem", item);
        	        request.getRequestDispatcher("/stockmanagement/restockitem").forward(request, response);
        	        
        	    } catch (Exception e) {
        	        SessionUtil.setAttribute(request, MessageKeysUtil.ERROR, "Failed to load item.");
        	        response.sendRedirect(request.getContextPath() + "/stockmanagement");
        	    }
        	    return;
        }
		
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String isBakeryParam = request.getParameter("isbakery");
		String pageParam = request.getParameter("page");
		String search = request.getParameter("search");
		
		Boolean isBakery = (isBakeryParam != null && !isBakeryParam.isEmpty() ) ? Boolean.parseBoolean(isBakeryParam) : null;
		int currentPage = (pageParam != null && !pageParam.isEmpty()) ? Integer.parseInt(pageParam) :  1;
		
		try {
			List<StockItem> stockItem = fetchStockBySearchFilter.getAllStockItem();
			
			int totalStock = stockItem.size();
			long bakeryTotal = stockItem.stream().filter(StockItem:: isBakery).count();
			long lowStockItem = stockItem.stream().filter(item -> item.getQuantityInStock() <= item.getLowStockThreshold()).count();
			
			List<StockItem> fetchStockUser = stockItemManagementService.getStockWithFilter(currentPage, isBakery, search);
			int totalPages = stockItemManagementService.countPageForFilter(isBakery, search);
			
			request.setAttribute("fetchStockUser", fetchStockUser);
			request.setAttribute("totalPage", totalPages);

			request.setAttribute("totalStock", totalStock);
			request.setAttribute("bakeryTotal", bakeryTotal);
			request.setAttribute("lowStockItem", lowStockItem);
			request.setAttribute("currentPage", currentPage);
			request.setAttribute("search", search);  
			
			
			
		} catch (ServiceException e) {
			
			request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
			
		} catch (SQLException e) {
			
			request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
		}
		
		request.getRequestDispatcher("/WEB-INF/pages/stockmanagement.jsp")
	       .forward(request, response);
	}

}
