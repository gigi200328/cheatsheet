package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.repository.UserRepository;

/**
 * Servlet implementation class DeleteUserServlet
 */
@WebServlet("/delete-user")
public class DeleteUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserRepository userRepository;
       
    public DeleteUserServlet() {
        super();
    }

    @Override
    public void init() throws ServletException {
        userRepository = new UserRepository();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
         
            int id = Integer.parseInt(request.getParameter("id"));
            
           
            userRepository.deleteUser(id);
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
    
        
        response.sendRedirect("user-management"); 
      
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doGet(request, response);
	}
}