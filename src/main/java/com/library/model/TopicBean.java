package com.library.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class TopicBean {
	private int topicId;
    private String topicName;
    private int catId;
    private String categoryName;
    private int userId;
    private String status;
    private Timestamp createdAt;
    
    private double avgRating;  
    private int totalRatings;

    private List<NoteBean> notes = new ArrayList<>();
    private List<ContentBean> contents;
    
}
