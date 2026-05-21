package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.library.model.LoginBean;
import com.library.repository.RatingRepository;

/**
 * Servlet implementation class RatingServlet
 */
@WebServlet("/submitRating")
public class RatingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private RatingRepository ratingRepo = new RatingRepository();

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RatingServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    HttpSession session = request.getSession(false);

	    if (session != null && session.getAttribute("user") != null) {
	        LoginBean currentUser = (LoginBean) session.getAttribute("user");

	       
	        int ratingValue = Integer.parseInt(request.getParameter("ratingValue")); 
	        int topicId = Integer.parseInt(request.getParameter("topicId"));
	        int userId = currentUser.getUserId();
	        String catId = request.getParameter("catId");

	        boolean isSaved = ratingRepo.addRating(ratingValue, userId, topicId);

	        if (isSaved) {
	          
	            response.sendRedirect("ViewTopicsServlet?catId=" + catId);
	        } else {
	            response.getWriter().println("Rating update failed.");
	        }
	    } else {
	        response.sendRedirect("login.jsp");
	    }
	}
}