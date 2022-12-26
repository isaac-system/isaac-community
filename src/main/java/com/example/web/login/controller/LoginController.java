	package com.example.web.login.controller;
	
	import org.springframework.beans.factory.annotation.Autowired;
	
	
	import org.springframework.security.core.Authentication;
	import org.springframework.security.core.context.SecurityContextHolder;
	import org.springframework.stereotype.Controller;
	import org.springframework.ui.Model;
	import org.springframework.web.bind.annotation.GetMapping;
	import org.springframework.web.bind.annotation.RequestMapping;
	import org.springframework.web.bind.annotation.ResponseBody;
	
	import com.example.web.login.service.LoginService;
	@Controller
	public class LoginController {
		@Autowired(required = false)
		LoginService service;
		
		@RequestMapping("/login")
		public String login () {
			return "login";
		}
		
	    @ResponseBody
	    @GetMapping("/auth")
	    public Authentication auth(Model model){
	        return SecurityContextHolder.getContext().getAuthentication();
	    }
	    
	}
