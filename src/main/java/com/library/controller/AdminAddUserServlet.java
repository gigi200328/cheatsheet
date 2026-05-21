package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.repository.UserRepository;

/**
 * Servlet implementation class AdminAddUserServlet
 */
@WebServlet("/admin-add-user")
public class AdminAddUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminAddUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String role = request.getParameter("role");

        UserRepository userRepo = new UserRepository();
        
       
        int result = userRepo.registerUserWithRole(name, email, password, role);

        if (result > 0) {
           
            response.sendRedirect("user-management?msg=add_success");
        } else {
           
            request.setAttribute("error", "Failed to add new user. Please try again.");
            request.getRequestDispatcher("add-user-form.jsp").forward(request, response);
        }
	}

}
