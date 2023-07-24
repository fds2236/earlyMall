package com.eansoft.mall.order.controller;

import java.util.Map;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eansoft.mall.goods.service.GoodsService;
import com.eansoft.mall.order.service.OrderService;

@Controller
@RequestMapping("/order")
public class OrderController {
	@Autowired
	GoodsService goodsService;
	
	@Autowired
	OrderService orderService;
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@GetMapping("/mine")
	public String cateMain() {
		return "order/myOrder";
	}
//	
//	@GetMapping("/goOrderPage")
//	public String orderPage(
//			@RequestParam Map<String, Object> map, Model model) {
//	    logger.info("map : "+ map);
//		model.addAttribute("orderInfo", map);
//		logger.info("model : "+ model);
//		return "order/orderPage";
//	}
	
	@PostMapping("/goOrderPage")
	public String orderPagePost(
			@RequestParam Map<String, Object> map, Model model) {
	    logger.info("map : "+ map);
		model.addAttribute("orderInfo", map);
		logger.info("model : "+ model);
		return "order/orderPage";
	}
	
	@GetMapping("/orderGoods")
	@ResponseBody
	public Map<String, Object> orderGoods(
			@RequestParam String gId) {
		Map<String, Object> goodsDetail = goodsService.getGoodsDetail(gId);
		return goodsDetail;
	}
	
	@GetMapping("/orderAction")
	@ResponseBody
	public boolean orderAdd(
			@RequestParam Map<String, Object> map) {
		logger.info("map : "+ map);
		orderService.getOrderAction(map); // 으음 근데 실패하면 실패했다고 알려줘야 화면에 alert창 띄우지 않을까?
		return true;
	}
	
	
	
	
}
