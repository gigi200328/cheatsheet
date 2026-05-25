package com.library.model;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class LoginBean {
        
	private String name;
	private String email;
	private String password;
	private int userId;
	private String role;
	private String createdAt;
	private int isBanned;
	
}
