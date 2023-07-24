<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트관리</title>

<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/redmond/jquery-ui.css" type="text/css" />
<!-- jqGrid CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/jqgrid/4.6.0/css/ui.jqgrid.css" type="text/css" />

<style>
	.flex {display: flex;}
	.tableWrap {margin-top: 10px;}
	.btn {margin-left: 10px;}
	
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
        width: 800px;
        height: 500px;
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
		<div class="flex">
			<form class="flex" id="searchEvent">
				<table>
					<tr>
						<td>이벤트명</td>
						<td><input type="text" name="searchName" id="searchName"></td>
						<td>시작일</td>
						<td><input type="date" name="searchStart" id="searchStart"></td>
						<td>종료일</td>
						<td><input type="date" name="searchEnd" id="searchEnd"></td>
						<td>삭제여부</td>
						<td>
							<select name="eventDelYn" id="eventDelYn">
								<option value="">전체</option>
								<option value="Y">Y</option>
								<option value="N">N</option>
							</select>
						</td>
					</tr>
				</table>
				<button type="button" class="btn" onclick="fnSearch();">조회</button>
			</form>
			<button type="button" class="btn" onclick="location.href='insertEvent'">이벤트등록</button>
		</div>	
		<div class="tableWrap">
		    <table id="eventList"></table>
		    <div id="pager"></div>    
	  	</div>
  	</div>
  	
  	<!-- The Modal -->
    <div id="myModal" class="modal"> 
      	<!-- Modal content -->
      	<div class="modal-content">
		      	<h2 style="display: inline-block;">이벤트수정</h2>
		      	<a onClick="close_pop();" style="float: right; cursor: pointer; font-size: 24px; margin: -15px 0 0 0;">x</a>
	      	
	      	<form id="updateEvent" enctype="multipart/form-data">
			  	<table>
				  	<tr>
				  		<td>
				  			<span>이벤트명</span><br>
				  			<input type="text" id="eName" name="eName" required>
				  		</td>				  		
				  		<td>
				  			<span>이벤트설명</span><br>
				  			<input type="text" id="eComment" name="eComment" required>
				  		</td>
				  	</tr>
				  	<tr>
				  		<td>
					  		<span>이벤트시작일</span><br>
				  			<input type="date" id="eStDt" name="eStDt" required>
				  		</td>
				  		<td>
					  		<span>이벤트종료일</span><br>
				  			<input type="date" id="eEndDt" name="eEndDt" required>
				  		</td>
				  	</tr>
				  	<tr>
				  		<td>
					  		<span>이벤트이미지</span><br>
				  			<input type="text" id="eImgTxt" readonly="readonly">
				  			<input type="file" id="eImg" name="eImg" required>
				  		</td>
				  		<td>
					  		<span>삭제여부</span><br>
				  			<select id="eDelYn" name="eDelYn" style="padding: 0 5px 0 15px;" required>
				  				<option value="N">N</option>
					        	<option value="Y">Y</option>
				  			</select>
				  		</td>
				  	</tr>
			  	</table>
		  	</form>
		  	
		  	<div style="float: right;">
			  	<button type="button" id="btnUpdEvent" onclick="updEvent();">수정</button>
			  	<button type="button" id="btnDelEvent" onclick="delEvent();" style="margin: 0 5px;">삭제</button>
			  	<button type="button" onClick="close_pop();">닫기</button>
			</div>		  
      	</div> 
    </div>
    <!--End Modal-->

</body>

