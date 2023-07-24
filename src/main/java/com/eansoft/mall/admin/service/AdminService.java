package com.eansoft.mall.admin.service;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

public interface  AdminService {
	//회원관리
	Map<String, Object> getMemberList(Map<String, Object> memberMap);
	
	//회원가입 건수
	Map<String, Object> getMemberCnt();
//	public int getMonthMember();
	//총 주문 건수
	Map<String, Object> getOrderCnt();
	//이벤트 등록 건수
	Map<String, Object> getEventCnt();
	

	//상품리스트 - tr
	Map<String, Object> getSearchGoodsList(Map<String, Object> map);
	
	//상품리스트에 필요한 goods카테고리 -tr
	List<Map<String, Object>> getGoodsCate();

	
	//주문관리
	Map<String, Object> getOrderList(Map<String, Object> map);
	
	// 주문단계 업데이트
	int getUpdate(List<Map<String, Object>> modDataList);
	
	
	//이벤트 리스트
	Map<String, Object> getEventList(Map<String, Object> eventMap);
	
	//이벤트상품목록
	Map<String, Object> eventGoodsList(Map<String, Object> eventGoodsMap);
	
	//이벤트등록처리
	void insertEvent(Map<String, Object> map, MultipartFile eventImg) throws IllegalStateException, IOException;
	
	
	//상품관리 일괄노출 -tr
	boolean updateAllViewY(int gId);
	
	//상품관리 일괄비노출 -tr
	boolean updateAllViewN(int gId);
	
	//상품관리 일괄삭제 -tr
	boolean updateAllDelY(int gId);
	
	//상품관리 상품등록 -tr
	void insertGoods(Map<String, Object> map, MultipartFile gImg, MultipartFile gImgDtl) 
			throws IllegalStateException, IOException;


	// 공통코드관리-그룹
	Map<String, Object> getCodeGroup(Map<String, Object> map);
	// 공통코드관리-상세
	Map<String, Object> getCodeDetail(Map<String, Object> map);
	// 코드저장
	int CodeSave(Map<String, Object> gridRow);
	// 코드삭제
	//int codeDel(Map<String, Object> map);
	int codeDel(String cId);
	
	//상품관리 상품수정 -tr
	boolean updateGoods(Map<String, Object> map, MultipartFile gImg, MultipartFile gImgDtl) 
			throws IllegalStateException, IOException;

	boolean deltGoods(String gId);
}