package com.example.web.comm.dto;

import java.util.Date;

public class FileVO {
	private int file_id;
	private int board_no;
	private String file_path;
	private String file_name;
	private String file_originalName;
	private Date created_at;
	private Date updated_at;
	
	public FileVO(String file_path, String file_name ,String file_originalName) {
		super();
		this.file_path = file_path;
		this.file_name = file_name;
		this.file_originalName = file_originalName;
	}
	public int getFile_id() {
		return file_id;
	}
	public void setFile_id(int file_id) {
		this.file_id = file_id;
	}
	public int getBoard_no() {
		return board_no;
	}
	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getFile_originalName() {
		return file_originalName;
	}
	public void setFile_originalName(String file_originalName) {
		this.file_originalName = file_originalName;
	}
	public String getFile_path() {
		return file_path;
	}
	public void setFile_path(String file_path) {
		this.file_path = file_path;
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
