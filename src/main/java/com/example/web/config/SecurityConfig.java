package com.example.web.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.example.web.login.service.LoginService;

@Configuration
@EnableWebSecurity
public class SecurityConfig extends WebSecurityConfigurerAdapter{
	
	@Autowired
	private LoginService userService;
	
	@Override
    protected void configure(HttpSecurity http) throws Exception{
		http
        .authorizeRequests(request->{
            request
                    .antMatchers("/**").permitAll()		
                    .anyRequest().authenticated()
                    ;
        })
        .formLogin(
                login -> login.loginPage("/login").permitAll()
                        .defaultSuccessUrl("/", false)
                        .usernameParameter("user_id")
                        .passwordParameter("user_password")
                        .failureForwardUrl("/login?error=true")
                        .failureHandler(loginFailHandler())//로그인 실패 시 처리하는 핸들러 등록.
        )
        .logout(logout -> logout.logoutSuccessUrl("/"))
        .csrf().disable()
        ;
    }
	
	@Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers("/a00_com/**", "/a01_comlib/**", "/a01_comfun/**");
        ;
    }
	
	@Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userService).passwordEncoder(new BCryptPasswordEncoder());
    }
	
	@Bean
    public LoginFailureHandler loginFailHandler(){
        return new LoginFailureHandler();
    }
	
	@Bean
	PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}
}
