package com.example.web.comm.dto;

import java.util.Collection;
import java.util.Collections;
import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class Users implements UserDetails{
	private String user_id;
	private int dev_id;
	private String user_password;
	private String user_name;
	@Pattern(regexp = "^\\d{2,3}-\\d{3,4}-\\d{4}$", message="Valid 해드폰 번호의 양식과 맞지 않습니다. 01x-xxxx-xxxx")
	private String user_tel;
	private String auth;
	private Date created_at;
	private Date updated_at;
	private String user_nickName;
	@Email(message = "이메일 형식이 맞지 않습니다.")
	private String user_email;
	private boolean user_validation;
	
	// 유저가 쓴 게시물 수
	private int writeCnt;
	// 개발 유형 이름
	private String dev_name;
	// 유저 이미지
	private String user_image;
	
	public Users() {
	}

	public Users(String user_password, @Email(message = "이메일 형식이 맞지 않습니다.") String user_email) {
		this.user_password = user_password;
		this.user_email = user_email;
	}
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getDev_id() {
		return dev_id;
	}
	public void setDev_id(int dev_id) {
		this.dev_id = dev_id;
	}
	public String getUser_password() {
		return user_password;
	}
	public void setUser_password(String user_password) {
		this.user_password = user_password;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_tel() {
		return user_tel;
	}
	public void setUser_tel(String user_tel) {
		this.user_tel = user_tel;
	}
	public String getAuth() {
		return auth;
	}
	public void setAuth(String auth) {
		this.auth = auth;
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
	public int getWriteCnt() {
		return writeCnt;
	}
	public void setWriteCnt(int writeCnt) {
		this.writeCnt = writeCnt;
	}
	public String getUser_nickName() {
		return user_nickName;
	}
	public void setUser_nickName(String user_nickName) {
		this.user_nickName = user_nickName;
	}
	public String getUser_email() {
		return user_email;
	}
	public void setUser_email(String user_email) {
		this.user_email = user_email;
	}
	public boolean isUser_validation() {
		return user_validation;
	}
	public void setUser_validation(boolean user_validation) {
		this.user_validation = user_validation;
	}
	public String getDev_name() {
		return dev_name;
	}
	public void setDev_name(String dev_name) {
		this.dev_name = dev_name;
	}
	public String getUser_image() {
		return user_image;
	}
	public void setUser_image(String user_image) {
		this.user_image = user_image;
	}

	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return Collections.singletonList(new SimpleGrantedAuthority(this.auth));
	}

	@Override
	public String getPassword() {
		return this.user_password;
	}

	@Override
	public String getUsername() {
		return this.user_id;
	}

	@Override
	public boolean isAccountNonExpired() {
		return true;
	}

	@Override
	public boolean isAccountNonLocked() {
		return true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}

	@Override
	public boolean isEnabled() {
		return true;
	}
	
	
}
