<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 상품관리</title>
</head>

<link rel="stylesheet"
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/redmond/jquery-ui.css"
	type="text/css" />
<!-- jqGrid CSS -->
<link rel="stylesheet"
	href="//cdn.jsdelivr.net/jqgrid/4.6.0/css/ui.jqgrid.css"
	type="text/css" />


<!-- 스타일 -->
<style>

/* 모달 스타일 */
.modal {
	display: none; /* 기본적으로 숨김 */
	position: fixed; /* 고정 위치 */
	z-index: 1; /* 다른 요소들보다 위에 표시되도록 설정 */
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto; /* 스크롤 생성 */
	transform: translate(-25px, -25px);
	background-color: rgba(0, 0, 0, 0.4); /* 배경 투명도 설정 */
}

.modal-content {
	background-color: #fefefe; /* 모달 내용 배경색 */
	margin: 15% auto; /* 모달 위치 */
	padding: 20px;
	border: 1px solid #888;
	width: 80%;
	max-width: 600px;
}

.close {	
	float: right;
	
}



#gPrice::-webkit-inner-spin-button, gPrice::-webkit-outer-spin-button {
	-webkit-appearance: none;
	margin: 0;
}

.tableWrap {
	margin-top: 10px;
}

.btn {
	margin-top: 5px;
	margin-bottom: 5px;
	margin-left: 5px;
	margin-right: 5px;
	padding: 8px 16px;
	border: none;
	border-radius: 4px;
	background-color: #79b7e7;
	color: white;
	font-size: 14px;
	cursor: pointer;
}

.btn:hover {
	background-color: #4297d7;
}

table {
	width: 100%;
	border-collapse: collapse;
	
}

#cateTable {
	background-color: #79b7e7;
	border-radius : 5px;
}

th, td {
	padding: 8px;
	text-align: left;
	
}

#popTable {
	border: 1px solid #79b7e7;

}

.modalTitle {
	font-size: 20px;
	font-weight: bold;
}

</style>



