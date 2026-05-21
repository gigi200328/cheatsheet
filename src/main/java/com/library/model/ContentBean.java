package com.library.model;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class ContentBean {
	private int contentId;
    private String title;
    private String description;
    private int topicId;
    private int categoriesId;
    private String exampleCode;
    

}
