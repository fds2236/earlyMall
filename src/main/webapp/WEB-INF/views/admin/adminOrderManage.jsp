<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문관리</title>
</head>

<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/redmond/jquery-ui.css" type="text/css" />
<!-- jqGrid CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/jqgrid/4.6.0/css/ui.jqgrid.css" type="text/css" />

<jsp:include page="../import/adminFrame.jsp"/>

<!-- The actual JQuery code -->
<script type="text/javascript" src="https://code.jquery.com/jquery-1.10.2.min.js" ></script>
<!-- The JQuery UI code -->
<script type="text/javascript" src="https://code.jquery.com/ui/1.10.3/jquery-ui.min.js" ></script>
<!-- The jqGrid language file code-->
<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/i18n/grid.locale-kr.js" ></script>
<!-- The atual jqGrid code -->
<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/jquery.jqGrid.src.js" ></script>

<!-- 달력사용을 위한 라이브러리 -->
<!-- <script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script> -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />

<body>
	<div style="float:left;margin:30px;">
		<div class="container">
			<form id="searchForm">     		  
				회원명 
				<input type="text" name="mName" id="mName">
				상품명 
				<input type="text" name="gName" id="gName">
				주문일자 
				<input name="oDt" id="oDt">             
				주문단계 
				<select class="select" id="oStep" name="oStep">
                     <option value="">전체</option>
				</select>&nbsp;
				<button  type="button" id="btn" onclick="search();">조회</button>                                                    
	         </form>
		</div>
		<br>     
		<table id="orderManage"></table>
		<div id="pager"></div>
		<br>
		<button type="button" id="saveButton">저장</button>
	</div>
</body>

<script type="text/javascript">   

var cateList = JSON.parse('${cateList}');
var modDataList = [];

$(document).ready(function() {

	setManageTitle("주문관리");
        	
	setOrderCate();
	
	setGrid();
	
	$("#saveButton").click(function() {
		if(modDataList.length > 0) {
			if(confirm("수정하시겠습니까?")) {
				saveChanges();
			}
		} else {
			alert("수정 사항이 없습니다");
		}
	});
	
});

function setOrderCate() {
	var html = "";
	$.each(cateList, function(i, v) {
		html += '<option value=\'' + cateList[i].DID  + '\'>' + cateList[i].DNAME + '</option>';
	});
	$("#oStep").append(html);
}

