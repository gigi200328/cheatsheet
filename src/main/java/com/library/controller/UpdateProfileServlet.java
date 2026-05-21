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

@WebServlet("/updateProfile")
public class UpdateProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserRepository userRepository;

    public void init() {
        userRepository = new UserRepository();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        LoginBean user = (LoginBean) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String newName = request.getParameter("userName");
        String newPassword = request.getParameter("password");
        
        String passwordToUpdate = user.getPassword();
        if (newPassword != null && !newPassword.trim().isEmpty()) {
            passwordToUpdate = newPassword;
        }

        int userId = user.getUserId();
        boolean isSuccess = userRepository.updateProfile(userId, newName, passwordToUpdate);

        if (isSuccess) {

            user.setName(newName);
            user.setPassword(passwordToUpdate);
            session.setAttribute("user", user);
            
            
            session.setAttribute("successMessage", "Your profile has been updated successfully!");
            
            response.sendRedirect("profile");
        } else {
           
            session.setAttribute("errorMessage", "Failed to update profile. Please try again.");
            
            response.sendRedirect("profile");
        }
    }
}