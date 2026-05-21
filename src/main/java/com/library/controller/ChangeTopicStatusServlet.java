package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.repository.TopicRepository;

/**
 * Servlet implementation class ChangeTopicStatusServlet
 */
@WebServlet("/change-topic-status")
public class ChangeTopicStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangeTopicStatusServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("id"));
	    String status = request.getParameter("status"); 
	    
	    TopicRepository repo = new TopicRepository();
	   
	    repo.updateTopicStatus(id, status); 


	    if ("Rejected".equals(status)) {
	       
	        int userId = repo.getUserIdByTopicId(id); 
	        
	        int rejectedCount = repo.getRejectedCountByUser(userId);
	        if (rejectedCount >= 3) {
	            repo.banUser(userId);
	        }
	    }
	    
	    response.sendRedirect("topics");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
