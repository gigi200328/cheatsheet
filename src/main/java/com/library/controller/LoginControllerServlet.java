package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.library.model.LoginBean;
import com.library.repository.UserRepository;



/**
 * Servlet implementation class LoginController
 */
@WebServlet("/login")
public class LoginControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private UserRepository userRepo = new UserRepository();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.getRequestDispatcher("login.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String name = request.getParameter("name");
	    String password = request.getParameter("password");

	    LoginBean loginObj = userRepo.getUserByNameAndPassword(name, password);
	    
	    if (loginObj != null) {
	        HttpSession session = request.getSession();
	        
	        loginObj.setPassword(password);
	        session.setAttribute("user", loginObj); 

	        
	        if ("admin".equals(loginObj.getRole())) { 
	            response.sendRedirect("admin-dashboard");
	        } else {
	            response.sendRedirect("home");
	        }
	    } else {
	        
	    	request.setAttribute("error", "Invalid Username or Password");
	        request.getRequestDispatcher("login.jsp").forward(request, response);
	    }
	}
}
	
	


