package com.library.model;

import lombok.Getter;
import lombok.Setter;
@Getter
@Setter
public class NoteBean {

	private int noteId;
    private String content;  
    private String userName; 
    private int userId;
    private int topicId;
    private int catId;
    private int isPublic;
    private int parentId;
}
