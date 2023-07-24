<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<div id="admin_header" class="frame_top">
	<button id="home_btn" onClick="window.location.href='/'">홈으로</button>
	<button id="logOut_btn">로그아웃</button>
	<div class="titleDiv">
		<h2 class="title" id="manageTitle" ></h2>
	</div>
</div>
<div id="admin_cate_frame" class="frame_cate">
	<div id="admin_cate"></div>
</div>



<style>
.frame_top {
	width : 100%;
	height : 50px;
	background-color:#b5f3c9;
}
#logOut_btn, #home_btn{
	float : right;
	margin : 10px;
}
.frame_cate {
	width : 150px;
	min-height : 700px;
	background-color:lightGray;
}
#admin_cate {
	width : 145px;
	height : 300px;
}
.cate_list {
	padding : 10px;
	cursor : pointer;
}
.frame_top, .frame_cate {
	float : left;
}
.title {
	margin: 7px;
}

</style>

<script type="text/javascript">
$(document).ready(function() {
	setCate();
	
	$("#logOut_btn").click(function() {
		logOut();
	});
	
});

$(document).on("click", ".cate_list", function(e) {
	movePage($(e.target).data("id"));
});

function setCate() {
	
	$.ajax({
		method: "GET",
	    url: "/admin-cate",
	    data: {},
	    success: function(data) {
	    	if(data.result == "SUCCESS") {
	    		setCateDiv(data.cateList);
	    	}
        },
	    error: function() {
	          console.log('통신실패!!');
        }
	});
}

function setCateDiv(list) {
	var html = "";
	for(var i = 0; i < list.length; i++) {
		html += "<div data-id='" + list[i].DID + "'class='cate_list'>" + list[i].DNAME + "</div>";
	}
	$("#admin_cate").append(html);
}

function movePage(cateId) {
	var url = "";
	switch(cateId) {
		case "00" : url = "/admin/dash"; break;
		case 10 : url = "/admin/memberList"; break;
		case 20 : url = "/admin/goodsManage"; break;
		case 30 : url = "/admin/eventManage"; break;
		case 40 : url = "/admin/orderManage"; break;
		case 50 : url = "/admin/common"; break;
	}
	window.location.href=url;
}

function logOut() {
	$.ajax({
		method: "POST",
	    url: "/auth/logout",
	    data: {},
	    success: function(data) {
	    	if(data.result == "SUCCESS") {
	    		alert(data.message);
	    		window.location.href='/'
	    	}
        },
	    error: function() {
	          console.log('통신실패!!');
        }
	});
}

function setManageTitle(title) {
	$("#manageTitle").html(title);
}
</script>


</html>