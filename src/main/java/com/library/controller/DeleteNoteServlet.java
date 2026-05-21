package com.library.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DeleteNoteServlet
 */
@WebServlet("/delete-note")
public class DeleteNoteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteNoteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int noteId = Integer.parseInt(request.getParameter("noteId"));
        String catId = request.getParameter("catId");
        
        com.library.model.LoginBean user = (com.library.model.LoginBean) request.getSession().getAttribute("user");
        
        if (user != null) {
            com.library.repository.NoteRepository repo = new com.library.repository.NoteRepository();
            repo.deleteNote(noteId, user.getUserId());
        }
        response.sendRedirect("viewTopics?catId=" + catId);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
