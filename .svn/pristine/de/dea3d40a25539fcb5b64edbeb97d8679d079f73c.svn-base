package com.eansoft.mall.main.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.eansoft.mall.main.dao.MainDao;
import com.eansoft.mall.main.service.MainService;

@Service
public class MainServiceImpl implements MainService {

	@Autowired
	MainDao mainDao;
	
	@Override
	public List<Map<String, Object>> searchEvent(String keyword) {
		return mainDao.searchEvent(keyword);
	}
	
	@Override
	public List<Map<String, Object>> searchGoods(String keyword) {
		return mainDao.searchGoods(keyword);
	}
	
	@Override
	public List<Map<String, Object>> searchCode(String dId) {
		return mainDao.searchCode(dId);
	}
}
