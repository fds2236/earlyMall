<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원관리</title>

<link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/redmond/jquery-ui.css" type="text/css" />
<!-- jqGrid CSS -->
<link rel="stylesheet" href="//cdn.jsdelivr.net/jqgrid/4.6.0/css/ui.jqgrid.css" type="text/css" />
<!-- The actual JQuery code -->

<style>
	#searchForm, #searchTable {
		display: inline-block;
		vertical-align: middle;
		margin-bottom: 4px;
	}
	
	#searchTable>input {
		height: 18px;
	}
	
	input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button {
		-webkit-appearance: none;
	}
	
	.modalBg {
		display: none;
		width: 100%;
		height: 100%;
		position: fixed;
		top: 0;
		left: 0;
		right: 0;
		background-color: rgba(0, 0, 0, 0.6);
		z-index: 999;
	}
	
	.modalWrap {
		display: none;
		position: absolute;
		top: 50%;
		left: 50%;
		transform: translate(-50%, -50%);
		width: 1000px;
		height: 350px;
		background-color: #fff;
		z-index: 1000;
		padding: 20px;
	}
	
	h1 {
		display: inline-block;
		margin-bottom: 5px;
	}
	
	.btnUpperClose {
		position: fixed;
		top: 38px;
		right: 10px;
		width: 50px;
		height: 30px;
		font-size: 20px;
	}
	
	.infoBox {
		border: 1px solid black;
		padding: 10px;
		margin: 5px;
		/*clear: both;*/
		overflow: hidden;
	}
	
	.oldPassCheckMent {
		color: red;
		display: none;		
	}
	
	.passCheckMent {
		color: red;
	}
	
	.leftInfo {
		float: left;
		width: 50%;		
	}
	
	.rightInfo {
		float: right;
		width: 50%;	
	}
	/*
	.updatePass {
		display: none;
	}*/
	
	.btns {
		float: right;
		margin-right: 5px;
	}
	
	.btnUpdate {
		margin-right: 5px;
	}
	
	.btnClose {
		margin-left: 5px;
	}
	#wrap {
		float:left;
		margin:30px;
		width:1000px;
	}
</style>
</head>
<body>
<jsp:include page="../import/adminFrame.jsp"/>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.10.2.min.js" /></script>
<!-- The JQuery UI code -->
<script type="text/javascript" src="https://code.jquery.com/ui/1.10.3/jquery-ui.min.js" /></script>
<!-- The jqGrid language file code-->
<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/i18n/grid.locale-kr.js" /></script>
<!-- The atual jqGrid code -->
<script type="text/javascript" src="//cdn.jsdelivr.net/jqgrid/4.6.0/jquery.jqGrid.src.js" /></script>

<div id="wrap">
	<div>
		<form id="searchForm">
			<table id="searchTable">
				<tr>
					<td>회원명</td>
					<td><input type="text" id="searchName" name="searchName"></td>
					<td>폰번호</td>
					<td><input type="number" id="searchMobile" name="searchMobile"></td>
					<td>회원타입</td>
					<td><input type="number" id="searchType" name="searchType"></td>
				</tr>
			</table>
			<button type="button" id="btnSearch" onclick="fnSearch();">조회</button>
			<button type="button" id="regMember" onclick="fnInsertPop();">회원등록</button>
		</form>
	</div>
	<table id="memberList"></table>
	<div id="pager"></div>
</div>

