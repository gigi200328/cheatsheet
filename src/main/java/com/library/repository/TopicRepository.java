package com.library.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.library.model.ContentBean;
import com.library.model.TopicBean;
import java.sql.Statement;

public class TopicRepository {
	
	public List<TopicBean> getTopicsByCategory(int catId) {
	    List<TopicBean> list = new ArrayList<>();
	  
	    String sql = "SELECT * FROM topics WHERE categories_id = ? AND status = 'Active'";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        
	        ps.setInt(1, catId);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            TopicBean t = new TopicBean();
	            t.setTopicId(rs.getInt("topic_id"));
	            t.setTopicName(rs.getString("topic_name"));
	            t.setCatId(rs.getInt("categories_id"));
	            t.setStatus(rs.getString("status"));
	            list.add(t);
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return list;
	}
	
	public int saveTopic(TopicBean topic) {
	    int generatedId = 0;
	   
	    String sql = "INSERT INTO topics (topic_name, categories_id, user_id, status) VALUES (?, ?, ?, ?)";
	    
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
	        
	        ps.setString(1, topic.getTopicName());
	        ps.setInt(2, topic.getCatId());
	        ps.setInt(3, topic.getUserId());
	        ps.setString(4, topic.getStatus()); 
	        
	        ps.executeUpdate();
	        
	        try (ResultSet rs = ps.getGeneratedKeys()) {
	            if (rs.next()) {
	                generatedId = rs.getInt(1);
	            }
	        }
	    } catch (Exception e) { e.printStackTrace(); }
	    return generatedId;
	}
	
	
	public List<TopicBean> getAllTopicsWithCategory() {
	    List<TopicBean> list = new ArrayList<>();
	    
	    String sql = "SELECT t.*, c.categories_name FROM topics t " +
	                 "JOIN categories c ON t.categories_id = c.categories_id " +
	                 "ORDER BY t.topic_id DESC";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) { 

	        while (rs.next()) {
	            TopicBean t = new TopicBean();
	            t.setTopicId(rs.getInt("topic_id"));
	            t.setTopicName(rs.getString("topic_name"));
	            t.setCatId(rs.getInt("categories_id"));
	            t.setCategoryName(rs.getString("categories_name"));
	            t.setStatus(rs.getString("status")); 
	            list.add(t);
	        }
	    } catch (Exception e) { e.printStackTrace(); }
	    return list;
	}
	
	
	public int deleteTopic(int id) {
	    int result = 0;
	    
	    
	    String deleteRatings = "DELETE FROM rating WHERE topic_id = ?";
	    String deleteNotes = "DELETE FROM note WHERE topic_id = ?";
	    String deleteContents = "DELETE FROM contents WHERE topic_id = ?";
	    String deleteTopic = "DELETE FROM topics WHERE topic_id = ?";

	    Connection conn = null;
	    try {
	        conn = DBConnection.getConnection();
	        conn.setAutoCommit(false);

	       
	        try (PreparedStatement ps = conn.prepareStatement(deleteRatings)) {
	            ps.setInt(1, id);
	            ps.executeUpdate();
	        }

	      
	        try (PreparedStatement ps = conn.prepareStatement(deleteNotes)) {
	            ps.setInt(1, id);
	            ps.executeUpdate();
	        }

	        
	        try (PreparedStatement ps = conn.prepareStatement(deleteContents)) {
	            ps.setInt(1, id);
	            ps.executeUpdate();
	        }

	        
	        try (PreparedStatement ps = conn.prepareStatement(deleteTopic)) {
	            ps.setInt(1, id);
	            result = ps.executeUpdate();
	        }

	        conn.commit(); 
	        System.out.println("Topic and all related data deleted successfully.");

	    } catch (Exception e) {
	        if (conn != null) {
	            try {
	                conn.rollback(); 
	                } catch (SQLException ex) {
	                ex.printStackTrace();
	            }
	        }
	        e.printStackTrace();
	    } finally {
	        if (conn != null) {
	            try {
	                conn.setAutoCommit(true);
	                conn.close();
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	    return result;
	}
	
	
	public int updateTopicStatus(int topicId, String status) {
	    int result = 0;
	    
	    String sql = "UPDATE topics SET status = ? WHERE topic_id = ?";
	    
	    try (Connection con = DBConnection.getConnection()) {
	        PreparedStatement ps = con.prepareStatement(sql);
	        ps.setString(1, status);
	        ps.setInt(2, topicId);
	        result = ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return result;
	}
	public List<TopicBean> getTopicsWithContents(int catId) {
	    List<TopicBean> topicList = new ArrayList<>();
	    
	   	    String sql = "SELECT t.*, c.content_id, c.title, c.description, c.example_code, " +
	                "(SELECT IFNULL(AVG(r.rating_value), 0) FROM rating r WHERE r.topic_id = t.topic_id) as averageRating " +
	                "FROM topics t " +
	                "LEFT JOIN contents c ON t.topic_id = c.topic_id " +
	                "WHERE t.categories_id = ? AND t.status = 'Active' " +
	                "ORDER BY t.topic_id DESC";

	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        
	        ps.setInt(1, catId);
	        ResultSet rs = ps.executeQuery();

	        TopicBean currentTopic = null;

	        while (rs.next()) {
	            int topicId = rs.getInt("topic_id");

	            if (currentTopic == null || currentTopic.getTopicId() != topicId) {
	                currentTopic = new TopicBean();
	                currentTopic.setTopicId(topicId);
	                currentTopic.setTopicName(rs.getString("topic_name"));
	                
	                // --- Rating Logic  ---
	                double avg = rs.getDouble("averageRating");
	                if (rs.wasNull()) {
	                    currentTopic.setAvgRating(0.0);
	                } else {
	                    currentTopic.setAvgRating(avg);
	                }
	                // --------------------------------------

	                currentTopic.setContents(new ArrayList<>()); 
	                topicList.add(currentTopic);
	            }

	            int contentId = rs.getInt("content_id");
	            if (contentId > 0) {
	                ContentBean content = new ContentBean();
	                content.setContentId(contentId);
	                content.setTitle(rs.getString("title"));
	                content.setDescription(rs.getString("description"));
	                content.setExampleCode(rs.getString("example_code"));
	                currentTopic.getContents().add(content);
	            }
	        }
	    } catch (Exception e) { e.printStackTrace(); }
	    return topicList;
	}
	
	public int getRejectedCountByUser(int userId) {
	    String sql = "SELECT COUNT(*) FROM topics WHERE user_id = ? AND status = 'Rejected'";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, userId);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return 0;
	}
	public void banUser(int userId) {
	    String sql = "UPDATE users SET is_banned = 1 WHERE user_id = ?";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, userId);
	        ps.executeUpdate();
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
	public int getUserIdByTopicId(int topicId) {
	    String sql = "SELECT user_id FROM topics WHERE topic_id = ?";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, topicId);
	        ResultSet rs = ps.executeQuery();
	        if (rs.next()) {
	            return rs.getInt("user_id");
	        }
	    } catch (SQLException e) { e.printStackTrace(); }
	    return 0;
	}
	public int updateTopic(int id, String name, int catId, String description, String exampleCode) {
	    int result = 0;
	    
	    String sqlTopic = "UPDATE topics SET topic_name = ?, categories_id = ? WHERE topic_id = ?";
	   
	    String sqlContent = "UPDATE contents SET description = ?, example_code = ? WHERE topic_id = ?";
	    
	    Connection conn = null;
	    try {
	        conn = DBConnection.getConnection();
	        conn.setAutoCommit(false); 

	       
	        try (PreparedStatement ps = conn.prepareStatement(sqlTopic)) {
	            ps.setString(1, name);
	            ps.setInt(2, catId);
	            ps.setInt(3, id);
	            result = ps.executeUpdate();
	        }

	       
	        try (PreparedStatement ps = conn.prepareStatement(sqlContent)) {
	            ps.setString(1, description);
	            ps.setString(2, exampleCode);
	            ps.setInt(3, id);
	            ps.executeUpdate();
	        }

	        conn.commit();
	    } catch (Exception e) {
	        if (conn != null) try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }
	        e.printStackTrace();
	    } finally {
	        if (conn != null) try { conn.setAutoCommit(true); conn.close(); } catch (SQLException e) { e.printStackTrace(); }
	    }
	    return result;
	}

	
	public TopicBean getTopicById(int id) {
	    TopicBean topic = null;
	    
	    String sql = "SELECT t.*, c.description, c.example_code FROM topics t " +
	                 "LEFT JOIN contents c ON t.topic_id = c.topic_id WHERE t.topic_id = ?";
	    
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, id);
	        ResultSet rs = ps.executeQuery();
	        
	        if (rs.next()) {
	            topic = new TopicBean();
	            topic.setTopicId(rs.getInt("topic_id"));
	            topic.setTopicName(rs.getString("topic_name"));
	          
	            topic.setCatId(rs.getInt("categories_id")); 

	            List<ContentBean> contents = new ArrayList<>();
	            ContentBean content = new ContentBean();
	            content.setDescription(rs.getString("description"));
	            content.setExampleCode(rs.getString("example_code"));
	            contents.add(content);
	            topic.setContents(contents);
	        }
	    } catch (Exception e) { e.printStackTrace(); }
	    return topic;
	}
}

