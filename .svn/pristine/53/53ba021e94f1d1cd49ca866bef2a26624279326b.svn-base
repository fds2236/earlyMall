package com.eansoft.mall.goods.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eansoft.mall.goods.dao.GoodsDao;
import com.eansoft.mall.goods.service.GoodsService;
import com.eansoft.mall.main.service.MainService;


@Service
public class GoodsServiceImpl implements GoodsService {
	
	@Autowired
	private GoodsDao goodsDao;
	
	@Autowired
	private MainService mainService;
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public Map<String, Object> getBasketList(Map<String, Object> map) {
		// 데이터 개수 구하기
		String mId = (String) map.get("mId");
		int countBasket = goodsDao.countBasket(mId);
		logger.info("총 데이터 개수 : " + countBasket);
		
		// 데이터 조회하기
		int amount = 5; // 데이터 5개씩 출력
		int totalPages = (int) Math.ceil((double) countBasket / amount);
		map.put("amount", amount);
		logger.info("조회 쿼리로 보낼 값들 : " + map);
		List<Map<String, Object>> dataList = goodsDao.basketList(map);
	    Map<String, Object> resultMap = new HashMap<>();
	    resultMap.put("dataList", dataList); 
	    resultMap.put("totalPages", totalPages);
		return resultMap;
	}

	@Override
	public boolean getBasketCheck(String mId, String gId) {
		String basketCheck = goodsDao.basketCheck(mId, gId);
		if(basketCheck != null) {
			return true;
		} else return false;
	}

	@Override
	public int getBasketAdd(Map<String, Object> map) {
		
		// map에서 꺼낸 값
	    String gId = (String) map.get("gId");
	    String mId = (String) map.get("mId");
	    //int bQty = (Integer)map.get("bQty");
	   		
	    //장바구니 체크
	    String basketCheck = goodsDao.basketCheck(mId, gId);
	   	    
	    if(basketCheck != null) { //기존에 같은 상품이 있다면
	    	//수량만 update
	    	int result = goodsDao.basketQtyPlus(map);	    	
	    	return result ; 
	    }
	    else { // 같은 상품이 없다면
	    	int result = goodsDao.basketAdd(map);	    	
	    	return result;
	    }		
	}

	 @Override
	 public int getBasketQtyUpdate(List<Map<String, Object>> saveList) {
	     int result = 0;
	     for (Map<String, Object> params : saveList) {
	         result += goodsDao.basketQtyUpdate(params);
	         logger.info("basketQtyUpdate 결과: " + result);
	     }
	     return result;
	  }

	@Override
	public int getBasketDel(String mId, String gId) {
		int result = goodsDao.basketDel(mId, gId);
		return result;
	}

	@Override
	public List<Map<String, Object>> getEventList() {
		List<Map<String, Object>> eventList = goodsDao.eventList();
		logger.info("eventList : " + eventList);
		return eventList;
	}

	@Override
	public List<Map<String, Object>> getEventItemList(String eId) {
		List<Map<String, Object>> eventItemList = goodsDao.eventItemList(eId);
		return eventItemList;
	}

	@Override
	public Map<String, Object> getCateGoodsList(Map<String, Object> map) {
		//리스트 개수 구하기 
		String gCateCd = (String) map.get("gCateCd"); //G_CATE_CD
		int CountCateGoods = goodsDao.countCateGoods(gCateCd);
		
		// 데이터 조회하기
		int amount = 20; // 데이터 20개씩 출력
		int totalPages = (int) Math.ceil((double) CountCateGoods / amount);
		map.put("amount", amount);
		
		
		List<Map<String, Object>> cateGoodsList = goodsDao.cateGoodsList(map);
		Map<String, Object> result = new HashMap<>();	
		
		//System.out.println("cate굿즈리스트" + cateGoodsList);
		result.put("cateGoodsList", cateGoodsList);	
		result.put("totalPage", totalPages);
		return result;
	}

	@Override
	public Map<String, Object> getGoodsDetail(String gId) {
		Map<String, Object> result = new HashMap<>();
		result = goodsDao.goodsDetail(gId);
		return result;
	}
	
	@Override
	public List<Map<String, Object>> getItemList(String sortType) {
		
		List<Map<String, Object>> cateList = mainService.searchCode("200");
		List<Map<String, Object>> itemList = new ArrayList<Map<String, Object>>();
		for(Map<String, Object> cate : cateList) {
			String cateId = cate.get("DID").toString();
			List<Map<String, Object>> cateitemList = goodsDao.itemList(sortType, cateId);
			itemList.addAll(cateitemList);
		}
		return itemList;
	}
	

}
