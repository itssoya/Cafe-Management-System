package com.beanbrew.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.beanbrew.model.StockItem;
import com.beanbrew.service.StockItemManagementService;
import com.beanbrew.util.MessageKeysUtil;
import com.beanbrew.util.ServiceException;

/**
 * Servlet implementation class StockManagementServlet
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/stockmanagement/addstock" })
public class AddStockItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddStockItemServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		request.getRequestDispatcher("/WEB-INF/pages/addstock.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		String stockName = request.getParameter("stockName");
		String intialQuantityParam = request.getParameter("quantity");
		String unit = request.getParameter("unit").trim().toLowerCase();
		String lowStockParam = request.getParameter("lowStockThreshold");
		String isBakery = request.getParameter("isBakery");
		
		
		if (stockName == null || stockName.trim().isEmpty()
			|| intialQuantityParam == null || intialQuantityParam.trim().isEmpty()
			|| unit == null || unit.trim().isEmpty()) {
	            
				request.setAttribute(MessageKeysUtil.ERROR, "All fields required");
				request.getRequestDispatcher("/WEB-INF/pages/addstock.jsp").forward(request, response);
				return;
				
	        }
		
		if (!unit.equals("kg") && !unit.equals("ltr") && !unit.equals("pcs")) {
		            
					request.setAttribute(MessageKeysUtil.ERROR, "Invalid Unit Type");
					request.getRequestDispatcher("/WEB-INF/pages/addstock.jsp").forward(request, response);
					return;
					
		        }	
		
		try {
			
			Double lowStockThreshold = Double.parseDouble(lowStockParam );
			Double intialQuantity = Double.parseDouble(intialQuantityParam);
			
			StockItem stockItem = new StockItem();
			
			stockItem.setName(stockName);
			stockItem.setQuantityInStock(intialQuantity);
			stockItem.setUnit(unit);
			stockItem.setLowStockThreshold(lowStockThreshold);
			stockItem.setBakery(Boolean.parseBoolean(isBakery));
			
			StockItemManagementService stockItemManagementService = new StockItemManagementService();
			stockItemManagementService.addStockItem(stockItem);
			
		} catch (ServiceException e) {
			
			request.setAttribute(MessageKeysUtil.ERROR, "All fields required");
			request.getRequestDispatcher("/WEB-INF/pages/addstock.jsp").forward(request, response);
			return;
			
		}catch (NumberFormatException e) {
			
			request.setAttribute(MessageKeysUtil.ERROR, "Invalid input type");
			request.getRequestDispatcher("/WEB-INF/pages/addstock.jsp").forward(request, response);
			return;
		}
		response.sendRedirect(request.getContextPath() + "/stockmanagement");
	}
}
