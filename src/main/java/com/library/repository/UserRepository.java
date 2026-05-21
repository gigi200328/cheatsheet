package com.library.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.library.model.LoginBean;

public class UserRepository {
    
    public boolean isValidUser(String name, String password) {
        boolean status = false;
        
        
        String sql = "SELECT * FROM users WHERE user_name=? AND password=? AND is_banned = 0";
        
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, password);
            
            ResultSet rs = ps.executeQuery();
            status = rs.next();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
    
    public int registerUser(String name, String email, String password) {
        int result = 0;
       
        String sql = "INSERT INTO users (user_name, email, password, create_at) values(?,?,?,NOW())";
        
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            
            result = ps.executeUpdate(); 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
    public LoginBean getUserByNameAndPassword(String name, String password) {
       
        String sql = "SELECT * FROM users WHERE (user_name = ? OR email = ?) AND password = ? AND is_banned = 0";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, name);
            ps.setString(2, name);
            ps.setString(3, password);
            
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                LoginBean user = new LoginBean();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("user_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
              
                return user;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    public List<LoginBean> getAllUsers() {
        List<LoginBean> list = new ArrayList<>();
        
        String sql = "SELECT user_id, user_name, email, role, is_banned, create_at FROM users ORDER BY user_id DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                LoginBean user = new LoginBean();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("user_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setCreatedAt(rs.getString("create_at"));
               
                list.add(user);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return list;
    }

    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) { e.printStackTrace(); return false; }
    } 
    
    public int registerUserWithRole(String name, String email, String password, String role) {
        int result = 0;
        String sql = "INSERT INTO users (user_name, email, password, role, create_at) values(?,?,?,?,NOW())";
        
        try (Connection con = DBConnection.getConnection()) {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);
            ps.setString(4, role); 
            result = ps.executeUpdate(); 
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public LoginBean selectUser(int id) {
        LoginBean user = null;
        String sql = "SELECT user_id, user_name, email, role FROM users WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                user = new LoginBean();
                user.setUserId(rs.getInt("user_id"));
                user.setName(rs.getString("user_name"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    
    public boolean updateUser(LoginBean user) {
        boolean rowUpdated = false;
        String sql = "UPDATE users SET user_name = ?, email = ?, role = ? WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getRole());
            ps.setInt(4, user.getUserId());
            
            rowUpdated = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }
    public boolean updateProfile(int userId, String userName, String password) {
        boolean rowUpdated = false;
        String sql = "UPDATE users SET user_name = ?, password = ? WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, userName);
            ps.setString(2, password);
            ps.setInt(3, userId);
            
            rowUpdated = ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return rowUpdated;
    }
   
}