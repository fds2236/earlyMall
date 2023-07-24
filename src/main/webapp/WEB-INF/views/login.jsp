<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>로그인</title>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.min.js"></script>
<style>
#login_container{
	margin-top:13%;
	text-align:center;
	width: 100%;
	height:300px;
}

#mId, #mPass{
	margin : 10px;
	width : 320px;
	height : 35px;
	background-color : white;
	border-radius : 5px;
	border: solid 1.5px rgb(68, 114, 196);
	text-align: center;
	font-size: 12px;
	&:hover {
	   font-weight: 600;  
	} 
	&:focus {
	    font-weight: 600;
	     color: black;
	     border: solid 1.5px rgb(68, 114, 196);
	     opacity: 0.8;    
	}
}

#loginButton, #joinButton, #exitBtn {
	margin : 10px;
    width : 330px;
    height: 40px;
    color : white;
    opacity: 0.5;
    background-color: rgb(68, 114, 196);
    border-radius: 5px;
    border: none;
    &:hover {
        border: none;
        opacity: 0.8;      
    }  
}
</style>
</head>
<body>
<div id="login_container">
<input type="text" id="mId" placeholder="아이디를 입력하세요"/>
<div><input type="password" id="mPass" placeholder="비밀번호를 입력하세요"/></div>
<div><button id="loginButton" onclick="javascript:login();">로그인</button></div>
<div><button id="joinButton" onclick="javascript:join();">회원가입</button></div>
<div><button id="exitBtn" onclick="window.location.href='/'">취소</button></div>
<div><button id="kakao-login-btn">카카오로 로그인</button></div>
</div>
</body>

<script type="text/javascript">
// SDK 초기화
Kakao.init('b5a13d824ec2a2d1b0995927249c3839'); // eansoft JavaScript 키
Kakao.isInitialized();
console.log(Kakao.isInitialized()); // true 나오면 초기화 제대로 된 것

function handleKakaoLoginSuccess(kakaoId, kakaoNickname, kakaoProfileImage) {
    console.log('부모 창에서 콜백 처리:', kakaoId, kakaoNickname, kakaoProfileImage);
    window.location.href = '/';
  }

function login() {
	$.ajax({
		method: "POST",
	    url: "/auth/login",
	    data: { 
	    	mId : $("#mId").val(),
	    	mPass : $("#mPass").val()
	    },
	    success: function(data) {
	    	if(data.result == "SUCCESS") {
	    		window.location.href='/'
	    	} else {
	    		alert(data.message);
	    	}
        },
	    error: function() {
	          console.log('통신실패!!');
        }
	})
	
}

$(document).ready(function() {
    $(document).keydown(function(event) {
        if (event.keyCode === 13) {
            login(); 
        }
    });
    
    var joinMsg = "${joinMsg}";
	if(joinMsg === "joinSuccess") {
		alert("회원가입되었습니다.");
	}
});

function join() {
	window.location.href='/member/joinMember';
}

document.getElementById('kakao-login-btn').addEventListener('click', function() {
    // 카카오톡 실행 => 간편 로그인 요청
    // 현재 동의하고 계속하기 버튼까지 나옴
    // 지정된 Redirect URI로 인가코드를 전달
    Kakao.Auth.authorize({
      success: function(authObj) {
        // 로그인 성공 시 사용자 정보 요청
        Kakao.API.request({
          url: '/v2/user/me',
          success: function(response) {
            // 사용자 정보를 활용하여 필요한 처리 수행
            var kakaoId = response.id; // 카카오 사용자 ID
            var kakaoNickname = response.properties.nickname; // 카카오 닉네임
            var kakaoProfileImage = response.properties.profile_image; // 카카오 프로필 이미지 URL 가지고 오기

            // 서버로 사용자 정보 전송 등 필요한 로직 처리
            console.log('카카오 로그인 성공');
            console.log('사용자 ID:', kakaoId);
            console.log('닉네임:', kakaoNickname);
            console.log('프로필 이미지:', kakaoProfileImage);
            if (window.opener && !window.opener.closed && window.opener.handleKakaoLoginSuccess) {
            	  window.opener.handleKakaoLoginSuccess(kakaoId, kakaoNickname, kakaoProfileImage);
            	  window.close();
            	} else {
            	  handleKakaoLoginSuccess(kakaoId, kakaoNickname, kakaoProfileImage);
            	}

          },
          fail: function(error) {
            console.log('사용자 정보 요청 실패:', error);
          }
        });
      },
      fail: function(error) {
        console.log('카카오 로그인 실패:', error);
      }
    });
  });







</script>

</html>