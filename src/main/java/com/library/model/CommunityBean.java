package com.library.model;

import java.sql.Timestamp;
import java.util.List;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class CommunityBean {
	private int postId;
	private int userId;
	private String userName;
	private String title;
	private String content;
	private String post_type;
	private Timestamp createdAt;
	private List<ReplyBean> replies;
}
