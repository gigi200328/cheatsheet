package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.library.model.ContentBean;
import com.library.model.LoginBean;
import com.library.model.TopicBean;
import com.library.repository.ContentRepository;
import com.library.repository.TopicRepository;

/**
 * Servlet implementation class SaveTopicServlet
 */
@WebServlet("/save-topic")
public class SaveTopicServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private TopicRepository topicRepo = new TopicRepository();
       
    public SaveTopicServlet() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        LoginBean admin = (LoginBean) session.getAttribute("user");

        if (admin == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Parameter များ လက်ခံခြင်း
        String name = request.getParameter("topicName");
        String catIdParam = request.getParameter("catId");
        int catId = (catIdParam != null && !catIdParam.isEmpty()) ? Integer.parseInt(catIdParam) : 0;
        String contentTitle = request.getParameter("contentTitle");
        String contentDescription = request.getParameter("contentDescription");
        String exampleCode = request.getParameter("exampleCode");

        // Forbidden Words (ပိတ်ပင်ထားသောစာလုံးများ) စစ်ဆေးခြင်း Logic
        String finalStatus = "Active"; 
        String[] forbiddenWords = { "hack", "script", "badword", "attack" }; 
        boolean hasForbiddenWord = false;
        
        String fullContent = (name + " " + contentTitle + " " + contentDescription).toLowerCase();
        for (String word : forbiddenWords) {
            if (fullContent.contains(word)) {
                hasForbiddenWord = true;
                break;
            }
        }

        if (hasForbiddenWord) {
            finalStatus = "Rejected";
            int rejectedLimit = 3; 
            int currentRejectedCount = topicRepo.getRejectedCountByUser(admin.getUserId());
            
            if (currentRejectedCount + 1 >= rejectedLimit) {
                topicRepo.banUser(admin.getUserId()); 
                session.invalidate(); 
                response.sendRedirect("login.jsp?error=account_banned");
                return; 
            }
        }

        // Topic သိမ်းဆည်းခြင်း
        TopicBean topic1 = new TopicBean();
        topic1.setTopicName(name);
        topic1.setCatId(catId);
        topic1.setUserId(admin.getUserId());
        topic1.setStatus(finalStatus); 

        int topicId = topicRepo.saveTopic(topic1);

        if (topicId > 0) {
            // Content သိမ်းဆည်းခြင်း
            ContentBean content = new ContentBean();
            content.setTopicId(topicId);
            content.setTitle(contentTitle);
            content.setDescription(contentDescription);
            content.setExampleCode(exampleCode);

            ContentRepository contentRepo = new ContentRepository();
            boolean isContentSaved = contentRepo.saveContent(content);

            if (isContentSaved) {
                if (hasForbiddenWord) {
                    if ("admin".equals(admin.getRole())) {
                        response.sendRedirect("topics?warning=content_rejected");
                    } else {
                        response.sendRedirect("home?warning=content_rejected");
                    }
                } else {
                    if ("admin".equals(admin.getRole())) {
                        response.sendRedirect("topics?success=added");
                    } else {
                        response.sendRedirect("home?success=added");
                    }
                }
                return;
            }
        } else {
            // Topic မအောင်မြင်ခဲ့ပါက သက်ဆိုင်ရာ စာမျက်နှာသို့ ပြန်မောင်းနှင်ရန်
            response.sendRedirect("home?error=failed");
        }
    }
}