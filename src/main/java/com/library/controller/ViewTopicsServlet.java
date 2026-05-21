package com.library.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.model.TopicBean;

/**
 * Servlet implementation class ViewTopicsServlet
 */
@WebServlet("/ViewTopicsServlet")
public class ViewTopicsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public ViewTopicsServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String catIdStr = request.getParameter("catId");
        List<TopicBean> topicsList = new java.util.ArrayList<>();
        
        if (catIdStr != null) {
            try {
                int catId = Integer.parseInt(catIdStr);
                
                
                com.library.repository.CategoryRepository catRepo = new com.library.repository.CategoryRepository();
                catRepo.incrementViewCount(catId); 
                
             
                com.library.repository.TopicRepository topicRepo = new com.library.repository.TopicRepository();
                topicsList = topicRepo.getTopicsWithContents(catId); 
                
               
                javax.servlet.http.HttpSession session = request.getSession();
                com.library.model.LoginBean user = (com.library.model.LoginBean) session.getAttribute("user");
                int currentUserId = (user != null) ? user.getUserId() : 0; 

                // ========================================================
              
                // ========================================================
                com.library.repository.RatingRepository ratingRepo = new com.library.repository.RatingRepository();
                com.library.repository.NoteRepository noteRepo = new com.library.repository.NoteRepository(); 

                if (topicsList != null) {
                    for (TopicBean t : topicsList) {
                        
                        t.setAvgRating(ratingRepo.getAverageRatingByTopicId(t.getTopicId()));
                        t.setTotalRatings(ratingRepo.getTotalRatingsByTopicId(t.getTopicId()));
                        
                      
                        List<com.library.model.NoteBean> notes = noteRepo.getNotesByTopic(t.getTopicId(), currentUserId);
                        t.setNotes(notes); 
                    }
                }
                // ========================================================
                
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        request.setAttribute("currentCatId", catIdStr);
        request.setAttribute("topics", topicsList);
        
       
        request.getRequestDispatcher("/topics-list.jsp").forward(request, response);
    }
    
}
