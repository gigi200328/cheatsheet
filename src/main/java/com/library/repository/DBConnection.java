package com.library.repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	
	public static Connection getConnection() {
		Connection con = null;
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cheat_sheet","root","root");
			System.out.println(con);
			
		} catch (ClassNotFoundException e) {
			System.out.println("Driver Error :" + e.getMessage());
		} catch (SQLException e) {
			System.out.println("Connection Error :" + e.getMessage());
		}
		
		return con;
		
		
		
	}

	public static void main(String[]args) {
		
		System.out.println(getConnection());
		
		
	}
	
}
