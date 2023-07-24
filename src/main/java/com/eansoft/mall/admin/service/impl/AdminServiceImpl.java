package com.eansoft.mall.admin.service.impl;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.eansoft.mall.admin.dao.AdminDao;
import com.eansoft.mall.admin.service.AdminService;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDao adminDao;	
	
	private final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	//회원관리
	@Override
	public Map<String, Object> getMemberList(Map<String, Object> memberMap) {
		List<Map<String, Object>> dataList = adminDao.getMemberList(memberMap);
		logger.debug("서비스임플: {}", dataList);
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		resultMap.put("dataList", dataList);	
		logger.debug("서비스임플 resultMap: {}", resultMap.get("dataList"));
		logger.debug("서비스임플 name: {}, mobile: {}, type: {}", memberMap.get("searchName"), memberMap.get("searchMobile"), memberMap.get("searchType"));
		return resultMap;
	}
	
	//회원가입 건수
	@Override
	public Map<String, Object> getMemberCnt() {
	    List<Map<String, Object>> list = adminDao.getMemberCnt();
	    
	    Map<String, Object> result = new HashMap<String, Object>();                
	    
	    if (list != null) {
	        Date today = new Date();
	        SimpleDateFormat smdf = new SimpleDateFormat("yyyyMMdd");
	        String formattedToday = smdf.format(today);
	        
	        int day = 0;
	        
	        for (Map<String, Object> map : list) {
	        	String regDateStr = (String) map.get("REG_DT");	            
	            if (regDateStr != null && regDateStr.equals(formattedToday)) {
	            	day++;
//	            	try {
//	            		Date regDate = smdf.parse(regDateStr);
//	            		logger.debug("regDateStr: {}, regDate: {}", regDateStr, regDate);
//	            		
//	            		if(isSameDay(regDate, today)) {
//	            			day++;
//	            		}
//					} catch (ParseException e) {
//						logger.error("날짜 파싱 에러: {}", regDateStr, e);
//					}        	
	            }
	        }	        
	        result.put("day", day);
	        result.put("mon", list.size());
	    }
	    
	    return result;
	}
	
	//총 주문 건수
	@Override
	public Map<String, Object> getOrderCnt() {
		List<Map<String, Object>> list = adminDao.getOrderCnt();
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if (list != null) {
			Date today = new Date();
			SimpleDateFormat smdf = new SimpleDateFormat("yyyyMMdd");
			String formattedToday = smdf.format(today);
			
			int day = 0;
			
			for(Map<String, Object> map : list) {
				String orderDateStr = (String) map.get("O_DT");
				
				if (orderDateStr != null && orderDateStr.equals(formattedToday)) {
					day++;
				}
			}
			result.put("day", day);
			result.put("mon", list.size());
		}
		return result;		
	}
	
	//이벤트 등록 건수
	@Override
	public Map<String, Object> getEventCnt() {
		List<Map<String, Object>> list = adminDao.getEventCnt();
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		if (list != null) {
			Date today = new Date();
			SimpleDateFormat smdf = new SimpleDateFormat("yyyyMMdd");
			String formattedToday = smdf.format(today);
			
			int day = 0;
			
			for(Map<String, Object> map : list) {
				String eventDateStr = (String) map.get("E_REG_DT");
				
				if (eventDateStr != null && eventDateStr.equals(formattedToday)) {
					day++;
				}
			}
			result.put("day", day);
			result.put("mon", list.size());
		}
		return result;
	}
	
	//상품리스트 - tr
	@Override
	public Map<String, Object> getSearchGoodsList(Map<String, Object> map) {		
		//리스트
		List<Map<String, Object>> goodsSearchList = adminDao.GoodsSearchList(map);
		Map<String, Object> result = new HashMap<>();			
		result.put("dataList", goodsSearchList);	
		//System.out.println("서비스임플에 결과값" + result);
		return result;
	}

	// 주문관리
	@Override
	public Map<String, Object> getOrderList(Map<String, Object> map) {			
		//리스트
		logger.debug("서비스임플 map : " + map);
		List<Map<String, Object>> dataList = adminDao.orderList(map);
		Map<String, Object> result = new HashMap<>();			
			result.put("dataList", dataList);		
			logger.debug("주문관리 서비스임플: {}", dataList);

		
		return result;
	}

	//이벤트 리스트
	@Override
	public Map<String, Object> getEventList(Map<String, Object> eventMap) {
		List<Map<String, Object>> eventList = adminDao.eventList(eventMap);
		logger.debug("서비스임플에 결과값", eventList);
		
		Map<String, Object> result = new HashMap<>();
		result.put("dataList", eventList);
		return result;
	}
	
	//이벤트상품목록
	@Override
	public Map<String, Object> eventGoodsList(Map<String, Object> eventGoodsMap) {
		List<Map<String, Object>> eventGoodsList = adminDao.eventGoodsList(eventGoodsMap);
		logger.debug("서비스임플에 결과값", eventGoodsList);
		
		Map<String, Object> result = new HashMap<>();
		result.put("dataList", eventGoodsList);
		return result;
	}
	
	//이벤트등록처리
	@Override
	public void insertEvent(Map<String, Object> map, MultipartFile eventImg) throws IllegalStateException, IOException {
		logger.debug("insertEvent서비스임플: {}", map);
		String eImgName = eventImg.getOriginalFilename();
		
		//파일 저장 경로
		String savePath = "src/main/resources/static/img/";
		
		//프로젝트 경로
		String projectDir = System.getProperty("user.dir");
		String targetPath = projectDir + "/" + savePath;
		
		File directory = new File(targetPath);
		directory.mkdirs();
		
		File target = new File(directory, eImgName);
		eventImg.transferTo(target);
		
		map.put("eventImg", "/img/" + eImgName);
		
		adminDao.insertEvent(map);
		logger.debug("insertEvent서비스임플 완료: {}", map);
		
		String E_ID = adminDao.getEventId(map);
		
		String jsonData = "{\"data\":" + map.get("gridData").toString() + "}";
		List<Map<String, Object>> gridData =  transJson(jsonData);
		
//		if (map.containsKey("gridData")) {
//		    List<Map<String, Object>> gridData = (List<Map<String, Object>>) map.get("gridData");
		    logger.debug("gridData: {}", gridData);
		    logger.debug("gridData type: {}", gridData != null ? gridData.getClass().getName() : "null");
		    for (Map<String, Object> data : gridData) {
		    	data.put("eventId", E_ID);
		    	adminDao.insertEventGoods(data);
		    }

	}
	
	//JSON -> Map 파싱
	private List<Map<String, Object>> transJson(String data) {
		
		List<Map<String, Object>> mapList = new ArrayList<Map<String, Object>>();
		
		JSONParser jsonParser = new JSONParser();
		JSONObject jsonObject = new JSONObject();	
		JSONArray jsonArray = null;
		
		
		try {
			jsonObject = (JSONObject) jsonParser.parse(data);
			jsonArray = (JSONArray) jsonObject.get("data");
		} catch (org.json.simple.parser.ParseException e) {
			e.printStackTrace();
		}				
		
		for (int i = 0; i < jsonArray.size(); i++) {
			Map<String, Object> mapData = new HashMap<String, Object>();
			
			@SuppressWarnings("unchecked")
			Iterator<String> iterator = ((JSONObject) jsonArray.get(i)).keySet().iterator();
			JSONObject object = (JSONObject) jsonArray.get(i);
			while(iterator.hasNext()) {
				String key = (String)iterator.next();
				mapData.put(key, object.get(key));
			}

			mapList.add(mapData);
		}
		
		return mapList;
	}
	

	//상품리스트에 필요한 goods카테고리 -tr
	@Override
	public List<Map<String, Object>> getGoodsCate() {				
		return adminDao.getGoodsCate();
	}

	// 주문단계 업데이트
