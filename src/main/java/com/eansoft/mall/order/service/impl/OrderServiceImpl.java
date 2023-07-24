package com.eansoft.mall.order.service.impl;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.eansoft.mall.goods.dao.GoodsDao;
import com.eansoft.mall.order.dao.OrderDao;
import com.eansoft.mall.order.service.OrderService;

@Service
public class OrderServiceImpl implements OrderService {
	@Autowired
	OrderDao orderDao;
	
	@Autowired
	GoodsDao goodsDao;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	@Transactional
	public void getOrderAction(Map<String, Object> map) {
		String oQtyStr = (String) map.get("oQty"); // 주문 수량 (문자열로 받음)
		int oQty = Integer.parseInt(oQtyStr);
		logger.info("oQty : " + oQty);
		int stock = goodsDao.checkQty(map); // 재고 확인
		logger.info("stock : " + stock);
			if(oQty>stock) {
				throw new RuntimeException("재고 부족으로 실패");
			} else {
			        int insertResult = orderDao.orderAdd(map); // 주문 추가
			        if (insertResult == 0) {
			            throw new RuntimeException("주문 추가 실패");
			        }
			        int updateResult = orderDao.orderAfterUpdateQty(map); // 재고 업데이트
			        if (updateResult == 0) {
			            throw new RuntimeException("재고 업데이트 실패");
			        }
			        orderDao.orderAfterDeleteBasket(map); // 장바구니 삭제
			    
			}	
	
	}

	
	
}
