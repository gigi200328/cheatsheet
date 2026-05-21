package com.library.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.library.model.LoginBean;


@WebFilter(urlPatterns = {"/admin-dashboard", "/categories", "/users", "/community"})
public class AdminFilter implements Filter {

    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        String path = httpRequest.getServletPath();
        String method = httpRequest.getMethod(); 

       
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);

        // -----------------------------------------------------------------
        // 🌐 CASE 1: Community 
        // -----------------------------------------------------------------
        if ("/community".equals(path)) {
            if ("POST".equalsIgnoreCase(method)) {
               
                if (!isLoggedIn) {
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
                    return;
                }
            }
           
            chain.doFilter(request, response);
            return;
        }

        // -----------------------------------------------------------------
       
        // -----------------------------------------------------------------
        if (isLoggedIn) {
            LoginBean user = (LoginBean) session.getAttribute("user");
            
           
            if ("admin".equals(user.getRole())) {
                chain.doFilter(request, response);
            } else {
               
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
            }
        } else {
           
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
        }
    }

    public void destroy() {}
    public void init(javax.servlet.FilterConfig fConfig) throws ServletException {}
}