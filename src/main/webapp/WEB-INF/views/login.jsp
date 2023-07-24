<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>�α���</title>
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
<input type="text" id="mId" placeholder="���̵� �Է��ϼ���"/>
<div><input type="password" id="mPass" placeholder="��й�ȣ�� �Է��ϼ���"/></div>
<div><button id="loginButton" onclick="javascript:login();">�α���</button></div>
<div><button id="joinButton" onclick="javascript:join();">ȸ������</button></div>
<div><button id="exitBtn" onclick="window.location.href='/'">���</button></div>
<div><button id="kakao-login-btn">īī���� �α���</button></div>
</div>
</body>

<script type="text/javascript">
// SDK �ʱ�ȭ
Kakao.init('b5a13d824ec2a2d1b0995927249c3839'); // eansoft JavaScript Ű
Kakao.isInitialized();
console.log(Kakao.isInitialized()); // true ������ �ʱ�ȭ ����� �� ��

function handleKakaoLoginSuccess(kakaoId, kakaoNickname, kakaoProfileImage) {
    console.log('�θ� â���� �ݹ� ó��:', kakaoId, kakaoNickname, kakaoProfileImage);
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
	          console.log('��Ž���!!');
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
		alert("ȸ�����ԵǾ����ϴ�.");
	}
});

function join() {
	window.location.href='/member/joinMember';
}

document.getElementById('kakao-login-btn').addEventListener('click', function() {
    // īī���� ���� => ���� �α��� ��û
    // ���� �����ϰ� ����ϱ� ��ư���� ����
    // ������ Redirect URI�� �ΰ��ڵ带 ����
    Kakao.Auth.authorize({
      success: function(authObj) {
        // �α��� ���� �� ����� ���� ��û
        Kakao.API.request({
          url: '/v2/user/me',
          success: function(response) {
            // ����� ������ Ȱ���Ͽ� �ʿ��� ó�� ����
            var kakaoId = response.id; // īī�� ����� ID
            var kakaoNickname = response.properties.nickname; // īī�� �г���
            var kakaoProfileImage = response.properties.profile_image; // īī�� ������ �̹��� URL ������ ����

            // ������ ����� ���� ���� �� �ʿ��� ���� ó��
            console.log('īī�� �α��� ����');
            console.log('����� ID:', kakaoId);
            console.log('�г���:', kakaoNickname);
            console.log('������ �̹���:', kakaoProfileImage);
            if (window.opener && !window.opener.closed && window.opener.handleKakaoLoginSuccess) {
            	  window.opener.handleKakaoLoginSuccess(kakaoId, kakaoNickname, kakaoProfileImage);
            	  window.close();
            	} else {
            	  handleKakaoLoginSuccess(kakaoId, kakaoNickname, kakaoProfileImage);
            	}

          },
          fail: function(error) {
            console.log('����� ���� ��û ����:', error);
          }
        });
      },
      fail: function(error) {
        console.log('īī�� �α��� ����:', error);
      }
    });
  });







</script>

</html>