package com.beanbrew.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;

import com.beanbrew.dao.FetchStockBySearchFilter;
import com.beanbrew.model.StockItem;
import com.beanbrew.service.StockItemManagementService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;

/**
 * Servlet implementation class RestockItem
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/stockmanagement/restockitem" })
public class RestockServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private StockItemManagementService stockManagementService = new StockItemManagementService();
    private FetchStockBySearchFilter fetchStockBySearchFilter = new FetchStockBySearchFilter();
    
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RestockServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		request.getRequestDispatcher("/WEB-INF/pages/restock.jsp").forward(request, response);
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String stockIdParam = request.getParameter("stockId");
        String newQuantityParam = request.getParameter("newQuantity");
		
			try {
	            int stockId = Integer.parseInt(stockIdParam);
	            Double additionalQuantity = Double.parseDouble(newQuantityParam);
	
	            StockItem current = fetchStockBySearchFilter.getStockById(stockId);
	
	            if (current == null) {
	                request.setAttribute("error", "Stock item not found.");
	                request.getRequestDispatcher("/WEB-INF/pages/restock.jsp").forward(request, response);
	                return;
	            }
	
	            Double newStockLevel = current.getQuantityInStock() + additionalQuantity;
	            stockManagementService.restock(newStockLevel, stockId);
	
	            response.sendRedirect(request.getContextPath() + "/stockmanagement");
	            return;
	
	        } catch (NumberFormatException e) {
	        	
	            request.setAttribute(MessageKeysUtil.ERROR, "Invalid input type.");
	            request.getRequestDispatcher("/WEB-INF/pages/restock.jsp").forward(request, response);
	            
	            return;
	            
	        } catch (ServiceException e) {
	        	
	            request.setAttribute(MessageKeysUtil.ERROR, e.getMessage());
	            request.getRequestDispatcher("/WEB-INF/pages/restock.jsp").forward(request, response);
	            
	            return;
	            
	        } catch (SQLException e) {
	        	
	        	e.printStackTrace();
	        	throw new RuntimeException("Service error while restocking", e);
	        	
	        }
	}

}
