package com.eansoft.mall.main.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

@Mapper
@Repository
public interface MainDao {

	List<Map<String, Object>> searchEvent(String keyword);
	
	List<Map<String, Object>> searchGoods(String keyword);
	
	List<Map<String, Object>> searchCode(String dId);
}
