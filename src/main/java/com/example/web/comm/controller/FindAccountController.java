package com.example.web.comm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.web.comm.dto.Users;
import com.example.web.comm.service.MailSenderService;


@Controller
public class FindAccountController {
	
	@Autowired(required = false)
	private MailSenderService mailService;
	
	@RequestMapping(value =  "/forgot", method = RequestMethod.GET)
	public String forgot() {
		return "forgot";
	}
	
	@RequestMapping(value =  "/forgot", method = RequestMethod.POST)
	public String findAccount(@RequestParam(value = "user_email", defaultValue = "") String user_email) {
		Users user = new Users();
		user.setUser_email(user_email);
		mailService.sendEmailAccount(user);
		return "redirect:login";
	}
	
}
