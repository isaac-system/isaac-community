package com.example.web.comm.dto;

public class EmailVO {
	
	// 제목
	private String title;  
	// 수신자
	private String reciver;
	// 내용
	private String content;
	
	// 발신자
	private String sender;

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getReciver() {
		return reciver;
	}

	public void setReciver(String reciver) {
		this.reciver = reciver;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSender() {
		return sender;
	}

	public void setSender(String sender) {
		this.sender = sender;
	}
	
	
	
	

}
