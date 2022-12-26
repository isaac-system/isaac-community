package com.example.web.board.dto;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class BoardVO {
	
	private int board_no;
	private String user_id;
	private int board_type_id;
	private String board_title;
	private String board_contents;
	private int views;
	private int likes;
	private String tags;
	// 파일
	private List<MultipartFile> fileList;
	private String file_name;
	private String file_original_name;
	// 위치 정보
	private String address_name;
	
	private int commentCnt;
	private Date created_at;
	private Date updated_at;
	
	//tb_users
	//u.USER_NICKNAME, u.USER_IMAGE
	private String user_nickName;
	private String user_image;
	
	// board_Type
	private String board_type;
	
	public BoardVO() {
		super();
		// TODO Auto-generated constructor stub
	}


	public int getBoard_no() {
		return board_no;
	}


	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public String getUser_id() {
		return user_id;
	}

	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}

	public int getBoard_type_id() {
		return board_type_id;
	}


	public void setBoard_type_id(int board_type_id) {
		this.board_type_id = board_type_id;
	}


	public String getBoard_title() {
		return board_title;
	}


	public void setBoard_title(String board_title) {
		this.board_title = board_title;
	}


	public String getBoard_contents() {
		return board_contents;
	}


	public void setBoard_contents(String board_contents) {
		this.board_contents = board_contents;
	}


	public int getViews() {
		return views;
	}


	public void setViews(int views) {
		this.views = views;
	}


	public int getLikes() {
		return likes;
	}


	public void setLikes(int likes) {
		this.likes = likes;
	}


	public String getTags() {
		return tags;
	}


	public void setTags(String tags) {
		this.tags = tags;
	}

	
	public String getFile_name() {
		return file_name;
	}

	public String getFile_original_name() {
		return file_original_name;
	}


	public void setFile_original_name(String file_original_name) {
		this.file_original_name = file_original_name;
	}


	public List<MultipartFile> getFileList() {
		return fileList;
	}
	

	public void setFileList(List<MultipartFile> fileList) {
		this.fileList = fileList;
	}


	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}

	public String getAddress_name() {
		return address_name;
	}

	public void setAddress_name(String address_name) {
		this.address_name = address_name;
	}

	public int getCommentCnt() {
		return commentCnt;
	}


	public void setCommentCnt(int commentCnt) {
		this.commentCnt = commentCnt;
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


	public String getBoard_type() {
		return board_type;
	}


	public void setBoard_type(String board_type) {
		this.board_type = board_type;
	}

	public String getUser_nickName() {
		return user_nickName;
	}


	public void setUser_nickName(String user_nickName) {
		this.user_nickName = user_nickName;
	}


	public String getUser_image() {
		return user_image;
	}


	public void setUser_image(String user_image) {
		this.user_image = user_image;
	}

	
}