<div class="modalBg insertModalBg" onclick="fnInsertClose();"></div>
<div class="modalWrap insertWrap">
	<h1 class="regMent">회원 등록</h1>
	<h1 class="updMent">회원 수정</h1>
	<button class="btnUpperClose" type="button" onclick="fnInsertClose();">X</button>
	<hr/>
	<form id="insertForm">
		<div class="infoBox">
			<input type="hidden" id="rowData" name="rowData">
			<div class="leftInfo">
				<label for="mId" class="labelId">아이디</label><br>
				<input type="text" name="mId" class="mId" onfocus="focusId();">
				<button type="button" class="btnIdCheck">중복확인</button><br>
				<label for="mMobile" class="labelMobile">모바일 번호</label><br>
				<input type="text" name="mMobile" class="mMobile" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" maxlength="11"><br>
				<label for="mAddDefault" class="labelAddDefault">주소</label><br>
				<input type="text" name="mAddDefault" class="mAddDefault">
				<button type="button" class="btnFindAdd" onclick="fnFindAdd();">주소찾기</button><br>
				<label for="mAddDetail" class="labelAddDetail">상세주소</label><br>
				<input type="text" name="mAddDetail" class="mAddDetail"><br>			
			</div>
			<div class="rightInfo">
				<label for="mName" class="labelName">회원명</label><br>
				<input type="text" name="mName" class="mName"><br>
				<div class="insertPass">
					<div class="oldPass">
						<label for="mOldPass" class="labelOldPw">기존 비밀번호</label>
						<span class="oldPassCheckMent">&#42;기존 비밀번호가 일치하지 않습니다.</span><br>
						<input type="password" name="mOldPass" class="mOldPass"><br>
					</div>
					<label for="mPass" class="labelPw">비밀번호</label><br>
					<label for="mPass" class="labelNewPw">새 비밀번호</label><br>
					<input type="password" name="mPass" class="mPass"><br>
					<label for="mPassCheck" class="labelPwCheck">비밀번호 재입력</label>
					<label for="mPassCheck" class="labelNewPwCheck">새 비밀번호 재입력</label>
					<span class="passCheckMent">&#42;비밀번호가 일치하지 않습니다.</span><br>
					<input type="password" name="mPassCheck" class="mPassCheck"><br>	
				</div>
			</div>
		</div>
		<div class="btns">
			<button type="button" class="btnInsert">회원등록</button>
			<button type="button" class="btnUpdate">수정</button>
			<button type="button" class="btnDelete">삭제</button>
			<button type="button" class="btnClose" onclick="fnInsertClose();">닫기</button>
		</div>
	</form>
</div>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
$(document).ready(function() {
	
	setManageTitle("회원관리");
	
	var resultColNames = ['아이디', '비밀번호', '회원명', '폰번호', '주소기본', '주소상세', '삭제여부', '회원타입', '수정일시', '가입일시'];
	var resultColModel = [
		{name: 'mId', index: 'mId', width: 100, align: 'center',
			formatter: function(cellvalue, options, rowObject) {
				var mId = rowObject.mId;
				return '<a href="#" class="mIdLink" data-mid="' + mId + '">' + mId + '</a>';
			}},
		{name: 'mPass', index: 'mPass', width: 100, align: 'center', sortable: false, formatter: behindPass},
		{name: 'mName', index: 'mName', width: 100, align: 'center'},
		{name: 'mMobile', index: 'mMobile', width: 100, align: 'center', sortable: false},
		{name: 'mAddDefault', index: 'mAddDefault', width: 100, align: 'left', sortable: false},
		{name: 'mAddDetail', index: 'mAddDetail', width: 100, align: 'left', sortable: false},
		{name: 'mDelYn', index: 'mDelYn', width: 100, align: 'center'},
		{name: 'mType', index: 'mType', width: 100, align: 'center'},
		{name: 'modifyDt', index: 'modifyDt', width: 100, align: 'center'},
		{name: 'regDt', index: 'regDt', width: 100, align: 'center'}
	];
	
	$("#memberList").jqGrid({
		url: '/admin/getMemberList',
		datatype: 'json',
		mtype: 'get',
		height: 250,
		width: 1020,
		colNames: resultColNames,
		colModel: resultColModel,
		autowidth: true,
		rownumbers: true,
		pager: '#pager',
		rowNum: 10,
		rowList: [10, 20, 30],
		sortname: 'm_id',
		sortorder: 'asc',
		jsonReader: {
			repeatitems: false,
			root: "dataList",
			page: function(obj) {
				return 0;
			},
			total: function(obj) {
				return obj.totalPages;
			},
			records: function(obj) {
				return obj.totalRecords;
			}
		},
		loadonce: true,
		loadComplete: function(data) {
		}
	});
	
});

function fnFindAdd() {
	new daum.Postcode({
           oncomplete: function(data) {
               // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

               // 각 주소의 노출 규칙에 따라 주소를 조합한다.
               // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
               var addr = ''; // 주소 변수
               var extraAddr = ''; // 참고항목 변수

               //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
               if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                   addr = data.roadAddress;
               } else { // 사용자가 지번 주소를 선택했을 경우(J)
                   addr = data.jibunAddress;
               }

               // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
               if(data.userSelectedType === 'R'){
                   // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                   // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                   if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                       extraAddr += data.bname;
                   }
                   // 건물명이 있고, 공동주택일 경우 추가한다.
                   if(data.buildingName !== '' && data.apartment === 'Y'){
                       extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                   }
                   // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                   if(extraAddr !== ''){
                       extraAddr = ' (' + extraAddr + ')';
                   }
                   // 조합된 참고항목을 해당 필드에 넣는다.
                   document.querySelector(".mAddDetail").value = extraAddr;
               
               } else {
                   document.querySelector(".mAddDetail").value = '';
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               // document.getElementById("addr1").value = data.zonecode;
               document.querySelector(".mAddDefault").value = addr;
               // 커서를 상세주소 필드로 이동한다.
               document.querySelector(".mAddDetail").focus();
           }
       }).open({
    	   popupKey: 'popup1'
       });
}

