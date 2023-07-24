package com.eansoft.mall.goods.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface GoodsDao {
	int countBasket(String mId);
	List<Map<String, Object>> basketList(Map<String, Object> map);
	//List<Map<String, Object>> basketList(String mId, String sortType, int page, int amount);
	String basketCheck(String mId, String gId); // 장바구니 체크
	int basketAdd(Map<String, Object> map); // 장바구니 추가
	int basketQtyUpdate(Map<String, Object> map); // 장바구니 수량 업데이트
	int basketDel(String mId, String gId); // 장바구니 삭제 
	List<Map<String, Object>> eventList(); // 이벤트 목록
	List<Map<String, Object>> eventItemList(String eId);
	List<Map<String, Object>> itemList(String sortType, String cateId); // 아이템 목록
	
	int countCateGoods(String gCateCd); // 카테고리별 굿즈 개수
	List<Map<String, Object>> cateGoodsList(Map<String, Object> map); //카데고리별 굿즈 리스트 - tr
	Map<String, Object> goodsDetail(String gId); // 굿즈 상세 -tr
		int basketQtyPlus(Map<String, Object> map);// 장바구니에 기존 상품이 있을때 장바구니에 해당 상품 수량 +
	int checkQty(Map<String, Object> map); // 재고 확인
	
}
