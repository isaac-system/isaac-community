package com.example.web.config;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.CredentialsExpiredException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class LoginFailureHandler implements AuthenticationFailureHandler{
	private final String DEFULAT_FAILURE_URL = "/login?error=true";
    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception)
        throws IOException, ServletException {
    	
        String errormsg = null;
        
        if(exception instanceof BadCredentialsException) {
            errormsg = "아이디나 비밀번호가 맞지 않습니다. 다시 확인해주세요.";
        } else if(exception instanceof InternalAuthenticationServiceException) {
            errormsg = "내부 시스템 문제로 로그인 요청을 처리할 수 없습니다. 관리자에게 문의하세요. " ;
        } else if(exception instanceof UsernameNotFoundException) {
        	errormsg = "존재하지 않는 계정입니다. 회원가입 후 로그인해주세요.";
		} else if(exception instanceof DisabledException) {
            errormsg = "계정이 비활성화되었습니다. 관리자에게 문의하세요.";
        } else if(exception instanceof CredentialsExpiredException) {
            errormsg = "비밀번호 유효기간이 만료 되었습니다. 관리자에게 문의하세요.";
        }
        
        errormsg = new String(errormsg.getBytes("UTF-8")); // 한글 깨짐 방지
        request.setAttribute("errormsg", errormsg);
        request.getRequestDispatcher(DEFULAT_FAILURE_URL).forward(request, response);
    }
 

}
