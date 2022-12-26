package com.example.web.login.mapper;


import org.apache.ibatis.annotations.Mapper;

import com.example.web.comm.dto.Users;


@Mapper
public interface LoginMapper {
	
	public int loginCk(Users user);
	
	public Users getUserInfo (String user_id);
	
	public Users getUserById (String user_id); 
}
