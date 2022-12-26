package com.example.web.restController;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.example.web.comm.dto.Users;
import com.example.web.login.service.LoginService;
import com.example.web.sign.service.SignUpService;

@RestController
public class UserRestController {
	
	@Autowired(required = false)
	private SignUpService service;
	
	@Autowired(required = false)
	private JavaMailSender sender;

	@Autowired(required = false)
	private LoginService loginService;
	
	@Value("${userImageUpload}")
	private String userImagepath;
		
	@RequestMapping("/uploadUserImageFile")
	public Map<String, String> uploadUserImageFile(@RequestParam("user_image") MultipartFile user_image,
			HttpServletRequest request
			) {
		
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		Users userDetails = (Users) authentication.getPrincipal();
		
		Map<String, String> map = new HashMap<>(); 
		
		System.out.println("파일 크기 : "+user_image.getSize());
		
		String originalFileName = user_image.getOriginalFilename();	//오리지날 파일명
		String extension = originalFileName.substring(originalFileName.lastIndexOf("."));	//파일 확장자
		
		String fileName = UUID.randomUUID() + extension;
		
		File file = new File(userImagepath+fileName);
		
		try {
			user_image.transferTo(file);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		map.put("url", "/userImage/"+fileName);
		
		userDetails.setUser_image("/userImage/"+fileName);
		
		service.updateUserImage(userDetails);
		
		return map;
	}
	
	@RequestMapping("/validEmail")
	public String validEmail(@RequestParam String user_id) {
		
		String msg;
		
		MimeMessage mmsg = sender.createMimeMessage();
		
		Users user = loginService.getUserInfo(user_id);
		
		String randomSixNum = randomSixNum();
		
		try {
			// 메일 제목
			mmsg.setSubject("한이삭 개발자 커뮤니티");
			
			// 메일 수신자
			mmsg.setRecipient(RecipientType.TO, new InternetAddress(user.getUser_email()));
			
			// 메일 내용
			mmsg.setText("이메일 인증번호는 "+ randomSixNum +"입니다.");
			
			// 발송 처리
			sender.send(mmsg);
			
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("메일 발송 에러: " + e);
		} catch (Exception e) {
			// TODO: handle exception
			System.out.println("메일 발송 에러: " + e);
		}
		
		return randomSixNum;
		
	}
	
	@RequestMapping("/updateUserVaildation")
	public String updateUserVaildation(Users user, @RequestParam String code) {
		String msg = "오류";
		
		if(code != null) {
			user.setUser_validation(true);
			service.updateUserValidation(user);
			msg = "이메일 인증에 성공하셨습니다.";
		}
		
		return msg;
	}
	
	private String randomSixNum() {
		
	  	Random random = new Random();	//랜덤 함수 선언
		int createNum = 0;  			//1자리 난수
		String ranNum = ""; 			//1자리 난수 형변환 변수
    	int letter = 6;					//난수 자릿수:6
		String resultNum = "";  		//결과 난수
		
		for (int i=0; i<letter; i++) { 
			createNum = random.nextInt(9);		//0부터 9까지 올 수 있는 1자리 난수 생성
			ranNum =  Integer.toString(createNum);  //1자리 난수를 String으로 형변환
			resultNum += ranNum;			//생성된 난수(문자열)을 원하는 수(letter)만큼 더하며 나열
		}	
	        	
    	System.out.println(resultNum);
    	
    	return resultNum;
	}
	
	
	
}
