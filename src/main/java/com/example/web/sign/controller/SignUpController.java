package com.example.web.sign.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.web.comm.dto.Users;
import com.example.web.comm.service.MailSenderService;
import com.example.web.sign.service.SignUpService;

@Controller
public class SignUpController {
	@Autowired(required = false)
	private SignUpService service;
	
	@Autowired(required = false)
	private MailSenderService mailService;
	
	@GetMapping("/signUp")
	public String signUpPage(Model d) {
		d.addAttribute("devList", service.devTypeList());
		return "signUp";
	}
	
	@PostMapping("/signUp")
	public String signUpCheckId(Model d,@Valid Users user) {
		service.userRegister(user);
		//mailService.sendMail(user.getUser_email());
		return "redirect:login";
	}
	
	@ResponseBody
	@PostMapping("/idCheck")
	public int IdCheck(@RequestParam String user_id) {
		int count = 0;
		if(user_id != null) {
			count = service.idCheck(user_id);
		}
		return count;
	}
}
