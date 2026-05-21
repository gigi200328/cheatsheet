package com.library.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import com.library.model.ReplyBean;

public class ReplyRepository {

   
    public int addReply(int postId, int userId, String replyContent, Integer parentReplyId) {
        int result = 0;
        String sql = "INSERT INTO post_replies (post_id, user_id, reply_content, parent_reply_id) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            ps.setString(3, replyContent);
            
            if (parentReplyId != null) {
                ps.setInt(4, parentReplyId);
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

   
    public List<ReplyBean> getRepliesByPostId(int postId) {
        List<ReplyBean> allReplies = new ArrayList<>();
       
        String sql = "SELECT r.*, u.user_name AS user_name, pr.user_id AS parent_user_id, pu.user_name AS parent_user_name " +
                     "FROM post_replies r " +
                     "JOIN users u ON r.user_id = u.user_id " +
                     "LEFT JOIN post_replies pr ON r.parent_reply_id = pr.reply_id " +
                     "LEFT JOIN users pu ON pr.user_id = pu.user_id " +
                     "WHERE r.post_id = ? " +
                     "ORDER BY r.created_at ASC";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, postId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ReplyBean reply = new ReplyBean();
                    reply.setReplyId(rs.getInt("reply_id"));
                    reply.setPostId(rs.getInt("post_id"));
                    reply.setUserId(rs.getInt("user_id"));
                    reply.setReplyContent(rs.getString("reply_content"));
                    reply.setUserName(rs.getString("user_name")); 
                    reply.setCreatedAt(rs.getTimestamp("created_at"));
                    
                    reply.setParentReplyId(rs.getInt("parent_reply_id"));
                    if (rs.wasNull()) {
                        reply.setParentReplyId(0); 
                    }
                    reply.setParentUserName(rs.getString("parent_user_name"));
                    reply.setNestedReplies(new ArrayList<>()); 
                    
                    allReplies.add(reply);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        
        List<ReplyBean> parentReplies = new ArrayList<>();
        
        // အဆင့် (၁) - ပင်မ Comment (parent_reply_id == 0) များကို သီးသန့် အရင်ထုတ်ယူမည်
        for (ReplyBean r : allReplies) {
            if (r.getParentReplyId() == 0) {
                parentReplies.add(r);
            }
        }

        
        for (ReplyBean r : allReplies) {
            if (r.getParentReplyId() > 0) {
                for (ReplyBean parent : parentReplies) {
                    if (parent.getReplyId() == r.getParentReplyId()) {
                        parent.getNestedReplies().add(r);
                        break; 
                    }
                }
            }
        }

       
        return parentReplies;
    }
}