//	@Override
//	public int getUpdate(String oStep, String oId) {
//		int result = adminDao.updateOstep(oStep, oId);
//		logger.debug("서비스임플 result: {}", result);
//		return result;
//	}
	
	@Override
	public int getUpdate(List<Map<String, Object>> modDataList) {
		logger.debug(" 서비스 임플에서 받은 modDataList : " + modDataList);
	    int result = 0;
	    for(Map<String, Object> params : modDataList) {
	    	result += adminDao.updateOstep(params);
	    	logger.debug("주문단계 수정 결과 : " + result);
	    }
        return result;
	}
	


	//상품관리 일괄노출 업데이트
	@Override
	public boolean updateAllViewY(int gId) {		
		int result = adminDao.doAllViewY(gId);		
		return result > 0;
	}

	@Override
	public boolean updateAllViewN(int gId) {
		int result = adminDao.doAllViewN(gId);	
		return result > 0;
	}

	@Override
	public boolean updateAllDelY(int gId) {
		int result = adminDao.doAllDelY(gId);
		return result > 0;
	}

	@Override
	public void insertGoods(Map<String, Object> map, MultipartFile gImg, MultipartFile gImgDtl) throws IllegalStateException, IOException {
		//상품등록
		String gImgName = gImg.getOriginalFilename();
		String gImgDtlName = gImgDtl.getOriginalFilename();
		
		// 파일 저장 경로 설정
		String targetDirectory = "src/main/resources/static/img/";

		// 프로젝트 경로 가져오기
		String projectDirectory = System.getProperty("user.dir");
		String targetPath = projectDirectory + "/" + targetDirectory;			
		//System.out.println("타켓 디렉토리 주소= "+ targetPath);
		
		File directory = new File(targetPath);
		directory.mkdirs();
		
		File target1 = new File(directory, gImgName);  //File(File parent, String child)	파일 객체 parent의 child 파일에 대한 객체를 생성한다.
		File target2 = new File(directory, gImgDtlName);
		gImg.transferTo(target1);
		gImgDtl.transferTo(target2);		
				
		//map 세팅		
		map.put("gImg", "/img/" + gImgName);
		map.put("gImgDtl", "/img/" + gImgDtlName);
		
		//db insert
		adminDao.insertGoods(map);	
		
		
	}


	// 공통코드관리-그룹
	@Override
	public Map<String, Object> getCodeGroup(Map<String, Object> map) {
		List<Map<String, Object>> codeList = adminDao.getCodeGroup(map);
		Map<String, Object> result = new HashMap<>();
			result.put("codeList", codeList);			
			logger.debug("서비스임플: {}", codeList);

			return result;
	}
	
	// 공통코드관리-상세
	@Override
	public Map<String, Object> getCodeDetail(Map<String, Object> map) {
		List<Map<String, Object>> codeDeList = adminDao.getCodeDetail(map);
		Map<String, Object> result = new HashMap<>();
			result.put("codeDeList", codeDeList);			
			logger.debug("서비스임플-코드상세: {}", codeDeList);

			return result;
	}

	//상품관리 상품수정 
	@Override
	public boolean updateGoods(Map<String, Object> map, MultipartFile gImg, MultipartFile gImgDtl) throws IllegalStateException, IOException {
		//상품등록
		String gImgName = gImg.getOriginalFilename();
		String gImgDtlName = gImgDtl.getOriginalFilename();
		
		// 파일 저장 경로 설정
		String targetDirectory = "src/main/resources/static/img/";

		// 프로젝트 경로 가져오기
		String projectDirectory = System.getProperty("user.dir");
		String targetPath = projectDirectory + "/" + targetDirectory;			
		//System.out.println("타켓 디렉토리 주소= "+ targetPath);
		
		File directory = new File(targetPath);
		directory.mkdirs();
		
		// 파일이 넘어왔을 경우에만 새로운 파일 저장
	    if (!gImg.isEmpty()) {
	        File target1 = new File(directory, gImgName);
	        gImg.transferTo(target1);
	        map.put("gImg", "/img/" + gImgName);
	    }

	    if (!gImgDtl.isEmpty()) {
	        File target2 = new File(directory, gImgDtlName);
	        gImgDtl.transferTo(target2);
	        map.put("gImgDtl", "/img/" + gImgDtlName);
	    }
	    
	    //map에 gID 추가
		map.put("gId", map.get("gId")); // gId 추가		
		
		//update sql
		int result = adminDao.updateGoods(map);
		
		return result > 0;
	}
	// 코드저장
	@Override
	public int CodeSave(Map<String, Object> gridRow) {
		int result = adminDao.CodeSave(gridRow);
		logger.debug("코드저장 서비스 임플 : " + result);
		return result;
	}
	// 코드삭제
//	@Override
//	public int codeDel(Map<String, Object> map) {
//		int result = adminDao.codeDel(map);
//		logger.debug("코드삭제 서비스 임플 : " + result);
//		return result;
//	}
	@Override
	public int codeDel(String cId) {
		int result = adminDao.codeDel(cId);
		logger.debug("코드삭제 서비스 임플 : " + result);
		return result;
	}

	@Override
	public boolean deltGoods(String gId) {
		int result = adminDao.deltGoods(gId);
		return result > 0;
	}







	


}


