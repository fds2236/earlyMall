package com.eansoft.mall.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import com.eansoft.mall.member.vo.MemberVo;

@Mapper
@Repository
public interface MemberDao {
	
	MemberVo login(MemberVo memberVo);

	int idCheck(String mId);
	
	int joinFromAdmin(MemberVo memberVo);
	
	int updateMember(MemberVo memberVo);
	
	void deleteMember(String mId);
	
	List<Map<String, Object>> getOrderList(Map<String, Object> orderMap);
	
	List<Map<String, Object>> getBasketList(Map<String, Object> basketMap);
}
