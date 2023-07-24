package com.eansoft.mall.member.service;

import java.util.Map;

import com.eansoft.mall.member.vo.MemberVo;

public interface  MemberService {

	/**
	 * 로그인
	 * @param memberVo
	 * @return
	 */
	MemberVo login(MemberVo memberVo);
	
	int idCheck(String mId);
	
	int joinFromAdmin(MemberVo memberVo);
	
	int updateMember(MemberVo memberVo);
	
	void deleteMember(String mId);
	
	Map<String, Object> getOrderList(Map<String, Object> orderMap);
	
	Map<String, Object> getBasketList(Map<String, Object> basketMap);
}
