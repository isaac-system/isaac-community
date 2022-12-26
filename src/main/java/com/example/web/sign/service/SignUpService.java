package com.example.web.sign.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.web.comm.dto.Developer;
import com.example.web.comm.dto.Users;
import com.example.web.sign.mapper.SignUpMapper;

@Service
public class SignUpService {
	@Autowired(required = false)
	SignUpMapper mapper;
	
	@Autowired(required = false)
	private JavaMailSender sender;
	
	public List<Developer> devTypeList() {
		return mapper.devTypeList();
	}
	
	public int idCheck(String user_id) {
		return mapper.idCheck(user_id);
	}
	
	public void userRegister(Users user) {
		BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
		user.setUser_image("/userImage/profile-1.png");
		user.setUser_password(passwordEncoder.encode(user.getPassword()));
		user.setAuth("ROLE_USER");
		mapper.userRegister(user);
		
	}
	
	public void updateUserInfo (Users user) {
		System.out.println("업데이트 완료");
		mapper.updateUserInfo(user);
	}
	
	public void updateUserImage(Users user) {
		mapper.updateUserImage(user);
	}
	
	public void updateUserValidation(Users user) {
		mapper.updateUserValidation(user);
	}
	
	public void deleteUser (String user_id) {
		mapper.deleteUser(user_id);
	}
	
	public int emailCheck(String user_id) {
		return mapper.emailCheck(user_id);
	}
}
