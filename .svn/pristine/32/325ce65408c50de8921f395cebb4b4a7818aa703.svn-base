package com.eansoft.mall.member.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eansoft.mall.member.dao.MemberDao;
import com.eansoft.mall.member.service.MemberService;
import com.eansoft.mall.member.vo.MemberVo;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberDao memberDao;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@Override
	public MemberVo login(MemberVo memberVo) {
		return memberDao.login(memberVo);
	}
	
	@Override
	public int idCheck(String mId) {
		return memberDao.idCheck(mId);
	}
	
	@Override
	public int joinFromAdmin(MemberVo memberVo) {
		return memberDao.joinFromAdmin(memberVo);
	}
	
	@Override
	public int updateMember(MemberVo memberVo) {
		return memberDao.updateMember(memberVo);
	}
	
	@Override
	public void deleteMember(String mId) {
		memberDao.deleteMember(mId);
	}
	
	@Override
	public Map<String, Object> getOrderList(Map<String, Object> orderMap) {
		List<Map<String, Object>> dataList = memberDao.getOrderList(orderMap);
		logger.info("주문리스트 서비스임플: {}", dataList);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("dataList", dataList);
		logger.info("서비스임플 resultMap: {}", resultMap.get("dataList"));
		
		return resultMap;
	}
	
	@Override
	public Map<String, Object> getBasketList(Map<String, Object> basketMap) {
		List<Map<String, Object>> basketList = memberDao.getBasketList(basketMap);
		logger.info("장바구니리스트 서비스임플: {}", basketList);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("basketList", basketList);
		logger.info("장바구니리스트 resultMap: {}", resultMap.get("basketList"));
		
		return resultMap;
	}
}