<body>

	<jsp:include page="../import/adminFrame.jsp" />

	<!-- The actual JQuery code -->
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-1.10.2.min.js"></script>
	<!-- The JQuery UI code -->
	<script type="text/javascript"
		src="https://code.jquery.com/ui/1.10.3/jquery-ui.min.js"></script>
	<!-- The jqGrid language file code-->
	<script type="text/javascript"
		src="//cdn.jsdelivr.net/jqgrid/4.6.0/i18n/grid.locale-kr.js"></script>
	<!-- The atual jqGrid code -->
	<script type="text/javascript"
		src="//cdn.jsdelivr.net/jqgrid/4.6.0/jquery.jqGrid.src.js"></script>

	<div style="float: left; margin: 30px;">
		<div style="display: flex; align-items: center;">
			<form id="searchForm">
				<table id="cateTable">
					<tr>
						<td>카테고리</td>
						<td><select name="gCateCd" id="goodsGategory">
								<option value="">전체</option>
								<c:forEach var="gdsCate" items="${goodsCateList}">
									<option value="${gdsCate.DID}">${gdsCate.DNAME}</option>
								</c:forEach>
						</select></td>
						<td>상품명</td>
						<td><input id="goodsName" type="search" name="searchKeyword">
						</td>
						<td>노출여부</td>
						<td><select name="gShowYn" id="goodsShowYn">
								<option value="">전체</option>
								<option value="Y">Y</option>
								<option value="N">N</option>
						</select></td>
						<td>삭제여부</td>
						<td><select name="gDelYn" id="goodsDelYn">
								<option value="">전체</option>
								<option value="Y">Y</option>
								<option value="N">N</option>
						</select></td>
					</tr>
				</table>
			</form>

			<div style="display: flex; justify-content: flex-end;">
				<button class="btn" type="button" form="searchForm"
					onclick="javascript:fnSearch();">조회</button>
				<button class="btn" type="button"
					onclick="javascript:openInsertModal();">상품등록</button>
			</div>
		</div>

		<div style="display: flex; justify-content: flex-end;">
			<button class="btn" type="button" onclick="doAllViewY()">일괄노출</button>
			<button class="btn" type="button" onclick="javascript:doAllViewN();">일괄비노출</button>
			<button class="btn" type="button" onclick="javascript:doAllDelY();">일괄삭제</button>
		</div>


		<div class="tableWrap">
			<table id="mainGrid"></table>
			<div id="pager"></div>
		</div>

	</div>

	<!-- HTML 모달 -->
	<div id="myModal" class="modal" style="float: left; margin: 30px;">
		<div class="modal-content">
		
			<span id="registerTitle" class="modalTitle" style="display: none;">상품등록</span>
			<span id="updateTitle" class="modalTitle" style="display: none;">상품수정</span>
			
			<span class="close">&times;</span>
			
			<form id="insertContents" enctype="multipart/form-data">
				<div>
				
				
					<div>
					  <table id="popTable">
					    <tr>
					      <td>
					        <label for="gCateCd">카테고리</label><br>
					         <select id="gCateCd" name="gCateCd" required>
								<c:forEach var="gdsCate" items="${goodsCateList}">
									<option value="${gdsCate.DID}">${gdsCate.DNAME}</option>
								</c:forEach>
							</select>
					      </td>
					      <td>
					        <label for="gName">상품명</label><br>
					        <input id="gName" type="text" name="gName" required>
					      </td>
					    </tr>
					    <tr>
					      <td>
					        <label for="gPrice">가격</label><br>
					        <input id="gPrice" type="text" name="gPrice" oninput="formatPriceInput(this)" required>
					      </td>
					      <td>
					        <label for="gQty">수량</label><br>
					        <input id="gQty" type="number" name="gQty" required>
					      </td>
					    </tr>
					    <tr>
					      <td>
					        <label for="gImg">대표이미지</label><br>
					        <input id="gImgText" type="text" readonly="readonly">
					        <input id="gImg" type="file" name="gImg" required>
					      </td>
					      <td>
					        <label for="gImgDtl">상세이미지</label><br>
					        <input id="gImgDtlText" type="text" readonly="readonly">
					        <input id="gImgDtl" type="file" name="gImgDtl" required>
					      </td>
					    </tr>
					    <tr>
					      <td>
					        <label for="gShowYn">노출여부</label><br>
					        <select id="gShowYn" name="gShowYn" required>
					          <option value="N">N</option>
					          <option value="Y">Y</option>
					        </select>
					      </td>
					      <td>
					        <label for="gDelYn">삭제여부</label><br>
					        <select id="gDelYn" name="gDelYn" required>
					          <option value="N">N</option>
					          <option value="Y">Y</option>
					        </select>
					      </td>
					    </tr>
					  </table>
					</div>
													
					<button  class="btn" id="registerBtn" type="button">상품등록</button>
					<button  class="btn" id="updateBtn" type="button">상품수정</button>
					<button  class="btn" id="delBtn" type="button">삭제</button>
					<button  class="close btn" type="button">닫기</button>
				</div>

			</form>
		</div>
	</div>





</body>

