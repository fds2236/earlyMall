<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트등록</title>

<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/redmond/jquery-ui.css" type="text/css" />
<!-- jqGrid CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/jqgrid/4.6.0/css/ui.jqgrid.css" type="text/css" />


<style type="text/css">
	#eventTable td input {
		margin-right: 5px;
	}
	#eventTable td:nth-child(4) input {
		margin-right: 0;
	}
	
	/* The Modal (background) */
    .modal {
        display: none; /* Hidden by default */
        position: fixed; /* Stay in place */
        z-index: 1; /* Sit on top */
        left: 0;
        top: 0;
        width: 100%; /* Full width */
        height: 100%; /* Full height */
        overflow: auto; /* Enable scroll if needed */
        background-color: rgb(0,0,0); /* Fallback color */
        background-color: rgba(0,0,0,0.5); /* Black w/ opacity */
    }    
    /* Modal Content/Box */
    .modal-content {
        background-color: #fefefe;
        margin: 100px auto;
        padding: 20px;
        border: 1px solid #888;
        width: 900px;
        height: 480px;
    }
</style>

</head>
<body>

	<jsp:include page="../import/adminFrame.jsp"/>
	
	<!-- The actual JQuery code -->
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.10.2.min.js" /></script>
	<!-- The JQuery UI code -->
	<script type="text/javascript" src="https://code.jquery.com/ui/1.10.3/jquery-ui.min.js" /></script>
	<!-- The jqGrid language file code-->
	<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/i18n/grid.locale-kr.js" /></script>
	<!-- The atual jqGrid code -->
	<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/jquery.jqGrid.src.js" /></script>


	<div style="float:left;margin:30px;">
		<form id="insertForm" enctype="multipart/form-data">
			<table id="eventTable">
				<tr>
					<th align="left">이벤트명</th>
					<th align="left">시작일</th>
					<th align="left">종료일</th>
					<th align="left">이벤트대표이미지</th>
					<th align="left">이벤트설명</th>
					<th align="left">삭제여부</th>
				</tr>
				<tr>
					<td><input type="text" name="eventName" id="eventName" required size="20"></td>
					<td><input type="date" name="eventStart" id="eventStart" required style="width: 100px;"></td>
					<td><input type="date" name="eventEnd" id="eventEnd" required style="width: 100px;"></td>
					<td><input type="file" name="eventImg" id="eventImg" style="width: 180px;"></td>
					<td><input type="text" name="eventComment" id="eventComment" size="30"></td>
					<td>
						<select name="eventDelYn" id="eventDelYn" style="padding: 0 10px 0 15px;">
							<option value="N">&nbsp;&nbsp;N</option>
							<option value="Y">&nbsp;&nbsp;Y</option>
						</select>
					</td>
				</tr>
			</table>
		
			<div style="width: 900px; margin-top: 10px; text-align: right;">
				<strong>할인율</strong>
				<input type="text" name="discountRate" id="discountRate" style="width:50px; text-align: right; font-size: 16px; margin: 0 10px 0 5px;" 
					oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\d+)(\.\d+)?/g, '$1$2 %');">
				<button type="button" onclick="applyDiscount()">일괄적용</button>
				<button type="button" id="btnAddGoods" style="margin: 0 10px 0 100px;">상품추가</button>
				<button type="button" id="btnDelGoods">상품삭제</button>
			</div>
			
			<div class="tableWrap" style="margin: 10px 0;">
			    <table id="eventGoodsList"></table>
			    <div id="pager"></div>
		  	</div>
		  	
		  	<div style="text-align: right; width: 900px;">
		  		<button type="button" id="btnRegEvent">등록하기</button>
		  		<button type="button" onclick="location.href='eventManage'">닫기</button>
		  	</div>
		  	
  		</form>
	</div>
  	
  	<!-- The Modal -->
    <div id="myModal" class="modal"> 
      	<!-- Modal content -->
      	<div class="modal-content">
		      	<h2 style="display: inline-block;">상품추가</h2>
		      	<a onClick="close_pop();" style="float: right; cursor: pointer; font-size: 24px; margin: -15px 0 0 0;">x</a>
	      	<form id="searchGoods" style="display: flex;">
			  	<table style="margin-right: 10px;">
				  	<tr>
					  	<td>카테고리</td>
					  	<td>
						  	<select name="gCateCd" id="goodsGategory">
							  	<option value="">전체</option>
							  	<c:forEach var="gdsCate" items="${goodsCate}">
							  	  	<option value="${gdsCate.DID}">${gdsCate.DNAME}</option>
							  	</c:forEach>
						  	</select>
					  	</td>
				  	  	<td>상품명</td>
					  	<td><input type="text" name="goodsName" id="goodsName"></td>
				  	</tr>
			  	</table>
			  	<button type="button" class="btn" onclick="fnSearch();" style="width: 50px;">조회</button>
		  	</form>
		  	
		  	<div class="tableWrap" style="margin: 20px 0;">
			    <table id="goodsList"></table>
			    <div id="pager"></div>    
		  	</div>
		  	
		  	<div style="float: right;">
			  	<button type="button" onclick="addGoods();">상품추가</button>
			  	<button type="button" onClick="close_pop();" style="margin-left: 10px;">닫기</button>
			</div>		  
      	</div> 
    </div>
    <!--End Modal-->
