<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공통코드관리</title>
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

<body>


<div style="float:left;margin:30px;">	
	<form id="codeG">
	그룹명
	<input type="text" id="cName" name="cName">
	삭제여부
	<select class="select" id="cDelYn" name="cDelYn">
		<option value="">전체</option>
		<option value="Y">Y</option>
		<option value="N">N</option>
	</select>
	<button type="button" onclick="javascript:fnSearch();">조회</button>
	</form><br>
	
	<button id="addCodeRow" onclick="addRow('#codeGrid');">추가</button>	
	<button id="delCodeRow" onclick="delRow('#codeGrid');">삭제</button>
	<button id="saveRow" onclick="saveRow();">저장</button>
	<div>
		<table id="codeGrid"></table>
		<div id="pager"></div>
	</div>
	<br>
	<div id="detailGridContainer"  style="display:none">
	<button id="addDetailRow" onclick="addRow('#detailGrid');">추가</button>	
	<button id="delDetailRow" onclick="delRow('#detailGrid');">삭제</button>
	<button id="saveRow" onclick="">저장</button>	
	<table id="detailGrid"></table>
		<div id="detailPager"></div>
	</div>
	</div>
</body>

<script type="text/javascript">
$(document).ready(function() {
	
	setManageTitle("공통코드관리");
	
	var ColNames =  ['그룹아이디', '코드그룹명', '설명', '삭제여부','수정일자'];
	var ColModel = [
		{name: 'C_ID', index: 'C_ID', align: 'center', editable: true },
		{name: 'C_NAME', index: 'C_NAME', align: 'center', editable: true },
		{name: 'C_COMMENT', index: 'C_COMMENT', align: 'center', editable: true},
		{name: 'C_DEL_YN', index: 'C_DEL_YN', align: 'center', editable: true},
		{name: 'MODIFY_DT', index: 'MODIFY_DT', align: 'center',editable: true, 
			formatter: function(cellValue, options, rowObject) {
				  if (cellValue) {
				    var date = new Date(cellValue);
				    var formattedDate = date.toLocaleString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit' });
				    return formattedDate;
				  }
				  return '';
				} }
	];
	
	// 코드그룹
	  $("#codeGrid").jqGrid({
		    url: "/admin/codeGroup",
		    datatype: "json",
		    mtype: "GET",
		    height: 260,
		    width: 1020,
		    colNames: ColNames,
		    colModel: ColModel,
		    rowNum: 10,
		    rowList: [10, 20, 30],
		    pager: "#pager",
		    jsonReader: {
		      repeatitems: false,
		      root: "codeList",
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
		    multiselect:true, // select박스
		    rownumbers:true, //row 숫자 붙여줌
		    loadonce: true, // 데이터를 한 번에 모두 불러옴
		    gridview: true, // 빠른 그리드 렌더링을 위해 사용
		    viewrecords: true, // 총 레코드 수 표시
		    caption: "코드그룹", // 그리드 제목	
		    
/* 		    onCellSelect: function(rowid, iCol, cellcontent, e) {
				if(iCol === 1) {
					var rowData = $("#codeGrid").jqGrid('getRowData', rowid);
					var cId = rowData.C_ID;
					loadDetailGrid(cId);
				}
			}, */			
			onSelectRow: function(id) {
				  var rowData = $(this).jqGrid('getRowData', id);
				  var cId = rowData.C_ID;
				  loadDetailGrid(cId);				  
				},
				
		    loadComplete: function(data) {		    	
		        console.log("서버에서 넘어온 데이터", data);
		    }
		  });
		  
		});
	
	// 검색
	function fnSearch() {
		var cName = $("#cName").val();
		var cDelYn = $("#cDelYn").val();
		console.log("setGrid전 cName: " + cName + ", cDelYn: " + cDelYn);
		
		$("#codeGrid").setGridParam({
			postData: {
				cName: cName,
				cDelYn: cDelYn
			},
			gridComplete: function() {				
			}
		}).trigger("reloadGrid");
		
		$("#codeGrid").jqGrid('setGridParam', {
			url: '/admin/codeGroup',
			type: 'get',
			datatype: 'json',			
		}).trigger("reloadGrid");		
	}
	
	
	//행추가
/* 	var gridId; // 전역 변수로 gridId 선언

function addRow(gridId) {
  var data = { C_NAME: '', C_COMMENT: '', C_DEL_YN: '', MODIFY_DT: '' };
  var rowId = $(gridId).getGridParam('reccount');

  $(gridId).jqGrid('addRowData', rowId + 1, data, 'last');

  $(gridId).jqGrid('editRow', rowId + 1, {
    keys: true,
    oneditfunc: function (rowId) {
      if (String(rowId).startsWith('new')) {
        var gridRow = $(this);
        gridRow.find('td[role="gridcell"]').each(function () {
          var ColNames = $(this).attr('aria-describedby').split('_')[1];
          var inputId = rowId + '_' + ColNames;
          var inputElement = $('<input>', {
            type: 'text',
            name: ColNames,
            id: inputId,
            value: $(this).text(),
          }).appendTo($(this));
          inputElement.focus();
        });
      }
    },
    aftersavefunc: function (rowId) {
      if (String(rowId).startsWith('new')) {
        var gridRow = $(this);
        gridRow.find('td[role="gridcell"]').each(function () {
          var ColNames = $(this).attr('aria-describedby').split('_')[1];
          var inputId = rowId + '_' + ColNames;
          var inputValue = $('#' + inputId).val();
          $(this).text(inputValue);
        });
      }
    }
  });
} */

	var gridId; // 전역 변수로 gridId 선언
 	function addRow(gridId) {
		  var data = { C_NAME: '', C_COMMENT: '', C_DEL_YN: '', MODIFY_DT: '' };
		  var rowId = $(gridId).getGridParam('reccount');

		  $(gridId).jqGrid('addRowData', rowId + 1, data, 'last');

		  $(gridId).jqGrid('editRow', rowId + 1, {
		    keys: true,
		    oneditfunc: function (rowId) {
		      if (String(rowId).startsWith('new')) {
		        var gridRow = $(this);
		        gridRow.find('td[role="gridcell"]').each(function () {
		          var ColNames = $(this).attr('aria-describedby').split('_')[1];
		          var inputId = rowId + '_' + ColNames;
		          var inputElement = $('<input>', {
		            type: 'text',
		            name: ColNames,
		            id: inputId,
		            value: $(this).text(),
		          }).appendTo($(this));		          
		          inputElement.focus();		          
		        });
		      }
		    }
		  });
		} 

	// 저장
 function saveRow(gridId, rowId) {
  var gridRow = $(gridId).jqGrid('getRowData', rowId);
  console.log("gridRow", gridRow);

 //동적으로 생성된 ID 사용하여 값을 가져오기
  var cId = $('#' + rowId + '_C_ID').val();
  var cName = $('#' + rowId + '_C_NAME').val();
  var cComment = $('#' + rowId + '_C_COMMENT').val();
  var cDelYn = $('#' + rowId + '_C_DEL_YN').val();
  console.log("입력한 값:", cId, cName, cComment, cDelYn);
  
  gridRow.C_ID = cId;
  gridRow.C_NAME = cName;
  gridRow.C_COMMENT = cComment;
  gridRow.C_DEL_YN = cDelYn;

  $.ajax({
    url: "/admin/saveRow",
    type: "POST",
    data: gridRow,
    success: function(response) {      
      console.log("저장성공", response);
      
    },
    error: function(error) {     
      console.error("Error ", error);
      
    }
  });
} 

/*  	function saveRow(gridId, rowId, response) {
 		var gridRow = $(gridId).jqGrid('getRowData', rowId);
 		  console.log("들어오는 곳 확인1");
 		  
 		  if (String(rowId).startsWith('new')) {
 		    var gridRow = $(gridId);
 		    gridRow.find('td[role="gridcell"]').each(function () {
 		      var ColNames = $(this).attr('aria-describedby').split('_')[1];		      
 		      var inputValue = $(this).find('input[name="' + ColNames + '"]').val();
 		      console.log("ColNames", ColNames);
 		      console.log("inputValue: ", inputValue);

 		      $(this).text(inputValue);
 		    });
 		    console.log("들어오는 곳 확인2");
 		    var rowData = {
 		      //C_ID: $('#' + rowId + '_C_ID').val(),
 		      C_ID: $('#C_ID').val(),
 		      C_NAME: $('#' + rowId + '_C_NAME').val(),
 		      C_COMMENT: $('#' + rowId + '_C_COMMENT').val(),
 		      C_DEL_YN: $('#' + rowId + '_C_DEL_YN').val(),
 		      MODIFY_DT: $('#' + rowId + '_MODIFY_DT').val()
 		    };
 		    console.log("들어오는 곳 확인3");

 		    $.ajax({
 		      url: '/admin/saveRow',
 		      type: 'POST',
 		      data: JSON.stringify(rowData),
 		      processData: false,
 		      contentType: 'application/json',
 		      success: function (response) {
 		        if (response === "success") {
 		          console.log("response = " + response);
 		        }
 		      },
 		      error: function (error) {
 		      }
 		    });
 		  }
 		} */
	
	

	// 행 삭제	
   	function delRow(gridId){
		var selRowId = $(gridId).jqGrid('getGridParam', 'selrow'); 	
		if (selRowId) {
			var rowData = $(gridId).jqGrid('delRowData', selRowId);
			var selectVal = rowData.C_ID;
			console.log("selectVal", selectVal)
		} else {
			alert("삭제할 행을 선택해주세요.");
		}
	}    
	
 		// 삭제
/*   	function delRow(gridId) {
 		  var selRowId = $(gridId).jqGrid('getGridParam', 'selrow');		  
 		  if (selRowId) {
 		    var rowData = $(gridId).jqGrid('getRowData', selRowId);
 		    
 		    var selectedValue = rowData.C_ID;
 		    console.log("Selected Value: " + selectedValue);
 		    
 		    // 삭제 요청 전송
 		    $.ajax({
 		      url: '/admin/codeDel',
 		      type: 'POST',
 		      //data: { C_ID: selectedValue },
 		      data: JSON.stringify({ C_ID: selectedValue }),
 		      processData: false,
 		      contentType: 'application/json',
 		      success: function(response) {
 		        if (response === 'success') {
 		          // 서버에서 삭제가 성공적으로 처리되었을 경우 행 삭제
 		          $(gridId).jqGrid('delRowData', selRowId); 
 		        }
 		      },
 		      error: function(error) {
 		        console.error('행 삭제 실패:', error);
 		      }
 		    });
 		  } else {
 		    alert('삭제할 행을 선택해주세요.');
 		  }
 		}
 */

	// 저장
/*  	function saveRow(id){
		
		var row = $("#codeGrid").jqGrid('getRowData', id);
		if(id.startWith("new")) {
			$("#codeGrid").jqGrid('saveRow',id, {
				"url": "/admin/saveRow?id="+row.id,
				"mtype": "POST",
				"succesfunc": function(response) {
				  return true;
				}
			});
		}
	}  */

$(document).ready(function() {

	var ColNames =  ['상세아이디', '그룹아이디', '코드상세명', '순서', '설명', '삭제여부','수정일자'];
	var ColModel = [
		{name: 'D_ID', index: 'D_ID', align: 'center',editable: true},
		{name: 'C_ID', index: 'C_ID', align: 'center', editable: true},
		{name: 'D_NAME', index: 'D_NAME', align: 'center', editable: true},
		{name: 'D_SORT', index: 'D_SORT', align: 'center', editable: true},
		{name: 'D_COMMENT', index: 'D_COMMENT', align: 'center', editable: true},
		{name: 'D_DEL_YN', index: 'D_DEL_YN', align: 'center', editable: true},
		{name: 'MODIFY_DT', index: 'MODIFY_DT', align: 'center', editable: true,
			formatter: function(cellValue, options, rowObject) {
				  if (cellValue) {
				    var date = new Date(cellValue);
				    var formattedDate = date.toLocaleString('ko-KR', { year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit' });
				    return formattedDate;
				  }
				  return '';
				} }
	];
	
		// 코드상세
		  $("#detailGrid").jqGrid({
		    url: "/admin/codeDetail",
		    datatype: "json",
		    mtype: "GET",
		    height: 260,
		    width: 1020,
		    colNames: ColNames,
		    colModel: ColModel,
		    rowNum: 10,
		    rowList: [10, 20, 30],
		    pager: "#detailPager",
		    jsonReader: {
		      repeatitems: false,
		      root: "codeDeList",
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
		    multiselect:true, // select박스
		    rownumbers:true, //row 숫자 붙여줌
		    loadonce: true, // 데이터를 한 번에 모두 불러옴
		    gridview: true, // 빠른 그리드 렌더링을 위해 사용
		    viewrecords: true, // 총 레코드 수 표시
		    caption: "코드상세", // 그리드 제목
		    
		    loadComplete: function(data) {
		    	
		        console.log("서버에서 넘어온 데이터(상세)", data);
		    }
		  });		  
		});
		
function loadDetailGrid(cId) {
	$("#detailGridContainer").show(); // 코드상세 그리드 컨테이너 보여주기
	$("#detailGrid").setGridParam({
		postData: {cId: cId},
		loadComplete:function(data) {
			console.log("data: " , data);
		},
		gridComplete: function() {
			
		}		
	}).trigger("reloadGrid");
	
	$("#detailGrid").jqGrid('setGridParam', {
		url: "/admin/codeDetail?cId=" + cId,
		  type: 'GET',
		  datatype: 'json',
	  }).trigger("reloadGrid");
}	
/* function hideDetailGrid() {
    $("#detailGridContainer").hide(); // 코드상세 그리드 컨테이너 숨기기
}
$("#selectBox").change(function() {
    if ($(this).prop("checked")) {
        loadDetailGrid(cId); // 상세 그리드 로드
    } else {
        hideDetailGrid(); // 상세 그리드 숨기기
    }
}); */



</script>
</html>