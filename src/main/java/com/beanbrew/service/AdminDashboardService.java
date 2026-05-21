package com.beanbrew.service;

import java.util.List;

import com.beanbrew.dao.AdminDashboardDAO;
import com.beanbrew.dao.FetchOrderBySearchFilterDAO;
import com.beanbrew.model.Order;
import com.beanbrew.util.ServiceExecutor;

public class AdminDashboardService {
	private AdminDashboardDAO adminDashboardDAO = new AdminDashboardDAO();
	private FetchOrderBySearchFilterDAO fetchOrderBySearchFilterDAO = new FetchOrderBySearchFilterDAO();
	private static final int PAGE_SIZE = 10;

	
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
	
	public List<Order> getPendingOrders(int currentPage) {
	    return ServiceExecutor.execute(
	        () -> fetchOrderBySearchFilterDAO.getOrder(currentPage, "PENDING", null),
	        "Failed to fetch pending orders.");
	}

	public int getPendingOrderTotalPages() {
	    return ServiceExecutor.execute(() -> {
	        int total = fetchOrderBySearchFilterDAO.countOrdersForFilter("PENDING", null);
	        return (int) Math.ceil((double) total / PAGE_SIZE);
	    }, "Failed to count pending orders.");
	}
}