var idCheckFlag = false;
var pwCheckFlag = false;
var updatePwCheck = false;
var originPwCheck = false;

$(function() {	
	
	// 회원 아이디 클릭하여 회원수정
	$("#memberList").on("click", "a.mIdLink", function() {
		
		pwCheckFlag = false;
		originPwCheck = false;
		
		$(".insertWrap").show();
		$(".insertModalBg").show();
		
		$(".regMent").hide();
		$(".updMent").show();
		$(".oldPass").show();
		$(".labelPw").hide();
		$(".labelPw+br").hide();
		$(".labelNewPw").show();
		$(".labelNewPw+br").show();
		$(".labelPwCheck").hide();
		$(".labelNewPwCheck").show();
		$(".btnInsert").hide();
		$(".btnUpdate").show();
		$(".btnDelete").show();
		
		
		var mId = $(this).data("mid");
		var rowId = $(this).closest("tr").attr("id");
		var rowObject = $("#memberList").jqGrid("getRowData", rowId);
		console.log("rowObject: " + JSON.stringify(rowObject));
		console.log("mId: " + mId);
		var mName = rowObject.mName;
		var mMobile = rowObject.mMobile;
		var mPass = rowObject.mPass;
		var mAddDefault = rowObject.mAddDefault;
		var mAddDetail = rowObject.mAddDetail;
		var mDelYn = rowObject.mDelYn;
		var modifyDt = rowObject.modifyDt;
		
		$(".mId").val(mId);
		console.log("input mId: " + $(".mId").val());
		$(".mId").attr("disabled", true);
		$(".mId").attr("readonly", true);
		$(".btnIdCheck").hide();
		$(".mName").val(mName);
		$(".mMobile").val(mMobile);
		$(".mAddDefault").val(mAddDefault);
		$(".mAddDetail").val(mAddDetail);
		$(".mOldPass").val('');
		$(".mPass").val('');
		$(".mPassCheck").val('');
		
		$(".mOldPass").on("keyup", function() {
			if($(".mOldPass").val() != mPass) {
				originPwCheck = false;
				$(".oldPassCheckMent").css("display", "inline");		
				$(".oldPassCheckMent").css("color", "red");		
				$(".oldPassCheckMent").text("*기존 비밀번호가 일치하지 않습니다.");
			} else {
				originPwCheck = true;
				$(".oldPassCheckMent").css("color", "limegreen");		
				$(".oldPassCheckMent").text("기존 비밀번호가 일치합니다.");
			}
		})
		
		
		// 회원수정시	
		// 비밀번호 확인 체크
		$(".mPassCheck").on("keyup", function() {
			if($(".mPass").val() == $(".mPassCheck").val()) {
				pwCheckFlag = true;
				$(".passCheckMent").css("color", "limegreen");
				$(".passCheckMent").text("비밀번호가 일치합니다.");
			} else {
				pwCheckFlag = false;
				$(".passCheckMent").css("color", "red");
				$(".passCheckMent").text("*비밀번호가 일치하지 않습니다.");
			}
		});

		// 비밀번호 확인 체크 후 비밀번호 변경했을 때
		$(".mPass").on("keyup", function() {
			if($(".mPass").val() == $(".mPassCheck").val()) {
				pwCheckFlag = true;
				$(".passCheckMent").css("color", "limegreen");
				$(".passCheckMent").text("비밀번호가 일치합니다.");
			} else {
				pwCheckFlag = false;
				$(".passCheckMent").css("color", "red");
				$(".passCheckMent").text("*비밀번호가 일치하지 않습니다.");
			}
		});
		
		
		// 모바일 번호 조건 체크
		$(".mMobile").on("keyup", function() {
			console.log("내용: " + $(".mMobile").val());
			console.log("하이픈 여부: " + $(".mMobile").val().includes('-'));
			let mobile = $(".mMobile").val();			
			if($(".mMobile").val().includes('-')) {
				mobile = mobile.replace(/\-/g, "");
				$(".mMobile").val(mobile);
				$(".mMobile").focus();
				return;
			}
		});
		
		// 주소 input 클릭하면 주소찾기 api 실행
		$(".mAddDefault").on('click', function() {
			fnFindAdd();
		});
		
		// 주소 input이 비어있지 않으면 readonly로 수정불가 처리
		if($(".mAddDefault").val() != null || $(".mAddDefault").val() != '') {
			$(".mAddDefault").attr("readonly", true);
		}
		
		// 회원수정 유효성 검사
		$(".btnUpdate").off('click').on('click', function(e) {
			e.preventDefault();
			
			if(!$(".mName").val()) {
				alert("회원명을 입력해주세요.");
				$(".mName").focus();
				//e.preventDefault();
				return;
			}
			console.log("회원명: " + $(".mName").val());
			if(!nameCondition($(".mName").val())) {
				alert("회원명은 한글, 영문만 입력할 수 있습니다.");
				$(".mName").focus();
				//e.preventDefault();
				return;
			}
			
			if('' != $(".mMobile").val() || $(".mMobile").val()) {
				if($(".mMobile").val().length < 11) {
					alert("모바일 번호를 정확히 입력해주세요.");
					$(".mMobile").focus();
					//e.preventDefault();
					return;
				}
			}		
			
			if(!$(".mOldPass").val()) {
				alert("기존 비밀번호를 입력해주세요.");
				$(".mOldPass").focus();
				//e.preventDefault();
				return;
			}
			
			if(!originPwCheck) {
				alert("기존 비밀번호가 일치하지 않습니다.");
				$(".mOldPass").focus();
				//e.preventDefault();
				return;
			}
			// 새 비번 입력 안되어있으면 재입력도 안해도 되고 새 비번 입력시 기존 비번도 필수
			
			if($(".mPass").val()) {
				if(!pwCondition($(".mPass").val())) {
					alert("비밀번호는 대소문자 구분없이 영문, 숫자, 특수문자를 최소 1자씩 포함하여 8~15자여야 합니다.");
					$(".mPass").focus();
					//e.preventDefault();
					return;
				}
				
				if(!$(".mPassCheck").val()) {
					alert("새 비밀번호 재입력을 입력해주세요.");
					$(".mPassCheck").focus();
					//e.preventDefault();
					return;
				}
				if(!pwCheckFlag) {
					alert("비밀번호가 일치하지 않습니다.");
					$(".mPassCheck").focus();
					//e.preventDefault();
					return;
				}
			}
			$(".mId").attr("disabled", false);
			console.log("submit!");
			
			$.ajax({
				url: '/member/updateMember',
				type: 'post',
				data: $("#insertForm").serialize(),
				success: function(obj) {
					console.log(obj);
						alert("회원수정이 되었습니다.");
						originPwCheck = false;
						$(".oldPassCheckMent").css("display", "none");
						pwCheckFlag = false;
						$(".passCheckMent").css("color", "red");
						$(".passCheckMent").text("*비밀번호가 일치하지 않습니다.");
						fnSearch();
						fnInsertClose();
				},
				error: function(request, status, error) {
					alert("status: " + request.status + ", message: " + request.responseText + ", error: " + error);
				}
			});
		});
		
		// 회원삭제
		$(".btnDelete").off('click').on("click", function(e) {
			e.preventDefault();
			
			if(!$(".mOldPass").val()) {
				alert("기존 비밀번호를 입력해주세요.");
				$(".mOldPass").focus();
				//e.preventDefault();
				return;
			}
			
			if(!originPwCheck) {
				alert("기존 비밀번호가 일치하지 않습니다.");
				$(".mOldPass").focus();
				//e.preventDefault();
				return;
			}
			
			$.ajax({
				url: '/member/deleteMember',
				type: 'post',
				data: {
					mId: $(".mId").val()
				},
				success: function(obj) {
					console.log(obj);
						alert("회원이 삭제되었습니다.");
						pwCheckFlag = false;
						originPwCheck = false;
						$(".oldPassCheckMent").css("display", "none");
						$(".passCheckMent").css("color", "red");
						$(".passCheckMent").text("*비밀번호가 일치하지 않습니다.");
						fnSearch();
						fnInsertClose();
				},
				error: function(request, status, error) {
					alert("status: " + request.status + ", message: " + request.responseText + ", error: " + error);
				}
			});
		})
		
	});

});	

