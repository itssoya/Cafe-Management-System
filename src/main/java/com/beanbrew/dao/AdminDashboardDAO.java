package com.beanbrew.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.beanbrew.util.DBConnection;

public class AdminDashboardDAO {
	private static final String total_earning_query =  "SELECT SUM(total_amount) AS total " + "FROM orders " + "WHERE order_status = 'COMPLETED' " + "AND DATE(created_at) = CURDATE()";

	private static final String pending_order_query = "SELECT COUNT(*) AS total " +  "FROM orders " + "WHERE order_status = 'PENDING'";

	private static final String low_stock_query = "SELECT COUNT(*) AS total " + "FROM stock_items " + "WHERE quantity_in_stock <= low_stock_threshold";
	
	public double getTotalEarnings() throws SQLException{
		double totalEarning = 0;
		try(Connection con = DBConnection.buildConnection();
				PreparedStatement pst = con.prepareStatement(total_earning_query)){
			 	
				ResultSet rs = pst.executeQuery();
				
				if (rs.next()){
					totalEarning = rs.getDouble("total");
				}
				return totalEarning;
			
		}
		
	}
	
	public int getPendingOrders() throws SQLException{
		int pendingOrder = 0;
		try(Connection con = DBConnection.buildConnection();
				PreparedStatement pst = con.prepareStatement(pending_order_query)){
			 	
				ResultSet rs = pst.executeQuery();
				
				if (rs.next()){
					pendingOrder = rs.getInt("total");
				}
				return pendingOrder;
			
		}
		
	}
	
	public int countLowStockItems() throws SQLException{
		int lowStock = 0;
		try(Connection con = DBConnection.buildConnection();
				PreparedStatement pst = con.prepareStatement(low_stock_query)){
			 	
				ResultSet rs = pst.executeQuery();
				
				if (rs.next()){
					lowStock = rs.getInt("total");
				}
				return lowStock;
			
		}
		
	}
	
}



