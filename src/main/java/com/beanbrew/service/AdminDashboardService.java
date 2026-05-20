package com.beanbrew.service;

import com.beanbrew.dao.AdminDashboardDAO;
import com.beanbrew.util.ServiceExecutor;

public class AdminDashboardService {
	private AdminDashboardDAO adminDashboardDAO = new AdminDashboardDAO();
	
	public double totalEarningToday() {
		return ServiceExecutor.execute(() 
	    		-> adminDashboardDAO.getTotalEarnings(),  "Failed to count total earnings.");
	}
	
	public int pendingOrdersToday() {
		return ServiceExecutor.execute(() 
        		-> adminDashboardDAO.getPendingOrders(),  "Failed to count pending orders.");
	}
	
	public int lowStockCount() {
		return ServiceExecutor.execute(() 
        		-> adminDashboardDAO.countLowStockItems(),  "Failed to count low stock items.");
	}
}

