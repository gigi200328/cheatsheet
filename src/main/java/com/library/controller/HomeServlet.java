package com.library.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.library.model.CategoriesBean;
import com.library.repository.CategoryRepository;

/**
 * Servlet implementation class HomeServlet
 */
@WebServlet({"/","/home"})
public class HomeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public HomeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//System.out.println("--- HomeServlet Started ---"); // Console မှာ ကြည့်ရန်
		try {
	        CategoryRepository catRepo = new CategoryRepository();
	        
	        // ၁။ Categories List ကို ဆွဲထုတ်ခြင်း
	        List<CategoriesBean> categoryList = catRepo.getAllCategories();
	        request.setAttribute("categoryList", categoryList);
	        
	        // ၂။ Total Categories အရေအတွက်ကို Dynamic တွက်ယူခြင်း
	        int totalCategories = (categoryList != null) ? categoryList.size() : 0;
	        request.setAttribute("totalCategories", totalCategories);
	        
	       
	        int totalTopics = 0; 
	        try {
	            totalTopics = catRepo.getTotalTopicsCount(); 
	        } catch (Exception ex) {
	           
	            totalTopics = 0; 
	        }
	        request.setAttribute("totalTopics", totalTopics);
	        
	        
	        request.getRequestDispatcher("/Home.jsp").forward(request, response);

	    } catch (Exception e) {
	        e.printStackTrace();
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
