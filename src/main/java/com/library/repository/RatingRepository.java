package com.library.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RatingRepository {
    
    public boolean addRating(int ratingValue, int userId, int topicId) {
        String sql = "INSERT INTO rating (rating_value, user_id, topic_id) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, ratingValue);
            pst.setInt(2, userId);
            pst.setInt(3, topicId);
            return pst.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 🌟 ၁။ Topic အလိုက် ပျမ်းမျှ Rating တွက်ချက်ရန် (ဥပမာ - 4.5 Stars)
    public double getAverageRatingByTopicId(int topicId) {
        String sql = "SELECT AVG(rating_value) AS avg_rating FROM rating WHERE topic_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, topicId);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("avg_rating");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    // 👥 ၂။ Topic အလိုက် Vote ပေးသူ စုစုပေါင်း (Total Users) တွက်ချက်ရန်
    public int getTotalRatingsByTopicId(int topicId) {
        String sql = "SELECT COUNT(*) AS total_rating FROM rating WHERE topic_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, topicId);
            try (ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total_rating");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}