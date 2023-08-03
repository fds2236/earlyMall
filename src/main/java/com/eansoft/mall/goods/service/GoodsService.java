package com.eansoft.mall.goods.service;

import java.util.List;
import java.util.Map;

public interface  GoodsService {
	Map<String, Object> getBasketList(Map<String, Object> map);
	boolean getBasketCheck(String mId, String gId);
	int getBasketAdd(Map<String, Object> map);
	int getBasketQtyUpdate(List<Map<String, Object>> saveList);
	int getBasketDel(String mId, String gId); // 장바구니 삭제
	List<Map<String, Object>> getEventList();
	List<Map<String, Object>> getEventItemList(String eId);
	List<Map<String, Object>> getItemList(String sortType); // 아이템 리스트
	
	Map<String, Object> getCateGoodsList(Map<String, Object> map); //카테고리별 굿즈 리스트 - tr
	Map<String, Object> getGoodsDetail(String gId); //상품 상세 - tr
	

}
