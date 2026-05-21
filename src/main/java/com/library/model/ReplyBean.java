package com.library.model;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
@Setter
@Getter
public class ReplyBean {
	private int replyId;
    private int postId;
    private int userId;
    private String replyContent;
    private String userName;
    private Timestamp createdAt;
    private int parentReplyId;       
    private String parentUserName;
    private List<ReplyBean> nestedReplies;

}
