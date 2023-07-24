package com.eansoft.mall.member.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eansoft.mall.member.service.MemberService;
import com.eansoft.mall.member.vo.MemberVo;

@Controller
@RequestMapping("/member")

public class MemberController {
	@Autowired
	private MemberService memberService;
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@GetMapping("/myPage")
	public String myPage(String mId, HttpServletRequest request) {
		
		// 내정보 조회 - 기본은 세션에 있음
		logger.info("mid data = {}",mId);
		HttpSession session = request.getSession();
		MemberVo memberInfo = (MemberVo) session.getAttribute("memberInfo");
		
		logger.info("memberInfo data = {}",memberInfo);
		
		return "member/myPage";
	}

	// 아이디 중복체크
	@PostMapping("/idCheck")
	@ResponseBody
	public String idCheck(MemberVo memberVo) {
		String returnStr = "";
		
		int idCnt = memberService.idCheck(memberVo.getmId());
		
		if(idCnt > 0) {
			returnStr = "duplicatedId";
		} else {
			returnStr = "availableId";
		}
		
		return returnStr;
		
	}
	
	// 관리자페이지에서 회원등록
	@PostMapping("/joinFromAdmin")
	@ResponseBody
	public void joinFromAdmin(MemberVo memberVo) {
		logger.info("회원등록 컨트롤러---------");
		memberService.joinFromAdmin(memberVo);
	}
	
	// 회원가입화면 접속
	@GetMapping("/joinMember")
	public String joinMemberView() {
		return "/member/joinMember";
	}
	
	// 일반회원 회원가입
	@PostMapping("/joinMember")
	public String joinMember(MemberVo memberVo, Model model) {
		int joinResult = memberService.joinFromAdmin(memberVo);
		logger.info("회원가입 컨트롤러---------");
		
		if(joinResult == 0) {
			model.addAttribute("joinMsg", "joinFail");
			return "/member/joinMember";
		}
		
		model.addAttribute("joinMsg", "joinSuccess");
		return "/login";
	}
	
	// 관리자페이지에서 회원수정 팝업
	@PostMapping("/updateMember")
	@ResponseBody
	public  void updateMember(MemberVo memberVo) {
		logger.info("회원수정 컨트롤러------------");
		logger.info("컨트롤러 mId: {}", memberVo.getmId());
		memberService.updateMember(memberVo);
	}
	
	// 회원삭제
	@PostMapping("/deleteMember")
	@ResponseBody
	public void deleteMember(@RequestParam("mId") String mId) {
		logger.info("회원삭제 컨틀로러--------------");
		logger.info("삭제 컨르롤러 mId: {}", mId);
		
		memberService.deleteMember(mId);
	}
	
	// 회원 정보 수정 접속
	@GetMapping("/updateMember")
	public String updateMemberView(String mId, HttpServletRequest request) {
		// 내정보 조회 - 기본은 세션에 있음
		logger.info("mid data = {}",mId);
		HttpSession session = request.getSession();
		MemberVo memberInfo = (MemberVo) session.getAttribute("memberInfo");
		
		logger.info("memberInfo data = {}",memberInfo);
		
		return "/member/updateMember";
	}
	
	// 일반회원 회원 정보 수정
	@PostMapping("/updateMemberInfo")
	public String updateMemberInfo(MemberVo memberVo, Model model) {
		logger.info("회원정보수정 컨트롤러------------");
		logger.info("컨트롤러 mId: {}", memberVo.getmId());
		int updateResult = memberService.updateMember(memberVo);
		
		if(updateResult == 0) {
			model.addAttribute("updateMsg", "updateFail");
			return "/member/updateMember";
		}
		
		model.addAttribute("updateMsg", "updateSuccess");
		return "/member/myPage";
	}
	
	// 마이페이지 주문리스트 조회
	@GetMapping("/getOrderList")
	@ResponseBody
	public Map<String, Object> getOrderList(@RequestParam Map<String, Object> orderMap) {
		logger.info("컨트롤러 orderMap: {}", orderMap);
		//logger.info("주문리스트 조회 mId: {}", orderMap.get(orderMap));
		//orderMap.put("mId", mId);		
		
		return memberService.getOrderList(orderMap);
	}
	
	// 마이페이지 장바구니리스트 조회
	@GetMapping("/getBasketList")
	@ResponseBody
	public Map<String, Object> getBasketList(@RequestParam Map<String, Object> basketMap) {
		logger.info("컨트롤러 basketMap: {}", basketMap);
		
		return memberService.getBasketList(basketMap);
	}
}
