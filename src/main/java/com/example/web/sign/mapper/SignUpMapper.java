package com.example.web.sign.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.example.web.comm.dto.Developer;
import com.example.web.comm.dto.Users;

@Mapper
public interface SignUpMapper {
	public List<Developer> devTypeList();
	// 아이디 중복 체크
	public int idCheck(String user_id);
	// 회원 등록
	public void userRegister(Users user);
	// 회원 정보 수정
	public void updateUserInfo(Users user);
	// 회원 비밀번호 수정
	public void updateUserPassword(Users user);
	// 회원 이미지 수정
	public void updateUserImage(Users user);
	// 회워 이메일 인증
	public void updateUserValidation(Users user);
	// 회원 삭제
	public void deleteUser(String user_id);
	// 회원 이메일 인증
	public int emailCheck(String user_id);
}
