package com.eansoft.mall.goods.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.jasper.tagplugins.jstl.core.ForEach;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.eansoft.mall.goods.service.GoodsService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("/goods")
public class GoodsController {
	@Autowired
	GoodsService goodsService;

	private final Logger logger = LoggerFactory.getLogger(this.getClass());

	@GetMapping("/cate")
	// Model model은 단순히 뷰로 데이터를 전달하기 위해 사용되는 매개변수
	public String cateMain(@RequestParam String cateId, Model model) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("gCateCd", cateId);
		map.put("sortType", "newest");
		map.put("page", 1);
		map.put("amount", 20);

		Map<String, Object> cateGoodsList = goodsService.getCateGoodsList(map);

		ObjectMapper MAPPER = new ObjectMapper();
		String list = "";
		try {
			list = MAPPER.writeValueAsString(cateGoodsList);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}

		model.addAttribute("list", list);
		model.addAttribute("cateCd", cateId);

		return "goods/cateMain";
	}

	@GetMapping("/basket")
	public String basket() {
		return "goods/cart";
	}

//	@GetMapping("/basketList")
//	@ResponseBody
//	public Map<String, Object> basketList(
//			@RequestParam Map<String, Object> map){
//		logger.info("받은 parameters: " + map);
//		Map<String, Object> basketInfo = goodsService.getBasketList(map);
//		logger.info("받은 basketInfo: " + basketInfo);
//		return basketInfo;
//	}

	// restAPI로 변경
	@GetMapping("/basketList/{mId}/{sortType}/{page}")
	@ResponseBody
//	 단일 매개변수말고 객체도 받을 수 있나? 응 RequestParam처럼 map받는거 가능!
	public Map<String, Object> basketList(@PathVariable Map<String, Object> map) {
		logger.info("받은 parameters: " + map);
		Map<String, Object> basketInfo = goodsService.getBasketList(map);
		logger.info("받은 basketInfo: " + basketInfo);
		return basketInfo;
	}

	@GetMapping("/basketCheck")
	@ResponseBody
	public boolean basketCheck(@RequestParam(value = "mId") String mId, @RequestParam(value = "gId") String gId) {
		logger.info("mId : " + mId);
		logger.info("gId : " + gId);
		return goodsService.getBasketCheck(mId, gId);
	}

	@PostMapping("/basketAdd")
	@ResponseBody
	public int basketAdd(@RequestParam Map<String, Object> map) {
		logger.info("받은 parameters: " + map);
		return goodsService.getBasketAdd(map);
	}

	// restApi 방식
	@PostMapping("/basketListUpdate")
	@ResponseBody
	public int basketListUpdate(@RequestBody List<Map<String, Object>> saveList) {
		logger.info("Received saveList: " + saveList);
		int result = goodsService.getBasketQtyUpdate(saveList);
		return result;
	}

	@PostMapping("/basketDelete")
	@ResponseBody
	public int basketDelete(@RequestParam(value = "mId") String mId, @RequestParam(value = "gId") String gId) {
		return goodsService.getBasketDel(mId, gId);
	}

	@GetMapping("/eventList")
	@ResponseBody
	public List<Map<String, Object>> eventList() {
		return goodsService.getEventList();
	}

	@GetMapping("/eventItemList")
	public String eventItemList(@RequestParam(value = "eId") String eId, Model model) {
		List<Map<String, Object>> eventItemList = goodsService.getEventItemList(eId);
		model.addAttribute("eventItemList", eventItemList);
		return "goods/eventItemList";
	}

	// 이게 기존의 방식
//	@GetMapping("/itemList")
//	@ResponseBody
//	public List<Map<String, Object>> itemList(
//			@RequestParam(value="sortType")String sortType){
//		return goodsService.getItemList(sortType);
//	}

	// restApi의 방식
	@GetMapping("/itemList/{sortType}")
	@ResponseBody
	public List<Map<String, Object>> itemList(@PathVariable String sortType) {
		return goodsService.getItemList(sortType);
	}

	// 카테고리별 상품 목록 -tr
	@GetMapping("/CateGoodsList")
	@ResponseBody
	public Map<String, Object> cateGoods(@RequestParam Map<String, Object> map) {
		Map<String, Object> cateGoodsList = goodsService.getCateGoodsList(map);
		return cateGoodsList;
	}

	// 상품 상세 -tr
	@GetMapping("/detail")
	public String goodsDetail(@RequestParam String gId, Model model) {
		Map<String, Object> goodsDetail = goodsService.getGoodsDetail(gId);
		model.addAttribute("goodsDetail", goodsDetail);
		return "goods/detail";
	}

}