// 검색
function fnSearch() {
	var searchName = $("#searchName").val();
	var searchMobile = $("#searchMobile").val();
	var searchType = $("#searchType").val();
	
	console.log("setGrid전 searchName: " + searchName + ", searchMobile: " + searchMobile + ", searchType: " + searchType);
	
	$("#memberList").setGridParam({
		postData: {
			'searchName': searchName,
			'searchMobile': searchMobile,
			'searchType': searchType
		},
		loadComplete: function(data) {
			console.log("searchName: " + searchName + ", searchMobile: " + searchMobile + ", searchType: " + searchType);
			console.log(data.dataList);
			$(".ui-state-default.jqgrid-rownum").removeClass('ui-state-default jqgrid-rownum');
               $("#memberList_nodata").remove();
               if(data && data.dataList && data.dataList.length === 0) {
                  $("#memberList.ui-jqgrid-btable").after("<p id='memberList_nodata' style='margin-top: 15px; text-align: center; font-weight:bold;'>검색된 자료가 없습니다</p>");
               }

		},
		gridComplete: function() {
			
		}
	}).trigger("reloadGrid");
	
	$("#memberList").jqGrid('setGridParam', {
		url: '/admin/getMemberList',
		mtype: 'get',
		datatype: 'json'
	}).trigger("reloadGrid");
}

