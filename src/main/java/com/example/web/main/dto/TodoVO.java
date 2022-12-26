package com.example.web.main.dto;

import java.util.Date;

public class TodoVO {
	
	private int todo_id;
	private String user_id;
	private String todo_contents;
	private boolean todo_checked;
	private Date created_at;
	private Date updated_at;
	
	public int getTodo_id() {
		return todo_id;
	}
	public void setTodo_id(int todo_id) {
		this.todo_id = todo_id;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getTodo_contents() {
		return todo_contents;
	}
	public void setTodo_contents(String todo_contents) {
		this.todo_contents = todo_contents;
	}
	public boolean isTodo_checked() {
		return todo_checked;
	}
	public void setTodo_checked(boolean todo_checked) {
		this.todo_checked = todo_checked;
	}
	public Date getCreated_at() {
		return created_at;
	}
	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}
	public Date getUpdated_at() {
		return updated_at;
	}
	public void setUpdated_at(Date updated_at) {
		this.updated_at = updated_at;
	}
	
	

}
