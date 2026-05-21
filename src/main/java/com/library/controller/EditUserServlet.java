package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.library.model.LoginBean; 
import com.library.repository.UserRepository;

/**
 * Servlet implementation class EditUserServlet
 */
@WebServlet("/edit-user")
public class EditUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserRepository userRepository;
       
    public EditUserServlet() {
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
            

            LoginBean existingUser = userRepository.selectUser(id); 
            
            request.setAttribute("user", existingUser);
            request.getRequestDispatcher("edit-user-form.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("user-list"); 
        }
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String role = request.getParameter("role");

       
        LoginBean updatedUser = new LoginBean();
        updatedUser.setUserId(id);
        updatedUser.setName(name);
        updatedUser.setEmail(email);
        updatedUser.setRole(role);
        
        try {
           
            boolean isUpdated = userRepository.updateUser(updatedUser); 
            
            if (isUpdated) {
               
                request.setAttribute("successMessage", "User information updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update user info.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
        }

    
        request.setAttribute("user", updatedUser);
        request.getRequestDispatcher("edit-user-form.jsp").forward(request, response);
    }
}