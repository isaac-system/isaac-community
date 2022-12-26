package com.example.web.comm.service;

import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.example.web.comm.dto.Users;
import com.example.web.sign.mapper.SignUpMapper;


@Service
public class MailSenderService {
	
	@Autowired(required = false)
	private JavaMailSender sender;
	
	@Autowired(required = false)
	private SignUpMapper userMapper;
	
	public String sendMail(String user_email) {
		
		String msg = "메일 발송 성공";
		
		MimeMessage mmsg = sender.createMimeMessage();
		
		try {
			// 메일 제목
			mmsg.setSubject("유엔아이 개발자 커뮤니티");
			
			// 메일 수신자
			mmsg.setRecipient(RecipientType.TO, new InternetAddress(user_email));
			
			// 메일 내용
			mmsg.setText("안녕하세요 유엔아이 개발자 커뮤니티에 가입하신 것을 축하 드립니다. ^^");
			
			// 발송 처리
			sender.send(mmsg);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			msg = "메일 발송 에러" + e.getMessage();
		} catch (Exception e) {
			// TODO: handle exception
			msg = "메일 발송 에러" + e.getMessage();
		}
		
		return msg;
		
	}
	
	public String sendEmailAccount(Users user) {
		
		String msg = "메일 발송 성공";
		
		MimeMessage mmsg = sender.createMimeMessage();
		
		String TempPassword = getTempPassword();
		
		try {
			// 메일 제목
			mmsg.setSubject("유엔아이 개발자 커뮤니티");
			
			// 메일 수신자
			mmsg.setRecipient(RecipientType.TO, new InternetAddress(user.getUser_email()));
			
			// 메일 내용
			mmsg.setText("임시 비밀번호는" + TempPassword + "입니다.\n" + "로그인후 비밀번호를 변경해주세요." );
			
			//비밀번호 변경
			changeUserPassword(new Users(user.getUser_email(), TempPassword));
			
			// 발송 처리
			sender.send(mmsg);
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			msg = "메일 발송 에러" + e.getMessage();
		} catch (Exception e) {
			// TODO: handle exception
			msg = "메일 발송 에러" + e.getMessage();
		}
		
		return msg;
		
	}
	// 유저 패스워드를 변경하는 부분
	public void changeUserPassword(Users user) {
		userMapper.updateUserPassword(user);
	}
	
	public String getTempPassword(){
        char[] charSet = new char[] { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F',
                'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z' };

        String str = "";

        // 문자 배열 길이의 값을 랜덤으로 8개를 뽑아 구문을 작성함
        int idx = 0;
        for (int i = 0; i < 8; i++) {
            idx = (int) (charSet.length * Math.random());
            str += charSet[idx];
        }
        return str;
    }
	
	
}
