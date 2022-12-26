package com.example.web.comm.controller;


import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.web.board.service.HistoryService;
import com.example.web.comm.dto.Users;
import com.example.web.login.service.LoginService;
import com.example.web.sign.service.SignUpService;

@Controller
@RequestMapping("/users")
public class UserController {
	
	@Autowired(required = false)
	private LoginService userService;
	
	@Autowired(required = false)
	private SignUpService signUpService;
	
	
	@Autowired(required = false)
	private HistoryService historyService;
	
	// user article History
	@GetMapping("/articles")
	public String userArticle(@RequestParam(value = "user_id", defaultValue = "") String user_id
			, Model d) {
		d.addAttribute("userInfo", userService.getUserInfo(user_id));
		d.addAttribute("articleList", historyService.getBoardHistoryList(user_id));
		return "users";
	}
	
	// user activity History
	@GetMapping("/activity")
	public String userActivity(@RequestParam(value = "user_id", defaultValue = "") String user_id
			, Model d) {
		d.addAttribute("userInfo", userService.getUserInfo(user_id));
		d.addAttribute("articleList", historyService.getActivityHistoryList(user_id));
		return "users";
	}
	
	@GetMapping("/profile")
	public String userProfile(Model d) {
		d.addAttribute("devList", signUpService.devTypeList());
		return "profile";
	}
	
	@PostMapping("/profile")
	public String updateUserInfo(Model d, Users user) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Users userDetails = (Users) authentication.getPrincipal();
		
		// 회원 정보 수정
		String userId = userDetails.getUser_id();
		
		user.setUser_id(userId);
		
		signUpService.updateUserInfo(user);
		
	    // 회원 정보 수정후  
	    
	    
	    // 현재 Authentication로 사용자 인증 후 새 Authentication 정보를 SecurityContextHolder에 세팅
	    SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(authentication,userId));

		return "redirect:profile";
	}
	// Authentication 의 createNewAuthentication 메서드를 불러와서 다시 처리 하는 로직을 짜준다.
	// currentAuth는 현재 사용자의 Authentication 이다.
	
	private Authentication createNewAuthentication(Authentication currentAuth, String username) {
		UserDetails newPrincipal = userService.loadUserByUsername(username);
	    UsernamePasswordAuthenticationToken newAuth = new UsernamePasswordAuthenticationToken(newPrincipal, currentAuth.getCredentials(), newPrincipal.getAuthorities());
	    newAuth.setDetails(currentAuth.getDetails());
	    return newAuth;
	}

	@GetMapping("/account")
	public String userAccount(Model d) {
		return "account";
	}
	
	@PostMapping("/account")
	public String deleteUserAccount(@RequestParam(value = "user_id", defaultValue = "") String user_id, HttpSession session) {
		session.invalidate();
		signUpService.deleteUser(user_id);
		return "redirect:/";
	}
	
}
