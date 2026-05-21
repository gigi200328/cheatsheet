package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.library.model.LoginBean; 
import com.library.repository.ReplyRepository;

@WebServlet("/AddReplyServlet")
public class AddReplyServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    public AddReplyServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 💡 CommunityServlet လို့ မခေါ်ဘဲ သတ်မှတ်ထားတဲ့ URL Pattern အတိုင်း "community" သို့ ပြောင်းလဲခြင်း
        response.sendRedirect("community?type=All");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String postIdStr = request.getParameter("postId");
        String replyContent = request.getParameter("replyContent");
        
        if (postIdStr == null || replyContent == null || replyContent.trim().isEmpty()) {
            response.sendRedirect("community?type=All");
            return;
        }
        
        int postId = Integer.parseInt(postIdStr);
        
        HttpSession session = request.getSession();
        LoginBean loginObj = (LoginBean) session.getAttribute("user"); 
        
        if (loginObj == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        int userId = loginObj.getUserId();
        
        String parentIdStr = request.getParameter("parentReplyId");
        Integer parentReplyId = null;

        if (parentIdStr != null && !parentIdStr.trim().isEmpty()) {
            try {
                int parsedId = Integer.parseInt(parentIdStr.trim());
                if (parsedId > 0) { 
                    parentReplyId = parsedId;
                }
            } catch (NumberFormatException e) {
                parentReplyId = null; 
            }
        }
        
        ReplyRepository replyRepo = new ReplyRepository();
        replyRepo.addReply(postId, userId, replyContent.trim(), parentReplyId);
        
        response.sendRedirect("community?type=All");
    }
}