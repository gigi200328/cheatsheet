package com.library.repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.library.model.CommunityBean;
import com.library.model.ReplyBean;

public class CommunityRepository {

    public List<CommunityBean> getAllPosts() {
        List<CommunityBean> postList = new ArrayList<>();
        String postSql = "SELECT c.*, u.user_name FROM community_posts c " +
                         "JOIN users u ON c.user_id = u.user_id ORDER BY c.created_at DESC"; 
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement psPost = conn.prepareStatement(postSql);
             ResultSet rsPost = psPost.executeQuery()) { 
            
            while (rsPost.next()) {
                CommunityBean post = new CommunityBean();
                int postId = rsPost.getInt("post_id");
                post.setPostId(postId);
                post.setUserId(rsPost.getInt("user_id"));
                post.setUserName(rsPost.getString("user_name"));
                post.setTitle(rsPost.getString("title"));
                post.setContent(rsPost.getString("content"));
                post.setPost_type(rsPost.getString("post_type"));
                post.setCreatedAt(rsPost.getTimestamp("created_at"));
                
                List<ReplyBean> allReplies = new ArrayList<>();
                String replySql = "SELECT r.*, u.user_name, pu.user_name AS parent_user_name " +
                                  "FROM post_replies r " +
                                  "JOIN users u ON r.user_id = u.user_id " +
                                  "LEFT JOIN post_replies pr ON r.parent_reply_id = pr.reply_id " +
                                  "LEFT JOIN users pu ON pr.user_id = pu.user_id " +
                                  "WHERE r.post_id = ? ORDER BY r.created_at ASC";

                try (PreparedStatement psReply = conn.prepareStatement(replySql)) {
                    psReply.setInt(1, postId);
                    try (ResultSet rsReply = psReply.executeQuery()) {
                        while (rsReply.next()) {
                            ReplyBean reply = new ReplyBean();
                            reply.setReplyId(rsReply.getInt("reply_id"));
                            reply.setPostId(rsReply.getInt("post_id"));
                            reply.setReplyContent(rsReply.getString("reply_content"));
                            reply.setUserName(rsReply.getString("user_name"));
                            
                            int pId = rsReply.getInt("parent_reply_id");
                            if (rsReply.wasNull()) {
                                reply.setParentReplyId(0);
                            } else {
                                reply.setParentReplyId(pId);
                            }
                            
                            reply.setParentUserName(rsReply.getString("parent_user_name"));
                            reply.setCreatedAt(rsReply.getTimestamp("created_at"));
                            reply.setNestedReplies(new ArrayList<>()); 
                            
                            allReplies.add(reply);
                        }
                    }
                }

                // 🎯 [Tree Structure Filter Logic - Map ဖြင့် အဆင့်ဆင့် ချိတ်ဆက်ပုံစံအမှန်]
                List<ReplyBean> parentReplies = new ArrayList<>();
                Map<Integer, ReplyBean> replyMap = new HashMap<>();

                // အဆင့် (၁) - Reply အားလုံးကို ID အလိုက် Map ထဲ အရင်မှတ်ထားမယ်
                for (ReplyBean r : allReplies) {
                    replyMap.put(r.getReplyId(), r);
                }

                // အဆင့် (၂) - ဆင့်ပွား Reply တွေကို မိခင် Parent ဆီ ကွက်တိ သွားထည့်မယ်
                for (ReplyBean r : allReplies) {
                    int pId = r.getParentReplyId();
                    if (pId == 0) {
                        // ပင်မကွန်မန့်စစ်စစ်ဆိုရင် တန်းထည့်မယ်
                        parentReplies.add(r);
                    } else {
                        // ဆင့်ပွား (Nested) ဖြစ်ရင် သူ့ကို တိုက်ရိုက် Reply ပြန်ထားတဲ့ မိခင်ဆီ သွားထည့်မယ်
                        ReplyBean immediateParent = replyMap.get(pId);
                        if (immediateParent != null) {
                            immediateParent.getNestedReplies().add(r);
                        } else {
                            // အကယ်၍ ရှာမတွေ့ခဲ့ရင် မပျောက်သွားအောင် ပင်မ List ထဲ ခေတ္တ ထည့်ထားပေးမယ်
                            parentReplies.add(r);
                        }
                    }
                }

                post.setReplies(parentReplies); 
                postList.add(post);
            }
        } catch (Exception e) { e.printStackTrace(); }
        return postList;
    }
   
    public List<CommunityBean> getPostsByType(String postType) {
        List<CommunityBean> postList = new ArrayList<>();
        String postSql = "SELECT c.*, u.user_name AS user_name FROM community_posts c " +
                         "JOIN users u ON c.user_id = u.user_id " +
                         "WHERE c.post_type = ? " +
                         "ORDER BY c.created_at DESC"; 
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement psPost = conn.prepareStatement(postSql)) {
            
            psPost.setString(1, postType);
            try (ResultSet rsPost = psPost.executeQuery()) {
                while (rsPost.next()) {
                    CommunityBean post = new CommunityBean();
                    int postId = rsPost.getInt("post_id");
                    post.setPostId(postId);
                    post.setUserId(rsPost.getInt("user_id"));
                    post.setUserName(rsPost.getString("user_name"));
                    post.setTitle(rsPost.getString("title"));
                    post.setContent(rsPost.getString("content"));
                    post.setPost_type(rsPost.getString("post_type"));
                    post.setCreatedAt(rsPost.getTimestamp("created_at"));
                    
                    List<ReplyBean> allReplies = new ArrayList<>();
                    String replySql = "SELECT r.*, u.user_name, pu.user_name AS parent_user_name " +
                                      "FROM post_replies r " +
                                      "JOIN users u ON r.user_id = u.user_id " +
                                      "LEFT JOIN post_replies pr ON r.parent_reply_id = pr.reply_id " +
                                      "LEFT JOIN users pu ON pr.user_id = pu.user_id " +
                                      "WHERE r.post_id = ? ORDER BY r.created_at ASC";

                    try (PreparedStatement psReply = conn.prepareStatement(replySql)) {
                        psReply.setInt(1, postId);
                        try (ResultSet rsReply = psReply.executeQuery()) {
                            while (rsReply.next()) {
                                ReplyBean reply = new ReplyBean();
                                reply.setReplyId(rsReply.getInt("reply_id"));
                                reply.setPostId(rsReply.getInt("post_id"));
                                reply.setReplyContent(rsReply.getString("reply_content"));
                                reply.setUserName(rsReply.getString("user_name"));
                                
                                int pId = rsReply.getInt("parent_reply_id");
                                if (rsReply.wasNull()) {
                                    reply.setParentReplyId(0);
                                } else {
                                    reply.setParentReplyId(pId);
                                }
                                
                                reply.setParentUserName(rsReply.getString("parent_user_name"));
                                reply.setCreatedAt(rsReply.getTimestamp("created_at"));
                                reply.setNestedReplies(new ArrayList<>());
                                
                                allReplies.add(reply);
                            }
                        }
                    }

                    // 🎯 [Tree Structure Filter Logic - Map ဖြင့် အဆင့်ဆင့် ချိတ်ဆက်ပုံစံအမှန်]
                    List<ReplyBean> parentReplies = new ArrayList<>();
                    Map<Integer, ReplyBean> replyMap = new HashMap<>();

                    for (ReplyBean r : allReplies) {
                        replyMap.put(r.getReplyId(), r);
                    }

                    for (ReplyBean r : allReplies) {
                        int pId = r.getParentReplyId();
                        if (pId == 0) {
                            parentReplies.add(r);
                        } else {
                            ReplyBean immediateParent = replyMap.get(pId);
                            if (immediateParent != null) {
                                immediateParent.getNestedReplies().add(r);
                            } else {
                                parentReplies.add(r);
                            }
                        }
                    }

                    post.setReplies(parentReplies); 
                    postList.add(post);
                }
            }
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return postList;
    }

    public int addPost(int userId, String title, String content, String postType) {
        int result = 0;
        String sql = "INSERT INTO community_posts (user_id, title, content, post_type) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ps.setString(2, title);
            ps.setString(3, content);
            ps.setString(4, postType);
            
            result = ps.executeUpdate();
        } catch (Exception e) { 
            e.printStackTrace(); 
        }
        return result;
    }

    public int addReply(int postId, int userId, String replyContent, Integer parentReplyId) {
        int result = 0;
        String sql = "INSERT INTO post_replies (post_id, user_id, reply_content, parent_reply_id) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, postId);
            ps.setInt(2, userId);
            ps.setString(3, replyContent);
            
            if (parentReplyId == null || parentReplyId == 0) {
                ps.setNull(4, java.sql.Types.INTEGER);
            } else {
                ps.setInt(4, parentReplyId);
            }
            
            result = ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }
}