<script type="text/javascript">
	var rowData;

	$(document)
			.ready(
					function() {

						setManageTitle("상품관리");

						// fnSearch(); // 주석 처리: 페이지 로드 시 자동으로 호출되지 않도록 변경

						var searchResultColNames = [ '아이디', '카테고리', '상품명',
								'가격', '수량', '대표이미지', '상세이미지', '노출여부', '삭제여부',
								'수정일시' ];
						var searchResultColModel = [
								{
									name : 'G_ID',
									index : 'G_ID',
									align : 'center',
									sorttype : 'number',
									formatter : function(cellValue, options,
											rowObject) {
										var gId = rowObject.G_ID; // 'G_ID'의 값 가져오기           
										return '<a href="javascript:void(0);" class="gIdLink" data-gid="'
												+ gId + '">' + gId + '</a>';
									}
								},
								{
									name : 'G_CATE_CD',
									index : 'G_CATE_CD',
									align : 'center',

									formatter : function(cellValue, options,
											rowObject) {
										if (cellValue === '10') {
											return '가전';
										} else if (cellValue === '20') {
											return '컴퓨터';
										} else {
											return '모바일';
										}
									}
								},
								{
									name : 'G_NAME',
									index : 'G_NAME',
									align : 'center'
								},
								{
									name : 'G_PRICE',
									index : 'G_PRICE',
									align : 'right',
									sorttype : 'number',
									formatter : 'integer',
									formatoptions : {
										defaultValue : '',
										thousandsSeparator : ','
									}
								},
								{
									name : 'G_QTY',
									index : 'G_QTY',
									align : 'right',
									sorttype : 'number'
								},
								{
									name : 'G_IMG',
									index : 'G_IMG',
									align : 'left'
								},
								{
									name : 'G_IMG_DTL',
									index : 'G_IMG_DTL',
									align : 'left'
								},
								{
									name : 'G_SHOW_YN',
									index : 'G_SHOW_YN',
									align : 'center'
								},
								{
									name : 'G_DEL_YN',
									index : 'G_DEL_YN',
									align : 'center'
								},
								{
									name : 'MODIFY_DT',
									index : 'MODIFY_DT',
									align : 'center',
									formatter : function(cellValue, options,
											rowObject) {
										var date = new Date(cellValue);
										var formattedDate = date
												.toLocaleString('ko-KR', {
													year : 'numeric',
													month : '2-digit',
													day : '2-digit',
													hour : '2-digit',
													minute : '2-digit'
												});
										return formattedDate;
									}
								} ];

						$("#mainGrid").jqGrid({
							url : "/admin/goodsMg",
							datatype : "json",
							mtype : "GET",
							postData : {

							},
							height : 400,
							width : 850,
							colNames : searchResultColNames,
							colModel : searchResultColModel,
							rowNum : 10,
							rowList : [ 10, 20, 30 ],
							pager : "#pager",
							jsonReader : {
								repeatitems : false,
								root : "dataList",
								page : function(obj) {
									return 1;
								},
								total : function(obj) {
									return obj.totalPages;
								},
								records : function(obj) {
									return obj.totalRecords;
								}
							},							
							multiselect : true, // select박스
							rownumbers : true, //row 숫자 붙여줌
							loadonce : true, // 데이터를 한 번에 모두 불러옴
							gridview : true, // 빠른 그리드 렌더링을 위해 사용
							viewrecords : true, // 총 레코드 수 표시
							caption : "상품 목록", // 그리드 제목
							loadComplete : function(data) {
								console.log("서버에서 넘어온 데이터", data.dataList);

							}

						});

						// 여기여기ㅣ여기 gImgDtl
						 $('#gImg').on('change', function() {
						      var filename = $(this).val().split('\\').pop();
						      $('#gImgText').val(filename);
						    });
						
						 $('#gImgDtl').on('change', function() {
						      var filename = $(this).val().split('\\').pop();
						      $('#gImgDtlText').val(filename);
						    });
						
					});

	function fnSearch() {
		var goodsGategory = $("#goodsGategory").val();
		var searchKeyword = $("#goodsName").val();
		var goodsShowYn = $("#goodsShowYn").val();
		var goodsDelYn = $("#goodsDelYn").val();
		// 입력 값 받아서 저장		

		$("#mainGrid").setGridParam({
			postData : {
				gCateCd : goodsGategory,
				searchKeyword : searchKeyword,
				gShowYn : goodsShowYn,
				gDelYn : goodsDelYn
			},
			gridComplete : function() {

			}
		}).trigger("reloadGrid");

		$("#mainGrid").jqGrid('setGridParam', {
			url : '/admin/goodsMg',
			mtype : 'GET',
			datatype : 'json'
		}).trigger("reloadGrid");
	}

	function allViewY(arrayGId) {
		$.ajax({
			url : '/admin/doAllViewY',
			type : 'GET',
			data : {
				'gId' : arrayGId
			},
			success : function(response) {
				if (response === "success") {
					console.log("response = " + response);
					console.log('일괄 노출 성공');
					// 성공적으로 노출 업데이트된 경우
					// 추가 작업 수행
					fnSearch();
				} else {
					// 노출 업데이트에 실패한 경우
					// 실패 처리에 대한 작업 수행
				}
			},
			error : function(error) {
				console.log('일괄 노출 실패:', error);
			}
		});
	}

	function allViewN(arrayGId) {
		$.ajax({
			url : '/admin/doAllViewN',
			type : 'GET',
			data : {
				'gId' : arrayGId
			},
			success : function(response) {
				if (response === "success") {
					console.log("response = " + response);
					console.log('일괄 비노출 성공');
					// 성공적으로 노출 업데이트된 경우
					// 추가 작업 수행
					fnSearch();
				} else {
					// 노출 업데이트에 실패한 경우
					// 실패 처리에 대한 작업 수행
				}
			},
			error : function(error) {
				console.log('일괄 비노출 실패:', error);
			}
		});
	}

	function allDelY(arrayGId) {
		$.ajax({
			url : '/admin/doAllDelY',
			type : 'GET',
			data : {
				'gId' : arrayGId
			},
			success : function(response) {
				if (response === "success") {
					console.log("response = " + response);
					console.log('일괄 삭제 성공');
					// 성공적으로 노출 업데이트된 경우
					// 추가 작업 수행
					fnSearch();
				} else {
					// 노출 업데이트에 실패한 경우
					// 실패 처리에 대한 작업 수행
				}
			},
			error : function(error) {
				console.log('일괄 삭제 실패:', error);
			}
		});
	}

	//선택박스 선택한 값 뽑아 내는 함수
	function getSelectedCellValues() {
		var selectedRowIds = $("#mainGrid").jqGrid("getGridParam", "selarrrow");
		var selectedCellValues = [];

		for (var i = 0; i < selectedRowIds.length; i++) {
			var rowData = $("#mainGrid")
					.jqGrid("getRowData", selectedRowIds[i]);
			//var cellId = rowData.G_ID; //선택 셀의 굿즈 id 저장
			selectedCellValues.push(rowData);
		}
		console.log("선택된 값 =", selectedCellValues); //sonsole.log
		return selectedCellValues;
	}
	

	function doAllViewY() {
		var selectedCellValues = getSelectedCellValues();
		for (var j = 0; j < selectedCellValues.length; j++) {
// 			var arrayGId = selectedCellValues[j].G_ID;
// 			allViewY(arrayGId);
			var gId = $(selectedCellValues[j].G_ID).text(); // 선택된 셀의 gId 값
		    allViewY(gId);
		}
	}

	function doAllViewN() {
		var selectedCellValues = getSelectedCellValues();
		for (var j = 0; j < selectedCellValues.length; j++) {
			var gId = $(selectedCellValues[j].G_ID).text(); // 선택된 셀의 gId 값
			allViewN(gId);
		}
	}

	function doAllDelY() {
		var selectedCellValues = getSelectedCellValues();
		for (var j = 0; j < selectedCellValues.length; j++) {
			var gId = $(selectedCellValues[j].G_ID).text(); // 선택된 셀의 gId 값
			allDelY(gId);
		}
	}
