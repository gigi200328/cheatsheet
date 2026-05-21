package com.library.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.model.CategoriesBean;
import com.library.model.TopicBean;
import com.library.repository.CategoryRepository;
import com.library.repository.RatingRepository;
import com.library.repository.TopicRepository;

/**
 * Servlet implementation class UpdateTopicServlet
 */
@WebServlet("/edit-topic")
public class UpdateTopicServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TopicRepository  repo = new TopicRepository();
			
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateTopicServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String idParam = request.getParameter("id");
	    if (idParam != null) {
	        int id = Integer.parseInt(idParam);
	        
	      
	        TopicBean topic = repo.getTopicById(id);
	        
	       
	        CategoryRepository catRepo = new CategoryRepository(); 
	        List<CategoriesBean> allCategories = catRepo.getAllCategories(); 
	        
	      
	        request.setAttribute("topic", topic);
	        request.setAttribute("allCategories", allCategories); 
	        
	        request.getRequestDispatcher("edit-topic-form.jsp").forward(request, response);
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    
		request.setCharacterEncoding("UTF-8");
	    
	    try {
	        int id = Integer.parseInt(request.getParameter("topicId"));
	        String name = request.getParameter("topicName");
	        int catId = Integer.parseInt(request.getParameter("categoryId"));
	        String description = request.getParameter("description");
	        String exampleCode = request.getParameter("exampleCode");

	        int result = repo.updateTopic(id, name, catId, description, exampleCode); 

	        if (result > 0) {
	         
	            response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); 
	            response.setHeader("Pragma", "no-cache"); 
	            response.setDateHeader("Expires", 0);

	           
	            response.sendRedirect(request.getContextPath() + "/topics");
	        } else {
	            response.sendRedirect(request.getContextPath() + "/edit-topic?id=" + id + "&error=1");
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	        response.sendRedirect(request.getContextPath() + "/topics?error=server");
	}

}
}