function setGrid() {
	var searchResultColNames = ['주문번호', '회원아이디','회원명', '상품명', '주문일자', '주문수량', '주문금액', '주문단계', '배송완료일자'];
    var searchResultColModel = [  
		{name: 'O_ID', index: 'O_ID', width: 100, align: 'center', hidden:true},
		{name: 'M_ID', index: 'M_ID', width: 100, align: 'left'},
		{name: 'M_NAME', index: 'M_NAME', width: 100, align: 'left'},
		{name: 'G_NAME', index: 'G_NAME', width: 100, align: 'left'},
		{name: 'O_DT', index: 'O_DT', width: 150, align: 'center', formatter: formatDate},
		{name: 'O_QTY', index: 'O_QTY', width: 20, align: 'right', formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
		{name: 'O_PRICE', index: 'O_PRICE', width: 80, align: 'right', sortable: true, sorttype: 'number',formatter:'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
		{name: 'O_STEP', index: 'O_STEP', width: 100, align: 'center', sortable: false, editable: false,
			formatter: function(cellValue, options, rowObject){
				var str = "";
				var rowId = options.rowId;
				var oId = rowObject.O_ID;
				
				str += '<select id="step_' + oId + '" onChange="setModData(\''+ oId +'\',\''+ cellValue +'\')">';
				$.each(cateList, function(i, v) {
					str += '<option value=\'' + cateList[i].DID  + '\''; if(cellValue == cateList[i].DID) { str += ' selected'; } str += '>' + cateList[i].DNAME + '</option>';
				});
				str += '</select>';
				
				return str;
			}
		},  
		{name: 'O_COMP', index: 'O_COMP', width: 150, align: 'center', 
			formatter: function(cellValue, options, rowObject) {
				if(cellValue) {
				 return formatDate(cellValue)
				}
				return ''; // 배송일자가 있을경우에만 변환하도록 옵션
			}
		}
	];
    
    $("#orderManage").jqGrid({
		url: "/admin/orderMg",
        datatype: "json",
        mtype: "GET", 
        height: 260,
        width: 1020,
        colNames: searchResultColNames,
        colModel: searchResultColModel,
        autowidth: true,
        rowNum : 10,
        rowList: [10,20,30],
        pager: "#pager",
		jsonReader: {
        	repeatitems: false,
        	root:"dataList",
        },
        loadonce: true,
        rownumbers: true,
        viewecords: true,
        caption:"주문관리",    
        cellEdit: true,
		onPaging: function(action) {
			
			console.log(modDataList);
			
        	if(modDataList.length > 0) {      
        		if(confirm("수정 사항을 저장 하시겠습니까?")) {           				
       				saveChanges();
       				search();
					return "stop";
        		} 	
        		modDataList = [];
        	}
        },        
        loadComplete: function(data) {        
        	var jsonData = JSON.stringify(data.dataList);
        	$(".ui-state-default.jqgrid-rownum").removeClass('ui-state-default jqgrid-rownum');
        	$("#orderManage_nodata").remove();
        	if(data && data.dataList && data.dataList.length === 0) {
        		$("#orderManage.ui-jqgrid-btable").after("<p id='orderManage_nodata' style='margin-top: 15px; text-align: center; font-weight:bold;'>검색된 자료가 없습니다</p>");
        	}              	
       	}   
   	});
}

// 날짜 변환
function formatDate(cellValue, options, rowObject) {
	var date = new Date(cellValue);
	var formattedDate = date.toLocaleString('ko-KR', { year: 'numeric', month:'2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit'});
	return formattedDate;
} 

function search() {
	var mName = $("#mName").val();        	  
	var gName = $("#gName").val();
	var oDt = $("#oDt").val();
	var oStep = $("#oStep").val();
		
	$("#orderManage").setGridParam({
		postData: {
			mName: mName,
	      	gName: gName,
	      	oDt: oDt,
	      	oStep: oStep
	  	},
	  	loadComplete:function(data) {
	   		// 찾는 데이터가 없을 경우
	   		$(".ui-state-default.jqgrid-rownum").removeClass('ui-state-default jqgrid-rownum');
	   		$("#orderManage_nodata").remove();
	   		if(data && data.dataList && data.dataList.length === 0) {
	   			$("#orderManage.ui-jqgrid-btable").after("<p id='orderManage_nodata' style='margin-top: 15px; text-align: center; font-weight:bold;'>검색된 자료가 없습니다</p>");
	   		}  
	  	},
	  	gridComplete: function() {
		  
	  	}
	}).trigger("reloadGrid");
		
	reloadGrid();
}

function reloadGrid() {
	$("#orderManage").jqGrid('setGridParam', {
	  	url: '/admin/orderMg',
	  	type: 'GET',
	  	datatype: 'json',
	}).trigger("reloadGrid");
}
	
// 셀렉트박스로 주문단계 수정
function saveChanges() {
 	$.ajax({
 		url: "/admin/updateOstep",
 		type: "POST",
 		data: JSON.stringify(modDataList),
 		contentType: "application/json",
 		success: function(response) {
 			modDataList = [];
 			alert("수정사항을 저장하였습니다.");
 			console.log(modDataList);
 			$("#orderManage").clearGridData();
 			reloadGrid();
 		},
 		error: function(error) {
 			console.log("수정사항 저장 중 오류 발생", error);
 		}
 		
 	});
} 

function setModData(oId, cellVal) {
    
	var changeVal = $("#step_" + oId).val();
    var data = {"oId":oId, "oStep":changeVal};
    
    $.each(modDataList, function(index, value) {
		if(value.oId == oId) {
			modDataList.splice(index,1);			
		}
	});
    
    if(cellVal != changeVal) {
    	modDataList.push(data);
    }
}

//오늘 날짜 가져오기
var today = new Date(); 
//오늘 날짜를 기준으로 한 달 전의 날짜 계산
var startDate = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());

$('input[name="oDt"]').daterangepicker({
    "locale": {
        "format": "YYYY-MM-DD",
        "separator": " ~ ",
        "applyLabel": "확인",
        "cancelLabel": "취소",
        "fromLabel": "From",
        "toLabel": "To",
        "customRangeLabel": "Custom",
        "weekLabel": "W",
        "daysOfWeek": ["일", "월", "화", "수", "목", "금", "토"],
        "monthNames": ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
    },
    "startDate": startDate,
    "endDate": new Date(),
    "drops": "bottom"
	}, function oDt (start, end, label) {

	var fromDate = start.format('YYYY-MM-DD');
	var toDate = end.format('YYYY-MM-DD');
	var oDt = (fromDate + toDate);
});

</script>


</html>