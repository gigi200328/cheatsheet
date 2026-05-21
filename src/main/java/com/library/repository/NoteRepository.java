package com.library.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.library.model.NoteBean;

public class NoteRepository {
	public boolean saveNote(int topicId, int userId, int catId, String text, int isPublic, int parentId) {
	 
	    String sql = "INSERT INTO note (note_text, user_id, topic_id, categories_id, is_public, parent_id) VALUES (?, ?, ?, ?, ?, ?)";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, text);
	        ps.setInt(2, userId);
	        ps.setInt(3, topicId);
	        ps.setInt(4, catId);
	        ps.setInt(5, isPublic); 
	        ps.setInt(6, parentId);
	        return ps.executeUpdate() > 0;
	    } catch (Exception e) { 
	        e.printStackTrace(); 
	        return false; 
	    }
	}
	
	

	public List<NoteBean> getNotesByTopic(int topicId, int currentUserId) {
	    List<NoteBean> list = new ArrayList<>();
	    String sql = "SELECT n.*, u.user_name FROM note n JOIN users u ON n.user_id = u.user_id " +
	                 "WHERE n.topic_id = ? AND (n.is_public = 1 OR n.user_id = ?) " +
	                 "ORDER BY CASE WHEN n.parent_id = 0 THEN n.note_id ELSE n.parent_id END DESC, n.note_id ASC";
	                 
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        
	        ps.setInt(1, topicId);       
	        ps.setInt(2, currentUserId); 
	        
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            NoteBean n = new NoteBean();
	            n.setNoteId(rs.getInt("note_id"));     
	            n.setUserId(rs.getInt("user_id"));     
	            n.setContent(rs.getString("note_text")); 
	            n.setUserName(rs.getString("user_name")); 
	            n.setIsPublic(rs.getInt("is_public")); 
	            
	            
	            n.setParentId(rs.getInt("parent_id")); 
	            // ------------------------------------------------------------------
	            
	            list.add(n);
	        }
	    } catch (Exception e) { e.printStackTrace(); }
	    return list;
	}
	
	public boolean deleteNote(int noteId, int userId) {
	    
	    String sql = "DELETE FROM note WHERE note_id = ? AND user_id = ?";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, noteId);
	        ps.setInt(2, userId);
	        return ps.executeUpdate() > 0;
	    } catch (Exception e) { e.printStackTrace(); return false; }
	}

}
