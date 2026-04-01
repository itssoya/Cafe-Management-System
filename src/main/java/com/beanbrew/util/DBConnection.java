package com.beanbrew.util;

import java.sql.*;

public class DBConnection {

	public static Connection buildConnection() throws ClassNotFoundException {
		// TODO Auto-generated method stub
		
		String url = "jdbc:mysql://localhost:3306/cafe_management";
		String username = "root";
		String password = "";
		
		try {
			
			//Loading Driver
			Class.forName("com.mysql.cj.jdbc.Driver");
			System.out.println("Driver Loaded Sucessfully");
			
		} catch (ClassNotFoundException e) {
			
			System.out.println(e.getMessage());
		}
		
		try {
			
			//Building Connection with Database
			Connection con = DriverManager.getConnection(url, username, password);
			System.out.println("Connection Built sucessfully");
			
			return con;
			
		} catch(Exception e) {
			
			System.out.println(e.getMessage());
			
			return null;
			
		}
	}
}
