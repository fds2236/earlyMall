package com.eansoft.mall.order.dao;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface OrderDao {
	int orderAdd(Map<String, Object> map);
	int orderAfterUpdateQty(Map<String, Object> map);
	int orderAfterDeleteBasket(Map<String, Object> map);

}
