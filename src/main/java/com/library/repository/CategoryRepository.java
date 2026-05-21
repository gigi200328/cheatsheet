package com.library.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.library.model.CategoriesBean;

public class CategoryRepository {
	
	public List<CategoriesBean> getAllCategories() {
	    List<CategoriesBean> list = new ArrayList<>();
	  
	    String sql = "SELECT * FROM categories ORDER BY categories_id DESC"; 
	    
	    try (Connection conn = DBConnection.getConnection()) { 
	        PreparedStatement ps = conn.prepareStatement(sql);
	        ResultSet rs = ps.executeQuery();
	        while (rs.next()) {
	            CategoriesBean cat = new CategoriesBean();
	            cat.setCategoriesId(rs.getInt("categories_id"));
	            cat.setCategoriesName(rs.getString("categories_name"));
	            cat.setViewsCount(rs.getInt("views_count"));
	            list.add(cat);
	        }
	    } catch (Exception e) { 
	        e.printStackTrace(); 
	    }
	    return list;
	}

	public int addCategory(String name) {
	    int result = 0;
	    String sql = "INSERT INTO categories (categories_name) VALUES (?)";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setString(1, name);
	        result = ps.executeUpdate();
	    } catch (Exception e) { e.printStackTrace(); }
	    return result;
	}

	
	public int deleteCategory(int id) {
	    int result = 0;
	    String sql = "DELETE FROM categories WHERE categories_id = ?";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, id);
	        result = ps.executeUpdate();
	    } catch (Exception e) { e.printStackTrace(); }
	    return result;
	}

	public int updateCategory(int id, String name) {
        int result = 0;
        String sql = "UPDATE categories SET categories_name = ? WHERE categories_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setInt(2, id);
            result = ps.executeUpdate();
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return result;
    }
	public int getTotalTopicsCount() {
	    int count = 0;
	  
	    String sql = "SELECT COUNT(*) FROM topics"; 
	    
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql);
	         ResultSet rs = ps.executeQuery()) {
	        
	        if (rs.next()) {
	            count = rs.getInt(1); 
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return count;
	}
	public void incrementViewCount(int categoryId) {
	    String sql = "UPDATE categories SET views_count = views_count + 1 WHERE categories_id = ?";
	    try (Connection conn = DBConnection.getConnection();
	         PreparedStatement ps = conn.prepareStatement(sql)) {
	        ps.setInt(1, categoryId);
	        ps.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	}
}
