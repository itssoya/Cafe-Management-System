package com.beanbrew.controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

import com.beanbrew.service.AdminDashboardService;

/**
 * Servlet implementation class AdminDashboard
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/admindashboard" })
public class AdminDashboard extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private AdminDashboardService adminDashboardService = new AdminDashboardService();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDashboard() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		double totalEarnings = adminDashboardService.totalEarningToday();
		request.setAttribute("totalEarnings",totalEarnings);
		
		int pendingOrders = adminDashboardService.pendingOrdersToday();
		request.setAttribute("pendingOrders", pendingOrders);
		
		int lowStockCount = adminDashboardService.lowStockCount();
		request.setAttribute("lowStockCount", lowStockCount);
		
		RequestDispatcher rd = request.getRequestDispatcher("/WEB-INF/pages/AdminDashboard.jsp");
		rd.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