</script>

<script>
	// 상품등록 버튼 모달 열기
	function openInsertModal() {
		$("#myModal").css("display", "block");

		$("#updateTitle").hide();
		$("#registerTitle").show();
		$("#registerBtn").show();
		$("#updateBtn").show();
		$("#delBtn").show();	
		
		
		// 모달 필드 값을 초기화
		$("#myModal #gCateCd").val('');
		$("#myModal #gPrice").val('');
		$("#myModal #gName").val('');
		$("#myModal #gQty").val('');
		$("#myModal #gImgText").val('');
		$("#myModal #gImg").val('');
		$("#myModal #gImgDtlText").val('');
		$("#myModal #gImgDtl").val('');
		$("#myModal #gShowYn").val('');
		$("#myModal #gDelYn").val('');
		
		
		//수정 , 삭제 버튼 안보이게 히든하기 
		$("#updateBtn").hide();
		$("#delBtn").hide();		
		
	}

	// 모달 닫기
	function closeModal() {
		fnSearch();
		$("#myModal").css("display", "none");
	}

	// 닫기 버튼 클릭 시 모달 닫기
	$(".close").click(function() {
		closeModal();
	});

	// 다른 곳을 클릭하면 모달 닫기
	$(window).click(function(event) {
		if (event.target == $("#myModal")[0]) {
			closeModal();
		}
	});
	
	

	
