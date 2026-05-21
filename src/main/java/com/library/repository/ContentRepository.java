package com.library.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.library.model.ContentBean;

public class ContentRepository {

	public List<ContentBean> getContentsByTopic(int topicId) {
	    List<ContentBean> list = new ArrayList<>();
	   
	    String sql = "SELECT * FROM contents WHERE topic_id = ?"; 
	    
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        
	        ps.setInt(1, topicId);
	        ResultSet rs = ps.executeQuery();
	        
	        while (rs.next()) {
	            ContentBean c = new ContentBean();
	            c.setTitle(rs.getString("title"));      
	            c.setDescription(rs.getString("description")); 
	            c.setExampleCode(rs.getString("example_code"));
	            list.add(c);
	        }
	    } catch (Exception e) { 
	        e.printStackTrace(); 
	    }
	    return list;
	}
	public boolean saveContent(ContentBean content) {
	    boolean isSaved = false;
	    
	    String sql = "INSERT INTO contents (topic_id, title, description, example_code) VALUES (?, ?, ?, ?)";
	    
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        
	        ps.setInt(1, content.getTopicId());
	        ps.setString(2, content.getTitle());
	        ps.setString(3, content.getDescription());
	        ps.setString(4, content.getExampleCode());
	        
	        int rows = ps.executeUpdate();
	        isSaved = rows > 0;
	    } catch (Exception e) {
	        e.printStackTrace(); 
	    }
	    return isSaved;
	}
}
