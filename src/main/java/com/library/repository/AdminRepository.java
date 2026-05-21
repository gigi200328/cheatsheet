package com.library.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.library.model.TopicBean;

public class AdminRepository {

   
    public int getTotalCategories() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM categories";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

   
    public int getTotalTopics() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM topics";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

  
    public int getTotalUsers() {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM users"; 
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return count;
    }

   
    public List<TopicBean> getRecentTopics() {
        List<TopicBean> list = new ArrayList<>();
        
        String sql = "SELECT t.*, c.categories_name FROM topics t " +
                     "JOIN categories c ON t.categories_id = c.categories_id " +
                     "ORDER BY t.topic_id DESC LIMIT 5";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            
            while (rs.next()) {
                TopicBean t = new TopicBean();
                t.setTopicId(rs.getInt("topic_id"));
                t.setTopicName(rs.getString("topic_name"));
                
                t.setCatId(rs.getInt("categories_id")); 
                list.add(t);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
}