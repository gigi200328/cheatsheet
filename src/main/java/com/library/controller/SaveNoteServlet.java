package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class SaveNoteServlet
 */
@WebServlet("/save-note")
public class SaveNoteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SaveNoteServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String content = request.getParameter("commentText");
	    String topicIdStr = request.getParameter("topicId");
	    String catIdStr = request.getParameter("catId");
	    String isPublicStr = request.getParameter("isPublic");
	    String parentIdStr = request.getParameter("parentId");

	    
	    String referer = request.getHeader("referer");
	    String fallbackCatId = "2"; 

	    if (referer != null && referer.contains("catId=")) {
	        int index = referer.indexOf("catId=");
	        fallbackCatId = referer.substring(index + 6);
	        if (fallbackCatId.contains("&")) {
	            fallbackCatId = fallbackCatId.substring(0, fallbackCatId.indexOf("&"));
	        }
	    }

	    if (catIdStr == null || catIdStr.trim().isEmpty() || catIdStr.equals("0")) {
	        catIdStr = fallbackCatId;
	    }

	    if (content != null && topicIdStr != null && !topicIdStr.trim().isEmpty()) {
	        try {
	            int topicId = Integer.parseInt(topicIdStr.trim());
	            int catId = Integer.parseInt(catIdStr.trim());
	            int isPublic = (isPublicStr != null && isPublicStr.equals("1")) ? 1 : 0;
	            int parentId = (parentIdStr != null && !parentIdStr.isEmpty()) ? Integer.parseInt(parentIdStr.trim()) : 0;

	            HttpSession session = request.getSession();
	            com.library.model.LoginBean user = (com.library.model.LoginBean) session.getAttribute("user");

	            if (user != null) {
	                com.library.repository.NoteRepository noteRepo = new com.library.repository.NoteRepository();
	                noteRepo.saveNote(topicId, user.getUserId(), catId, content, isPublic, parentId);
	                
	                
	                response.sendRedirect("viewTopics?catId=" + catId);
	                return;
	            } else {
	                response.sendRedirect("login.jsp");
	                return;
	            }
	        } catch (NumberFormatException e) {
	            e.printStackTrace();
	           
	            response.sendRedirect("viewTopics?catId=" + catIdStr);
	            return;
	        }
	    } else {
	       
	        response.sendRedirect("viewTopics?catId=" + catIdStr);
	    }
	}
}