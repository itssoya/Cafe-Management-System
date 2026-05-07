package com.beanbrew.util;

import java.sql.*;

public class DBConnection {
	
	private static String url = "jdbc:mysql://localhost:3306/cafe_management";
	private static String username = "root";
	private static String password = "";
	
	static {
	
		try {
		
			//Loading Driver
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Driver Loaded Sucessfully");
		
		}catch (ClassNotFoundException e) {
		
			e.printStackTrace();
		}
	}

	public static Connection buildConnection() throws SQLException{
		// TODO Auto-generated method stub
			
			//Building Connection with Database
			Connection con = DriverManager.getConnection(url, username, password);
			System.out.println("Connection Built sucessfully");
			
			return con;
			
	

	}
}