// 회원 비밀번호 별표 표시
function behindPass(cellValue, options, rowObject) {
	var stars = "";
	for(var i=0; i < rowObject.mPass.length; i++) {
		stars += "*";
	}
	
	return stars;
}

// 회원등록 팝업
function fnInsertPop() {
	
	var idCheckFlag = false;
	var pwCheckFlag = false;
	
	$(".insertWrap").show();
	$(".insertModalBg").show();
	$(".regMent").show();
	$(".updMent").hide();
	$(".oldPass").hide();
	$(".labelPw").show();
	$(".labelPw+br").show();
	$(".labelNewPw").hide();
	$(".labelNewPw+br").hide();
	$(".labelPwCheck").show();
	$(".labelNewPwCheck").hide();
	$(".btnInsert").show();
	$(".btnUpdate").hide();
	$(".btnDelete").hide();
	

	$(".mId").attr("disabled", false);
	$(".mId").attr("readonly", false);
	$(".btnIdCheck").show();
	
	$(".mId").val('');
	$(".mName").val('');
	$(".mMobile").val('');
	$(".mPass").val('');
	$(".mPassCheck").val('');
	$(".mAddDefault").val('');
	$(".mAddDetail").val('');
	
	

	// 아이디 중복확인 체크
	$(".btnIdCheck").on('click', function() {
		if($(".mId").val().length < 3 || $(".mId").val().length > 20 || !idCondition($(".mId").val())) {
			alert("아이디는 영문 대소문자 또는 숫자 3~20자여야 합니다.(공백 입력불가)");
			$(".mId").focus();
			return;
		} else {
			$.ajax({
				url: '/member/idCheck',
				type: 'post',
				data: $("#insertForm").serialize(),
				success: function(obj) {
					console.log(obj);
					
					if(obj == 'duplicatedId') {
						idCheckFlag = false;
						alert("중복된 아이디입니다.");
						$(".mId").focus();
					} else {
						if(confirm("사용 가능한 아이디입니다. 사용하시겠습니까?")) {
							idCheckFlag = true;
							$(".btnIdCheck").attr("disabled", true);
						
						}
					}
					
				},
				error: function(e) {
					console.log(e);
				}
			});
		}
		
	});
	
	
	// 비밀번호 확인 체크
	$(".mPassCheck").on("keyup", function() {
		if($(".mPass").val() == $(".mPassCheck").val()) {
			pwCheckFlag = true;
			$(".passCheckMent").css("color", "limegreen");
			$(".passCheckMent").text("비밀번호가 일치합니다.");
		} else {
			pwCheckFlag = false;
			$(".passCheckMent").css("color", "red");
			$(".passCheckMent").text("*비밀번호가 일치하지 않습니다.");
		}
	});

	// 비밀번호 확인 체크 후 비밀번호 변경했을 때
	$(".mPass").on("keyup", function() {
		if($(".mPass").val() == $(".mPassCheck").val()) {
			pwCheckFlag = true;
			$(".passCheckMent").css("color", "limegreen");
			$(".passCheckMent").text("비밀번호가 일치합니다.");
		} else {
			pwCheckFlag = false;
			$(".passCheckMent").css("color", "red");
			$(".passCheckMent").text("*비밀번호가 일치하지 않습니다.");
		}
	});
	
	
	// 모바일 번호 조건 체크
	$(".mMobile").on("keyup", function() {
		console.log("내용: " + $(".mMobile").val());
		console.log("하이픈 여부: " + $(".mMobile").val().includes('-'));
		let mobile = $(".mMobile").val();			
		if($(".mMobile").val().includes('-')) {
			mobile = mobile.replace(/\-/g, "");
			$(".mMobile").val(mobile);
			$(".mMobile").focus();
			return;
		}
	});

	// 주소 input 클릭하면 주소찾기 api 실행
	$(".mAddDefault").on('click', function() {
		fnFindAdd();
	});
	
	// 주소 input이 비어있지 않으면 readonly로 수정불가 처리
	if($(".mAddDefault").val() != null || $(".mAddDefault").val() != '') {
		$(".mAddDefault").attr("readonly", true);
	}
	
	
	// 회원등록 유효성 검사
	$(".btnInsert").off('click').on('click', function(e) {
		e.preventDefault();
		
		if(!$(".mId").val()) {				
			alert("아이디를 입력해주세요.");
			$(".mId").focus();
			//e.preventDefault();
			return;
		}
		
		if(!idCheckFlag) {
			alert("아이디 중복확인을 해주세요.");
			//e.preventDefault();
			return;
		}
		
		if(!$(".mName").val()) {
			alert("회원명을 입력해주세요.");
			$(".mName").focus();
			//e.preventDefault();
			return;
		}
		console.log("회원명: " + $(".mName").val());
		if(!nameCondition($(".mName").val())) {
			alert("회원명은 한글, 영문만 입력할 수 있습니다.");
			$(".mName").focus();
			//e.preventDefault();
			return;
		}
		
		if('' != $(".mMobile").val() || $(".mMobile").val()) {
			if($(".mMobile").val().length < 11) {
				alert("모바일 번호를 정확히 입력해주세요.");
				$(".mMobile").focus();
				//e.preventDefault();
				return;
			}
		}		
		
		if(!$(".mPass").val()) {
			alert("비밀번호를 입력해주세요.");
			$(".mPass").focus();
			//e.preventDefault();
			return;
		}
		
		if(!pwCondition($(".mPass").val())) {
			alert("비밀번호는 대소문자 구분없이 영문, 숫자, 특수문자를 최소 1자씩 포함하여 8~15자여야 합니다.");
			$(".mPass").focus();
			//e.preventDefault();
			return;
		}
		
		if(!$(".mPassCheck").val()) {
			alert("비밀번호 재입력을 입력해주세요.");
			$(".mPassCheck").focus();
			//e.preventDefault();
			return;
		}
		
		if(!pwCheckFlag) {
			alert("비밀번호가 일치하지 않습니다.");
			$(".mPassCheck").focus();
			//e.preventDefault();
			return;
		}
		
		console.log("submit!");
		
		$.ajax({
			url: '/member/joinFromAdmin',
			type: 'post',
			data: $("#insertForm").serialize(),
			success: function(obj) {
				console.log(obj);
				alert("회원등록이 되었습니다.");
				pwCheckFlag = false;
				originPwCheck = false;
				$(".oldPassCheckMent").css("display", "none");
				$(".passCheckMent").css("color", "red");
				$(".passCheckMent").text("*비밀번호가 일치하지 않습니다.");
				fnSearch();
				fnInsertClose();
			},
			error: function(e) {
				console.log(e);
			}
		});
	});
	
}

// 팝업창 닫기
function fnInsertClose() {
	$(".insertWrap").hide();
	$(".insertModalBg").hide();
}

//아이디 중복확인 후 아이디 input 창에 다시 focus 했을 때
function focusId() {
	idCheckFlag = false;
	$(".btnIdCheck").attr("disabled", false);
}

//아이디 조건(영문 대소문자 또는 숫자)
function idCondition(mId) {
	const condition = /^[a-zA-Z0-9]*$/;
	return condition.test(mId);
}

// (?=.*?[A-Z])
// 비밀번호 조건(대소문자 구분없이 영문, 숫자, 특수문자 최소 1자리씩)
function pwCondition(mPass) {
	const condition = /^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[#?!@$~ %^&*`+-]).{8,15}$/;
	return condition.test(mPass);
}

// 회원명 조건(한글, 영문)
function nameCondition(mName) {
	const condition = /^[가-힣a-zA-Z]+$/;
	return condition.test(mName);
}
</script>
</html>