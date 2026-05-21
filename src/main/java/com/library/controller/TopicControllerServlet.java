package com.library.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.model.ContentBean;
import com.library.model.NoteBean;
import com.library.model.TopicBean;
import com.library.repository.ContentRepository;
import com.library.repository.NoteRepository;
import com.library.repository.TopicRepository;

/**
 * Servlet implementation class TopicControllerServlet
 */
@WebServlet("/viewTopics")
public class TopicControllerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TopicRepository topicRepository = new TopicRepository();	
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TopicControllerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		String catIdParam = request.getParameter("catId");
	    
	    if (catIdParam != null) {
	        int catId = Integer.parseInt(catIdParam);
	        
	        
	        List<TopicBean> topicList = topicRepository.getTopicsWithContents(catId);
	        
	        com.library.model.LoginBean currentUser = (com.library.model.LoginBean) request.getSession().getAttribute("user");
	        int currentUserId = (currentUser != null) ? currentUser.getUserId() : -1;
	        
	        NoteRepository noteRepo = new NoteRepository();
	        
	        
	        for (TopicBean t : topicList) {
	            List<NoteBean> notes = noteRepo.getNotesByTopic(t.getTopicId(), currentUserId);
	            t.setNotes(notes); 
	        }
	        
	        request.setAttribute("topics", topicList);
	        request.getRequestDispatcher("topics-list.jsp").forward(request, response);
	    } else {
	        response.sendRedirect("home");
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
