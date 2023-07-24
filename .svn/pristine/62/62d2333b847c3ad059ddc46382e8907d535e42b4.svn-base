<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style>
	.container {
		width: 1020px;
		text-align: center;
		margin: 0 auto;
	}
	
	h1 {
		display: inline-block;
		margin-bottom: 5px;
	}
	
	.infoBox {
		border: 1px solid black;
		padding: 10px 10px 10px 100px;
		text-align: left;
		margin: auto;
		width: 410px;
	}
	
	input[type="number"]::-webkit-outer-spin-button, input[type="number"]::-webkit-inner-spin-button {
		-webkit-appearance: none;
	}
	
	.passCheckMent {
		color: red;
	}
	
	.btnJoin {
		width: 522px;
		margin-top: 10px;
		height: 40px;
		font-size: 1.3em;
	}
</style>
</head>
<body>
<div class="container">
	<h1>회원 가입</h1>
	<form id="joinForm" action="/member/joinMember" method="post">
		<input type="hidden" id="joinMsg" value="${joinMsg }">
		<div class="infoBox">
			<label for="mId" class="labelId">아이디</label><br>
			<input type="text" name="mId" id="mId" onfocus="focusId();">
			<button type="button" class="btnIdCheck">중복확인</button><br>
			<label for="mName" class="labelName">회원명</label><br>
			<input type="text" name="mName" id="mName"><br>
			<label for="mPass" class="labelPw">비밀번호</label><br>
			<input type="password" name="mPass" id="mPass"><br>
			<label for="mPassCheck" class="labelPwCheck">비밀번호 재입력</label>
			<span class="passCheckMent">&#42;비밀번호가 일치하지 않습니다.</span><br>
			<input type="password" name="mPassCheck" id="mPassCheck"><br>
			<label for="mMobile" class="labelMobile">모바일 번호</label><br>
			<input type="text" name="mMobile" id="mMobile" onKeyup="this.value=this.value.replace(/[^-0-9]/g,'');" maxlength="11"><br>
			<label for="mAddDefault" class="labelAddDefault">주소</label><br>
			<input type="text" name="mAddDefault" id="mAddDefault">
			<button type="button" class="btnFindAdd" onclick="fnFindAdd();">주소찾기</button><br>
			<label for="mAddDetail" class="labelAddDetail">상세주소</label><br>
			<input type="text" name="mAddDetail" id="mAddDetail">		
		</div>
		<button type="submit" class="btnJoin">회원가입</button>
	</form>
</div>
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
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
                   document.getElementById("mAddDetail").value = extraAddr;
               
               } else {
                   document.getElementById("mAddDetail").value = '';
               }

               // 우편번호와 주소 정보를 해당 필드에 넣는다.
               // document.getElementById("addr1").value = data.zonecode;
               document.getElementById("mAddDefault").value = addr;
               // 커서를 상세주소 필드로 이동한다.
               document.getElementById("mAddDetail").focus();
           }
       }).open();
}
</script>
<script>
var idCheckFlag = false;
var pwCheckFlag = false;

$(function() {	

    var joinMsg = "${joinMsg}";
	if(joinMsg === "joinFail") {
		alert("회원가입에 실패하였습니다.");
	}

	// 아이디 중복확인 체크
	$(".btnIdCheck").on('click', function() {
		if($("#mId").val().length < 3 || $("#mId").val().length > 20 || !idCondition($("#mId").val())) {
			alert("아이디는 영문 대소문자 또는 숫자 3~20자여야 합니다.(공백 입력불가)");
			$("#mId").focus();
			return;
		} else {
			$.ajax({
				url: '/member/idCheck',
				type: 'post',
				data: $("#joinForm").serialize(),
				success: function(obj) {
					console.log(obj);
					
					if(obj == 'duplicatedId') {
						alert("중복된 아이디입니다.");
						$("#mId").focus();
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
	$("#mPassCheck").on("keyup", function() {
		if($("#mPass").val() == $("#mPassCheck").val()) {
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
	$("#mPass").on("keyup", function() {
		if($("#mPass").val() == $("#mPassCheck").val()) {
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
	$("#mMobile").on("keyup", function() {
		console.log("내용: " + $("#mMobile").val());
		console.log("하이픈 여부: " + $("#mMobile").val().includes('-'));
		let mobile = $("#mMobile").val();			
		if($("#mMobile").val().includes('-')) {
			mobile = mobile.replace(/\-/g, "");
			$("#mMobile").val(mobile);
			$("#mMobile").focus();
			return;
		}
		/*
		if($("#mMobile").val().length > 11) {
			mobile = mobile.substring(0, 11);
			$("#mMobile").val(mobile);
			alert("모바일 번호를 정확히 입력해주세요.");
			$("#mMobile").focus();
			return;
		}*/
	});

	// 주소 input 클릭하면 주소찾기 api 실행
	$("#mAddDefault").on('click', function() {
		fnFindAdd();
	});
	
	// 주소 input이 비어있지 않으면 readonly로 수정불가 처리
	if($("#mAddDefault").val() != null || $("#mAddDefault").val() != '') {
		$("#mAddDefault").attr("readonly", true);
	}
	
	
	// 유효성 검사
	$("#joinForm").on('submit', function(e) {
		
		if(!$("#mId").val()) {				
			alert("아이디를 입력해주세요.");
			$("#mId").focus();
			e.preventDefault();
			return;
		}
		
		if(!idCheckFlag) {
			alert("아이디 중복확인을 해주세요.");
			e.preventDefault();
			return;
		}
		
		if(!$("#mName").val()) {
			alert("회원명을 입력해주세요.");
			$("#mName").focus();
			e.preventDefault();
			return;
		}
		console.log("회원명: " + $("#mName").val());
		if(!nameCondition($("#mName").val())) {
			alert("회원명은 한글, 영문만 입력할 수 있습니다.");
			$("#mName").focus();
			e.preventDefault();
			return;
		}
		
		/*
		if(!$("#mMobile").val()) {
			alert("모바일 번호를 입력해주세요.");
			$("#mMobile").focus();
			return;
		}*/
		
		if('' != $("#mMobile").val() || $("#mMobile").val()) {
			if($("#mMobile").val().length < 11) {
				alert("모바일 번호를 정확히 입력해주세요.");
				$("#mMobile").focus();
				e.preventDefault();
				return;
			}
		}		
		
		if(!$("#mPass").val()) {
			alert("비밀번호를 입력해주세요.");
			$("#mPass").focus();
			e.preventDefault();
			return;
		}
		
		if(!pwCondition($("#mPass").val())) {
			alert("비밀번호는 대소문자 구분없이 영문, 숫자, 특수문자를 최소 1자씩 포함하여 8~15자여야 합니다.");
			$("#mPass").focus();
			e.preventDefault();
			return;
		}
		/*
		if(!$("#mAddDefault").val()) {
			alert("주소를 입력해주세요.");
			return;
		}*/
		
		if(!$("#mPassCheck").val()) {
			alert("비밀번호 재입력을 입력해주세요.");
			$("#mPassCheck").focus();
			e.preventDefault();
			return;
		}
		
		if(!pwCheckFlag) {
			alert("비밀번호가 일치하지 않습니다.");
			$("#mPassCheck").focus();
			e.preventDefault();
			return;
		}
		
	});
	
	
});	
// 아이디 중복확인 후 아이디 input 창에 다시 focus 했을 때
function focusId() {
	idCheckFlag = false;
	$(".btnIdCheck").attr("disabled", false);
}

// 아이디 조건(영문 대소문자 또는 숫자)
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