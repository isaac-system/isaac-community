package com.example.web.login.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.example.web.comm.dto.Users;
import com.example.web.login.mapper.LoginMapper;

@Service
public class LoginService implements UserDetailsService{
	
	@Autowired(required = false)
	LoginMapper usermaper;
	
	public int loginCk(Users user){
		return usermaper.loginCk(user);
	}
	
	public Users getUserInfo (String user_id) {
		return usermaper.getUserInfo(user_id);
	}

	@Override
    public Users loadUserByUsername(String user_id) throws UsernameNotFoundException {
        //여기서 받은 유저 패스워드와 비교하여 로그인 인증
		Users userVo = usermaper.getUserInfo(user_id);
		
        if (userVo == null){
            throw new UsernameNotFoundException("User not authorized.");
        } 
        
        return userVo;
    }
	
}
