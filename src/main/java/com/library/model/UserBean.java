package com.library.model;

import java.security.Timestamp;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class UserBean {
	private String name;
	private String email;
	private String password;
	private Timestamp createdAt;
	private String role;
	private int userId;

}
