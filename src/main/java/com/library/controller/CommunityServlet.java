package com.library.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.library.model.CommunityBean;
import com.library.model.LoginBean;
import com.library.repository.CommunityRepository;

@WebServlet("/community")
public class CommunityServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public CommunityServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String type = request.getParameter("type");
        if (type == null || type.trim().isEmpty()) {
            type = "All"; 
        }
        
        CommunityRepository repo = new CommunityRepository();
        List<CommunityBean> postList;
        
        if (type.equals("Events") || type.equals("Stories")) {
            postList = repo.getPostsByType(type);
        } else {
            postList = repo.getAllPosts(); 
        }
        
        request.setAttribute("selectedType", type);
        request.setAttribute("posts", postList);
        request.getRequestDispatcher("/community.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            LoginBean user = (LoginBean) session.getAttribute("user");
            CommunityRepository repo = new CommunityRepository();
            
            String currentType = request.getParameter("type");
            if (currentType == null || currentType.trim().isEmpty()) {
                currentType = "All";
            }
            
            String action = request.getParameter("action");
            
            if ("createPost".equals(action)) {
                
                String title = request.getParameter("title");
                String content = request.getParameter("content");
                String postType = request.getParameter("postType"); // General, Events, Stories
                
                if (title != null && content != null) {
                    
                    repo.addPost(user.getUserId(), title.trim(), content.trim(), postType);
                }
                
            } else {
              
                String postIdStr = request.getParameter("postId");
                String replyContent = request.getParameter("replyContent");
                String parentReplyIdStr = request.getParameter("parentReplyId");
                
                if (postIdStr != null && !postIdStr.trim().isEmpty() && replyContent != null) {
                    int postId = Integer.parseInt(postIdStr.trim());
                    
                    Integer parentReplyId = null; 
                    if (parentReplyIdStr != null && !parentReplyIdStr.trim().isEmpty()) {
                        parentReplyId = Integer.parseInt(parentReplyIdStr.trim());
                    }
                    
                    repo.addReply(postId, user.getUserId(), replyContent.trim(), parentReplyId);
                }
            }
            
            response.sendRedirect("community?type=" + currentType);
        } else {
            response.sendRedirect("login.jsp");
        }
    }
}