</script>

<script type="text/javascript">
	//상품 등록 버튼 click하면
	$("#registerBtn").click(function() {
		if (confirm("등록하시겠습니까?")) {
			var form = $("#insertContents")[0];
	        var formData = new FormData(form);

	        // 쉼표(,) 제거하는 함수
	        function removeCommas(str) {
	            return str.replace(/,/g, '');
	        }

	        // FormData 내의 값을 순회하며 쉼표(,) 제거 및 필드 유효성 검사
	        for (var pair of formData.entries()) {
	            var key = pair[0];
	            var value = pair[1];

	            if (typeof value === 'string') {
	                var trimmedValue = value.trim();

	                if (trimmedValue === '') {
	                    // 필수 입력 필드가 비어있는 경우 처리
	                    alert("필수 입력 필드를 모두 작성해주세요.");
	                    return; // AJAX 요청 중단
	                }

	                formData.set(key, removeCommas(trimmedValue)); //removeCommas() 호출
	            }
	        }

			$.ajax({
				url : "/admin/insertGoods",
				type : "POST",
				enctype : "multipart/form-data",
				data : formData,
				processData : false,
				contentType : false,
				success : function(response) {
					// 등록 성공 시 처리할 코드 작성
					console.log("insert 등록성공");
					 $("#insertContents")[0].reset(); // 폼 초기화
				},
				error : function(xhr, status, error) {
					// 오류 발생 시 처리할 코드 작성
					console.log("오류 발생:", error);
				}
			});
		}
	});
	
	//상품 수정 버튼 click하면
	$("#updateBtn").click(function() {
    if (confirm("수정하시겠습니까?")) {
        var form = $("#insertContents")[0];
        var formData = new FormData(form);

        console.log(formData);
        var entries = formData.entries();
        console.log(entries.next());
        
        var keys = formData.keys();
        console.log(keys.next()); 
        
        var values = formData.values();
        console.log(values.next());
        
        // 쉼표(,) 제거하는 함수
        function removeCommas(str) {
            return str.replace(/,/g, '');
        }

        // FormData 내의 값을 순회하며 쉼표(,) 제거 및 필드 유효성 검사
        for (var pair of formData.entries()) {
            var key = pair[0];
            var value = pair[1];

            if (typeof value === 'string') {
                var trimmedValue = value.trim();

                if (trimmedValue === '') {
                    // 필수 입력 필드가 비어있는 경우 처리
                    alert("필수 입력 필드를 모두 작성해주세요.");
                    return; // AJAX 요청 중단
                }

                formData.set(key, removeCommas(trimmedValue));
            }
        }

        $.ajax({
            url: "/admin/updateGoods",
            type: "POST",
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                // 등록 성공 시 처리할 코드 작성
                if (response === "success") {
                    console.log("update성공");                       
                }
                else {
                    console.log("update실패");       
                }                   
            },
            error: function(xhr, status, error) {
                // 오류 발생 시 처리할 코드 작성
                console.log("오류 발생:", error);
            }
        });
        closeModal(); //모달 끄기
    }
});
	
	//모달 삭제버튼을 누르면
	$("#delBtn").click(function() {
		 if (confirm("삭제하시겠습니까?")) {
			 var gIdValue = $("#hiddenGId").val();
			 gId = gIdValue.toString();
			 //console.log("g아이디" + gId);
			 
			 $.ajax({
		            url: "/admin/deltGoods",
		            type: "get",
		            data: {	'gId' : gId }, 
		            success: function(response) {
		                // 등록 성공 시 처리할 코드 작성
		                if (response === "success") {
		                    console.log("삭제성공");                       
		                }
		                else {
		                    console.log("삭제실패");       
		                }                   
		            },
		            error: function(xhr, status, error) {
		                // 오류 발생 시 처리할 코드 작성
		                console.log("오류 발생:", error);
		            }
		        });
			 closeModal(); //모달 끄기
		 }
	});

	//G_ID 열에 대한 클릭 이벤트 처리
	$("#mainGrid").on("click", "a.gIdLink", function() {
		
		$("#registerTitle").hide();
		$("#updateTitle").show();
		$("#registerBtn").hide();
		$("#updateBtn").show();
		$("#delBtn").show();		
		
		var gId = $(this).data("gid"); // 클릭한 a 태그의 data-gid 속성 값을 가져오기
		var rowId = $(this).closest("tr").attr("id"); // 클릭한 a 태그가 속한 행의 ID 가져오기
		//var rowData = $("#mainGrid").jqGrid("getRowData", rowId); // 행의 데이터 가져오기  
		var rowObject = $("#mainGrid").jqGrid("getLocalRow", rowId); // 행의 원본 데이터 객체 가져오기

		console.log(rowObject);
		// 모달에 값을 설정하기 위한 코드

		// 모달 필드 값을 초기화
		$("#myModal #gCateCd").val('');
		$("#myModal #gPrice").val('');
		$("#myModal #gName").val('');
		$("#myModal #gQty").val('');
		$("#myModal #gImgText").val('');
		$("#myModal #gImgDtlText").val('');
		$("#myModal #gShowYn").val('');
		$("#myModal #gDelYn").val('');
		
		console.log(rowObject.G_ID);
		
		// gId 값을 동적으로 생성하여 input hidden에 설정		
		var hiddenInput = "<input id='hiddenGId' type='hidden' name='gId' value='" + rowObject.G_ID + "'>";
		$("#myModal form").append(hiddenInput);		
		
		//
		//$("#myModal #gId").val(rowObject.G_ID);
		$("#myModal #gCateCd").val(rowObject.G_CATE_CD);
		$("#myModal #gPrice").val(rowObject.G_PRICE);
		$("#myModal #gName").val(rowObject.G_NAME);
		$("#myModal #gQty").val(rowObject.G_QTY);
		$("#myModal #gImgText").val(rowObject.G_IMG);
		$("#myModal #gImgDtlText").val(rowObject.G_IMG_DTL);
		$("#myModal #gShowYn").val(rowObject.G_SHOW_YN);
		$("#myModal #gDelYn").val(rowObject.G_DEL_YN);
				
		// 모달 표시
		$("#myModal").css("display", "block");
	});
	
	
</script>

<script type="text/javascript">
	function formatPriceInput(obj) {
		// 입력된 값을 숫자 형식으로 변환
		let value = obj.value.replace(/[^\d]/g, '');

		// 1000 자리마다 쉼표(,) 추가
		value = addCommas(value);

		// 변환된 값을 필드에 설정
		obj.value = value;
	}

	function addCommas(str) {
		return str.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	}
</script>
</html>