</body>

<script type="text/javascript">
	/* 이벤트 등록 바닥화면 */
	$(document).ready(function() {

		setManageTitle("이벤트등록");
		
		var searchColNames = ['아이디', '카테고리', '상품명', '가격', '수량', '이벤트가격'];
		var searchColModel = [
				{name: 'G_ID', index: 'G_ID', hidden: true},
				{name: 'G_CATE_CD', index: 'G_CATE_CD', align: 'center',
					formatter: function(cellValue, options, rowObject) {
				        if (cellValue === '10') {
				          return '가전';
				        } else if (cellValue === '30') {
				          return '모바일';
				        } else {
				        	return cellValue;
				        }
					}
				},
				{name: 'G_NAME', index: 'G_NAME', align: 'center'},
				{name: 'G_PRICE', index: 'G_PRICE', align: 'center',
						formatter: 'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
				{name: 'G_QTY', index: 'G_QTY', align: 'center'},
				{name: 'EG_PRICE', index: 'EG_PRICE', align: 'center', editable: true,
						formatter: 'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}}
			];
		
		$("#eventGoodsList").jqGrid({
			datatype: 'local',
			height: 'auto',
			width: 900,
			shrinkToFit: true,
			colNames: searchColNames,
			colModel: searchColModel,
			rowNum: 10,
			rowList: [10, 20, 30],
			pager: '#pager',
			jsonReader: {
				repeatitems: false,
				root: "dataList",
				page: function(obj) {
					return 1;
				},
				total: function(obj) {
					return obj.totalPages;
				},
				records: function(obj) {
					return obj.totalRecords;
				}
			},
			multiselect:true,
			rownumbers: true,
			loadonce: true,
			gridview: true,
			viewrecords: true,
			caption: '이벤트상품목록',
			loadComplete: function(data) {
				console.log("이벤트상품데이터", data.dataList)
			}
		});
		
		//상품삭제
		$("#btnDelGoods").click(function() {
			console.log("상품 삭제 클릭함");
			var eventGrid = $("#eventGoodsList");
		    var selectedRowIds = eventGrid.jqGrid("getGridParam", "selarrrow");
		    console.log(selectedRowIds);
		    if (selectedRowIds && selectedRowIds.length > 0) {
		       for (var i = selectedRowIds.length - 1; i >= 0; i--) {
		          var rowId = selectedRowIds[i];
		          eventGrid.jqGrid("delRowData", rowId);
		       }

		       eventGrid.trigger("reloadGrid");
		    } else {
		    	console.log("선택된 행이 없음");
		    }
		});
		
		//필드값 초기화
		$("#eventName").val('');
		$("#eventStart").val('');
		$("#eventEnd").val('');
		$("#eventDelYn").val('');
		$("#eventImg").val('');
		$("#eventComment").val('');
		
	});
	
	//할인율 적용
	function applyDiscount() {
		var discountRate = document.getElementById('discountRate').value;		
		var selectedRows = $("#eventGoodsList").jqGrid("getGridParam", "selarrrow");
 		var updateData = [];
		
		for (var i = 0; i < selectedRows.length; i++) {
			var rowData = $("#eventGoodsList").jqGrid("getRowData", selectedRows[i]);
			var originPrice = rowData.G_PRICE.replace(/[^0-9.]/g, "");
			var discountPrice = calculateDiscount(originPrice, discountRate);
			
			$("#eventGoodsList").jqGrid("setCell", selectedRows[i], "EG_PRICE", discountPrice);
			var dataItem = {
					id: rowData.id, 
					discountPrice: discountPrice};
			updateData.push(dataItem);
		}
	}
	
	function calculateDiscount(price, discountRate) {
		  var originalPrice = parseFloat(price);
		  var discount = parseFloat(discountRate) / 100;
		  var discountedPrice = originalPrice - (originalPrice * discount);

		  return discountedPrice.toFixed(2);
	}
	
	//상품추가 모달
	$("#btnAddGoods").click(function() {
	    $('#myModal').show();
	});
	//모달창 닫기
	function close_pop(flag) {
	     $('#myModal').hide();
	};
	
	// 쉼표(,) 제거하는 함수
    function removeComma(str) {
        return str.replace(/,/g, '');
    }
	
	//이벤트등록
	$("#btnRegEvent").click(function() {
		if (confirm("이벤트를 등록하실건가요?")) {
			var form = $("#insertForm")[0];
			var formData = new FormData(form);
			
			
			// 할인된 가격으로 데이터 업데이트 적용
			var gridData = [];
			var grid = $("#eventGoodsList");
			var ids = grid.jqGrid("getDataIDs");
			
			for (var i = 0; i < ids.length; i++) {
				var rowId = ids[i];
				var rowData = grid.jqGrid("getRowData", rowId);
				gridData.push(rowData);
			}			
			
			//가격 쉼표 제거
			for (var eventData of gridData) {
			    for (var key in eventData) {
			        if (typeof eventData[key] === 'string') {
			            eventData[key] = removeComma(eventData[key].trim());
			        }
			    }
			}
			
			formData.append("gridData", JSON.stringify(gridData));
			
			$.ajax({
				url: "/admin/insertEvent",
				type: "POST",
				data: formData,
				enctype: "multipart/form-data",
				processData: false,
				contentType: false,
				success: function(response) {
					console.log("이벤트 등록 성공");
 					$("#insertForm")[0].reset(); //폼 초기화
				},
				error: function(xhr, status, error) {
					console.log("에러 발생:", error);
				}
			});
		}		
	});
	
	
	/* 상품추가 팝업창 */
	
	//상품목록
	$(document).ready(function() {
		var searchColNames = ['아이디', '카테고리', '상품명', '가격', '수량', '이벤트가격'];
		var searchColModel = [
				{name: 'G_ID', index: 'G_ID', hidden: true},
				{name: 'G_CATE_CD', index: 'G_CATE_CD', align: 'center',
					formatter: function(cellValue, options, rowObject) {
				        if (cellValue === '10') {
				          return '가전';
				        } else if (cellValue === '20') {
				          return '컴퓨터';
				        } else if (cellValue === '30') {
				          return '모바일';
				        } else {
				        	return cellValue;
				        }
					}
				},
				{name: 'G_NAME', index: 'G_NAME',align: 'center'},
				{name: 'G_PRICE', index: 'G_PRICE', align: 'center',
						formatter: 'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}},
				{name: 'G_QTY', index: 'G_QTY', align: 'center'},
				{name: 'EG_PRICE', index: 'EG_PRICE', align: 'center', editable: true, 
						formatter: 'currency', formatoptions:{thousandsSeparator:",", decimalPlaces: 0}}
			];
		
		$("#goodsList").jqGrid({
			url: '/admin/goodsMg',
			datatype: 'JSON',
			mtype: 'GET',
			height: 'auto',
			width: 900,
			shrinkToFit: true,
			colNames: searchColNames,
			colModel: searchColModel,
			rowNum: 10,
			rowList: [10, 20, 30],
			pager: '#pager',
			jsonReader: {
				repeatitems: false,
				root: "dataList",
				page: function(obj) {
					return 1;
				},
				total: function(obj) {
					return obj.totalPages;
				},
				records: function(obj) {
					return obj.totalRecords;
				}
			},
			multiselect:true,
			rownumbers: true,
			loadonce: true,
			gridview: true,
			viewrecords: true,
			loadComplete: function(data) {
				console.log("상품추가데이터", data.dataList)
			},
			onSelectRow: function(rowid) {
				var grid = $("#goodsList");
				grid.jqGrid('editRow', rowid, true, null, null, null, null, function() {
					var rowData = grid.jqGrid('getRowData', rowid, true);
				});
			},
			inlineNav: {
				add: false,
				edit: true,
				save: true,
				cancel: true,
				editParams: {
					keys: true
				}
			}
		});				
	});
	
	//조회 기능
	function fnSearch() {
		var goodsGategory = $("#goodsGategory").val();
		var searchKeyword = $("#goodsName").val();

		$("#goodsList").setGridParam({
			postData : {
				gCateCd : goodsGategory,
				searchKeyword : searchKeyword
			},
			gridComplete : function() {

			}
		}).trigger("reloadGrid");

		$("#goodsList").jqGrid('setGridParam', {
			url : '/admin/goodsMg',
			mtype : 'GET',
			datatype : 'json'
		}).trigger("reloadGrid");
	}
	
 	//상품데이터 보내기
 	function addGoods() {
	    var grid = $("#goodsList");
	    var selectedRowIds = grid.jqGrid("getGridParam", "selarrrow");
	
	    if (selectedRowIds && selectedRowIds.length > 0) {
	        for (var i = 0; i < selectedRowIds.length; i++) {
	            var rowId = selectedRowIds[i];
	            grid.jqGrid("saveRow", rowId, {
	                url: "clientArray",
	                mtype: "POST",
	                aftersavefunc: function(rowId, response) {
	                    var rowData = grid.jqGrid("getRowData", rowId);
	                    var eventGrid = $("#eventGoodsList");
	                    var eventRowIds = eventGrid.jqGrid("getDataIDs");
						var newRowId = $.jgrid.randId();
	                    
	                    eventGrid.jqGrid("addRowData", newRowId, rowData);
	                    eventGrid.trigger("reloadGrid");
	                },
	                errorfunc: function(rowId, response) {
	                    console.error("상품 추가 실패", response);
	                }
	            });
	        }
	    }
	
	    close_pop();
	}
	
</script>

</html>