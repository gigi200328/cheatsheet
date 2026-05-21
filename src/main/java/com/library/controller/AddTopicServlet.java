package com.library.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.model.CategoriesBean;
import com.library.model.ContentBean;
import com.library.model.LoginBean;
import com.library.model.TopicBean;
import com.library.repository.CategoryRepository;
import com.library.repository.ContentRepository;
import com.library.repository.TopicRepository;

/**
 * Servlet implementation class AddTopicServlet
 */
@WebServlet("/addTopic")
public class AddTopicServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TopicRepository topicRepo = new TopicRepository();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTopicServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		LoginBean user = (LoginBean) request.getSession().getAttribute("user");
	    if (user == null) {
	        response.sendRedirect("login.jsp");
	        return;
	    }

	    // 2. Form data ယူမယ်
	    String topicName = request.getParameter("topicName");
	    int catId = Integer.parseInt(request.getParameter("catId"));
	    String syntax = request.getParameter("syntax");
	    String exampleCode = request.getParameter("exampleCode");

	    // 3. Topic သိမ်းမယ် (topic_name, categories_id, user_id ပဲ ရှိတော့တာမို့ အဲ့ဒါပဲ သိမ်းမယ်)
	    TopicBean topic = new TopicBean();
	    topic.setTopicName(topicName);
	    topic.setCatId(catId);
	    topic.setUserId(user.getUserId());
	    
	    TopicRepository topicRepo = new TopicRepository();
	    int generatedTopicId = topicRepo.saveTopic(topic); 

	    // 4. Topic ID ရလာမှ Content Card ကို ဆက်သိမ်းမယ်
	    if (generatedTopicId > 0) {
	        ContentBean content = new ContentBean();
	        content.setTopicId(generatedTopicId);
	        content.setTitle(topicName); 
	        content.setDescription(syntax); 
	        content.setExampleCode(exampleCode);

	        ContentRepository contentRepo = new ContentRepository();
	        contentRepo.saveContent(content); 
	    }

	    response.sendRedirect("viewTopics?catId=" + catId);
        
	}

}
