package com.eansoft.mall.member.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.eansoft.mall.member.service.MemberService;
import com.eansoft.mall.member.vo.MemberVo;


@RestController
//@Controller
//@ResponseBody
@RequestMapping("/auth")
public class LoginController {
	
	@Autowired
	MemberService memberService;

	@PostMapping(value = "/login")
	public Map<String, Object> login (MemberVo memverVo, HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		
		HttpSession session = request.getSession();
		
		MemberVo memberInfo = memberService.login(memverVo);
		if(memberInfo == null) {
			map.put("result", "FAIL");
			map.put("message", "아이디 혹은 비밀번호가 잘못 되었습니다.");
		} else {
			map.put("result", "SUCCESS");
			session.setAttribute("memberInfo", memberInfo);
		}
		
		return map;
	}
	
	@PostMapping(value = "/logout")
	public Map<String, Object> logout(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		
	    HttpSession session = request.getSession();
	    session.invalidate();
	    map.put("message", "로그아웃 되었습니다.");
	    map.put("result", "SUCCESS");

	    return map;
	}
	

	
	
	
}