<script type="text/javascript">
	$(document).ready(function() {
		
		setManageTitle("이벤트관리");
		
		var searchColNames = ['아이디', '이벤트명', '이벤트설명', '이벤트이미지', '시작일', '종료일', '삭제여부', '수정일시', '등록일시'];
		var searchColModel = [
				{name: 'E_ID', index: 'E_ID', width: 100, align: 'center', width: 100,
					formatter: function(cellValue, options, rowObject) {
						var eId = rowObject.E_ID;
						return '<a href="javascript:void(0);" class="eIdLink" data-eid="'
								+ eId + '" style="display: block; text-decoration: none;">' + eId + '</a>';
					}
				},
				{name: 'E_NAME', index: 'E_NAME', align: 'center', width: 150},
				{name: 'E_COMMENT', index: 'E_COMMENT', align: 'left', width: 250},
				{name: 'E_IMG', index: 'E_IMG', align: 'left', width: 200},
				{name: 'E_ST_DT', index: 'E_ST_DT', align: 'center', formatter: formatDate},
				{name: 'E_END_DT', index: 'E_END_DT', align: 'center', formatter: formatDate},
				{name: 'E_DEL_YN', index: 'E_DEL_YN', align: 'center', width: 100},
				{name: 'MODIFY_DT', index: 'MODIFY_DT', align: 'center', formatter: formatDate},
				{name: 'E_REG_DT', index: 'E_REG_DT', align: 'center', formatter: formatDate}				
			];
		
		$("#eventList").jqGrid({
			url: '/admin/getEventList',
			datatype: 'JSON',
			mtype: 'GET',
			height: 'auto',
			autowidth: true,
			shrinkToFit: true,
			colNames: searchColNames,
			colModel: searchColModel,
			rowNum: 10,
			rowList: [10, 20, 30],
			pager: '#pager',
			sortname: 'e_id',
			sortorder: 'asc',
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
			rownumbers: true,
			loadonce: true,
			gridview: true,
			viewrecords: true,
			caption: '이벤트목록',
			loadComplete: function(data) {
				console.log("이벤트데이터", data.dataList)
			}
		});
		
	});
	
	// 날짜 포맷 설정
	function formatDate(cellValue, options, rowObject) {
		var date = new Date(cellValue);
		var formattedDate = date.toLocaleString('ko-KR', {
			year: 'numeric',
			month: '2-digit',
			day: '2-digit'
		});
		return formattedDate;
	}
	
	// 조회 기능
	function fnSearch() {
		var searchName = $("#searchName").val();
		var searchStart = $("#searchStart").val();
		var searchEnd = $("#searchEnd").val();
		var eventDelYn = $("#eventDelYn").val();
		
		$("#eventList").setGridParam({
			postData: {
				'searchName': searchName,
				'searchStart': searchStart,
				'searchEnd': searchEnd,
				'eventDelYn': eventDelYn
			},
			loadComplete: function(data) {
				console.log("이벤트데이터", data && data.dataList);
				$(".ui-state-default.jqgrid-rownum").removeClass('ui-state-default jqgrid-rownum');
				$("#eventList_nodata").remove();
				if(data && data.dataList && data.dataList.length === 0) {
					$("#eventList.ui-jqgrid-btable").after("<p id='eventList_nodata' style='margin-top: 15px; text-align: center; font-weight:bold;'>검색된 데이터가 없습니다</p>")
				}
			},
			gridComplete: function() {
				
			}
		}).trigger("reloadGrid")
		
		$("#eventList").jqGrid('setGridParam', {
			url: '/admin/getEventList',
			mtype: 'GET',
			datatype: 'json'
		}).trigger("reloadGrid");
	}
	
	//모달창 닫기
	function close_pop(flag) {
	     $('#myModal').hide();
	};
	//다른 곳을 클릭하면 창닫기
	$(window).click(function(event) {
		if (event.target == $("#myModal")[0]) {
			close_pop();
		}
	});
	
	//아이디 클릭시 팝업 이벤트
	$("#eventList").on("click", "a.eIdLink", function() {
		var eId = $(this).data("eid"); // 클릭한 a 태그의 data-eid 속성 값을 가져오기
		var rowId = $(this).closest("tr").attr("id"); // 클릭한 a 태그가 속한 행의 ID 가져오기
		var rowObject = $("#eventList").jqGrid("getLocalRow", rowId); // 행의 원본 데이터 객체 가져오기

		console.log(rowObject);
		
		// 모달 필드값 초기화
		$("#myModal #eName").val('');
		$("#myModal #eComment").val('');
		$("#myModal #eStDt").val('');
		$("#myModal #eEndDt").val('');
		$("#myModal #eImgTxt").val('');
		$("#myModal #eDelYn").val('');
		
		// eId 값을 동적으로 생성하여 input hidden에 설정		
		var hiddenInput = "<input id='hiddenEId' type='hidden' name='eId' value='" + rowObject.E_ID + "'>";
		$("#myModal form").append(hiddenInput);
		
		// 모달 필드값 설정
		$("#myModal #eName").val(rowObject.E_NAME);
		$("#myModal #eComment").val(rowObject.E_COMMENT);
		
		// 기존 날짜 데이터 설정
		var startDate = new Date(rowObject.E_ST_DT);
		var endDate = new Date(rowObject.E_END_DT);
		
		$("#myModal #eStDt").val(startDate.toISOString().split("T")[0]);
		$("#myModal #eEndDt").val(endDate.toISOString().split("T")[0]);
		
		// eImgTxt 설정
		$('#eImg').on('change', function() {			
	      	var filename = $(this).val().split('\\').pop();
	      	$('#eImgTxt').val(filename);
		});
		
		$("#myModal #eImgTxt").val(rowObject.E_IMG);
		$("#myModal #eDelYn").val(rowObject.E_DEL_YN);
		
		// 모달 표시
		$("#myModal").css("display", "block");
	});
</script>

</html>