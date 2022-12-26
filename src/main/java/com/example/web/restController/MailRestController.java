package com.example.web.restController;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.web.comm.service.MailSenderService;



@RestController
public class MailRestController {
	
	@Autowired(required = false)
	private MailSenderService service;
	
	@RequestMapping("/sendMail")
	public String sendMail (@RequestParam(value = "user_email", defaultValue = "") String user_email) {
		return service.sendMail(user_email);
	}
	
	
}
