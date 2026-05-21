package com.library.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.model.TopicBean;
import com.library.repository.TopicRepository;

/**
 * Servlet implementation class AdminTopicServlet
 */
@WebServlet("/topics")
public class AdminTopicServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminTopicServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		TopicRepository topicRepo = new TopicRepository();
	   
	    com.library.repository.ContentRepository contentRepo = new com.library.repository.ContentRepository();
	    
	  
	    List<TopicBean> allTopics = topicRepo.getAllTopicsWithCategory();
	    
	    
	    if (allTopics != null) {
	        for (TopicBean topic : allTopics) {
	           
	            topic.setContents(contentRepo.getContentsByTopic(topic.getTopicId()));
	        }
	    }
	    
	   
	    request.setAttribute("allTopics", allTopics);
	    request.getRequestDispatcher("topics.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
