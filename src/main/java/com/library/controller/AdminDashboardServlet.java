package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.repository.AdminRepository;
import com.library.repository.CategoryRepository;
import com.library.repository.TopicRepository;
import com.library.repository.UserRepository;

/**
 * Servlet implementation class AdminDashboardServlet
 */
@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminDashboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminRepository adminRepo = new AdminRepository();

       
        int totalCats = adminRepo.getTotalCategories();
        int totalTopics = adminRepo.getTotalTopics();
        int totalUsers = adminRepo.getTotalUsers();

      
        request.setAttribute("totalCats", totalCats);
        request.setAttribute("totalTopics", totalTopics);
        request.setAttribute("totalUsers", totalUsers);

       
        request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
    }

    
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
