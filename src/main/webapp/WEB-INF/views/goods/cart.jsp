<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<style>
.sort_container {
	width: 1100px;
	margin: 0px auto;
}

.cart_container {
	padding: 10px;
	margin: 0px auto;
	/* 	border: 2px solid rgb(91, 155, 213); */
}

.cart_item {
	padding: 10px;
	margin: 10px auto;
	display: flex;
	flex-direction: row;
	border: 2px solid rgb(91, 155, 213);
	height: 150px;
}

.cart_img {
	width: 15%;
	margin: 10px;
	border: 2px solid rgb(91, 155, 213);
	position: relative;
}

.lowStock {
	color: white;
	background-color: rgba(128, 128, 128, 0.7);
}

.cart_info {
	margin: 10px;
	width: 75%;
}

.cart_function {
	width: 10%;
	margin: auto 0;
	height: 130px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.sortBtn {
	margin: 5px;
	width: 100px;
	height: 25px;
	border: rgb(0, 112, 192);
	border-radius: 5px;
	background-color: rgb(68, 114, 196);
	color: white;
	cursor: pointer
}

.saveBtn {
	margin: auto 0;
	display: none;
	width: 85px;
	margin: auto 0;
	height: 30px;
	border: rgb(0, 112, 192);
	border-radius: 5px;
	background-color: rgb(68, 114, 196);
	color: white;
	cursor: pointer
}

.functionBtn, .orderBtn {
	font-size: 13px;
	margin: auto 0;
	width: 85px;
	height: 30px;
	border: rgb(0, 112, 192);
	border-radius: 5px;
	background-color: rgb(68, 114, 196);
	color: white;
	cursor: pointer;
}

.soldOutBtn {
	font-size: 13px;
	margin: auto 0;
	width: 85px;
	height: 30px;
	border: rgb(0, 112, 192);
	border-radius: 5px;
	background-color: grey;
	color: white;
}

.thumbImg {
	width: 100%;
 	height: 100%; 
 	cursor: pointer; 
}

#topBtn {
	position: fixed;
	bottom: 20px;
	right: 20px;
	display: none;
	width: 50px;
	height: 50px;
	background-color: rgb(38, 38, 38);
	color: white;
	border-radius: 50%;
	border: none;
	cursor: pointer;
}

.lowStock {
	position: absolute;
	top: 101px;
	background-color: rgba(0, 0, 0, 0.7);
	color: white;
	margin: 0;
	font-size: 14px;
	display: flex;
	align-items: center;
	justify-content: center;
	width: 100%;
	height: 20%;
}

.nonStock {
	background-color: rgba(0, 0, 0, 0.7);
	color: white;
	margin: 0;
	font-size: 14px;
	display: flex;
	align-items: center;
	justify-content: center;
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

.container {
	width: 70%;
	margin: 60px 15%;
}
</style>

</head>
<body>

	<jsp:include page="../import/mainFrame.jsp" />

	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

	<div class="container">
		<div class="sort_container">
			<button class="sortBtn" value="lowPrice">낮은가격순</button>
			<button class="sortBtn" value="highPrice">높은가격순</button>
			<button class="sortBtn" value="latestReg">최신순</button>
		</div>
		<div class="cart_container"></div>
		<button id="topBtn" onclick="scrollToTop()">Top</button>
	</div>
	<script>
var mId = "${memberInfo.mId}";
var sortType = "latestReg";
var currPage = 1;
var totalPages; // 전체 데이터 페이지 수를 저장하는 변수
var isReset = false; // sort이랑 개별 삭제때문에 쓰는데 이거 이렇게 써도 될까..?
var modYn = false;

if (!mId) {
	  alert("잘못된 접근입니다. 로그인 후 이용하시기바랍니다.");
	  window.location.href = "/login";
	}	

$(document).ready(function() {
    basketList(mId);
});

//무한 스크롤 이벤트 처리
$(window).scroll(function() {
    if ($(window).scrollTop() + $(window).height() >= $(document).height()) {
    	// 현재 페이지가 데이터 페이지보다 작을 때만 추가 데이터를 가져옴
    	if (currPage < totalPages) { 
            currPage++;
            basketList(mId);
          }
    }
});

// 정렬버튼 클릭
$('.sortBtn').click(function(){
	sortType = $(this).val();
	currPage = 1;
	isReset = true;
	chkMod();
	if(modYn == true) {
		var result = confirm("수정 사항을 저장하시겠습니까?");
		if(result) {
			saveAll();
		} else {
			basketList(mId);
		}
	} else {
		basketList(mId);
	}	
})

// 데이터 조회
function basketList(mId) {
	  console.log("-------------------");
	  console.log("|조회시작");
	  console.log("|sortType: " + sortType);
	  console.log("|currPage: " + currPage);
	$.ajax({
// 		url: "/goods/basketList",
		url: "/goods/basketList/"+mId+ "/" +sortType+ "/" +currPage,
		type: "GET",
// 		data: {
// 			mId: mId,
// 	        sortType: sortType,
// 			page: currPage
// 		},
		success: function(data) {
			 console.log("|조회끝");
	    	  var dataList = data.dataList;
	    	  totalPages = data.totalPages; // 전체 데이터 페이지 수 업데이트
	    	  console.log("|totalPages: " + totalPages);
	    	  var addHtml = "";
	    	  if (dataList.length === 0) {
	    		  addHtml = "<p>장바구니에 담긴 상품이 없습니다.</p>";
	    		} else {
		    	  for (var i = 0; i < dataList.length; i++) {
		    		  var item = dataList[i];
					  var lowStock = item.G_QTY >= 1 && item.G_QTY < 5 ? "잔여 수량 : " + item.G_QTY : "";
					  var nonStock = item.G_QTY === 0 ?  "품절" : "";
					  var soldOrOrder = nonStock ? 'soldOutBtn' : 'orderBtn';
					  var displayStyle = item.G_QTY < 5 ? "" : "display: none;";
					  var qty = item.B_QTY > item.G_QTY ? item.G_QTY : item.B_QTY;
					  addHtml += "<div class='cart_item' id='item_" + item.G_ID + "'>" +
								  '<div class="cart_img">' +
								  '<img class="thumbImg" src="' + item.G_IMG + '"/>' +
									((lowStock !== "") ? '<p class="lowStock" style="' + displayStyle + '">' + lowStock + '</p>' : '') +
									((nonStock !== "") ? '<p class="nonStock" style="' + displayStyle + '">' + nonStock + '</p>' : '') +
								  '</div>' +
								  "<div class='cart_info'>" +
								  "<p>상품명: " + item.G_NAME + "</p>";
								  var G_PRICE = item.G_PRICE.toLocaleString();
								  if(item.EG_PRICE) {
									  var EG_PRICE = item.EG_PRICE.toLocaleString();
									  addHtml += '<p><del>' + G_PRICE + '원</del> <span style="font-weight: bold; color: red;">' + EG_PRICE + '원</span></p>';
								  } else {
									  addHtml += "<p>가격: " + G_PRICE + "원</p>";
								  }
								  addHtml += "<div>" +
											  '<button onClick="calQty(\'' + item.G_ID + '\',\'minus\')">-</button>' +
											  "수량: " + "<span id='" + item.G_ID + "_qty' data-firstqty='" + qty + "' data-modyn='N'>" + qty + "</span>" +
											  '<button onClick="calQty(\'' + item.G_ID + '\', \'plus\', ' + item.G_QTY + ')">+</button>' + 
											  "</div>" +
											  "</div>" +
											  "<div class='cart_function'>" +
											  '<button class="' + soldOrOrder + '">' + (nonStock ? '주문불가' : '주문하기') + '</button>' +
											  "<button class='functionBtn' onClick='deleteOne(" + item.G_ID + ");'>삭제하기</button>" +
											  "<button class='functionBtn' onClick='deleteAll();'>전체삭제</button>" +
											  "<button class='saveBtn' id='saveBtn_" + item.G_ID + "'>저장</button>" +
											  "</div>" +
											  "</div>";
		    	  }
	    	  }
	    	  console.log("|isReset: " + isReset);
	    	  console.log("-------------------");    	 	 
	    	  if(isReset){
	    		  $(".cart_container").empty().append(addHtml);
	    		  isReset = false;
	    	  } else {
	    		  $(".cart_container").append(addHtml);
	    	  }
		}
	});
}

// 수량 변경
function calQty(gid, cal, stock) {
	console.log("잔여 재고 : " + stock)
	var qty = $("#" + gid + "_qty").html();
	if(cal == "minus") {
		if(Number(qty) > 1) {
			qty = Number(qty)-1;
		}
	} else {
		// plus버튼 눌렀을 때
		if(Number(qty) < stock) {
			qty = Number(qty) + 1;	
		} else if(Number(qty) == stock){
			alert("최대 주문 가능한 수량은 " + stock + "개입니다.");
		} else {
			alert("현재 재고가 없는 상품입니다.");
		}
	}
	$("#" + gid + "_qty").html(qty);
	// 변경 데이터 확인
	var firstqty = $("#" + gid + "_qty").data("firstqty");
	console.log("qty: " + Number(qty) + ",firstqty: " + Number(firstqty));
	if(Number(qty) != Number(firstqty)) {		
		$("#" + gid + "_qty").data("modyn", "Y"); // modyn의 값을 Y로 변경
//		var modynValue = $("#" + gid + "_qty").data("modyn");
// 		console.log(modynValue); // console찍으면 분명히 변한 것이 확인 됨!	
		$("#saveBtn_" + gid).show(); // 변경점이 있을 떄 버튼 보여주기
	} else {
		$("#" + gid + "_qty").data("modyn", "N");
		$("#saveBtn_" + gid).hide();
	}	
}

// 체크 모드
function chkMod() {
	modYn = false;
	var modList = $("span[id$='_qty']");
	var modY = 0;
	$.each(modList, function(i, v){
		if("Y" == $(v).data("modyn")){
			modY++;
		}
	});	
	if(modY > 0) {
		modYn = true;
	}
}

var saveList = [];
// 저장버튼 클릭 => saveAction 함수 호출하기
$(".cart_container").on('click', '.saveBtn', function(){
	saveList = [];
	var gId = $(this).closest('.cart_item').attr('id').substring(5);
	var bQty = $("span[id='" + gId + "_qty']").html();
	var data = {"mId":mId, "gId": gId,"bQty":bQty};
	saveList.push(data);
	console.log("컨트롤러로 보낼 saveList : " , saveList);
	saveAction(saveList);
	firstQtyUpdate(saveList);
	})

// 주문버튼 클릭 => 주문페이지로 보내기
$(document).on('click', '.orderBtn', function() {
	chkMod();
	if(modYn == true) {
		var result = confirm("이동하시기 전에 수정 사항을 저장하시겠습니까?");
		if(result) {
			saveAll();} 
	}	
	var gId = $(this).closest('.cart_item').find('span[id$="_qty"]').attr('id').replace('_qty', '');
	var bQty = $(this).closest('.cart_item').find('span[id$="_qty"]').html();
	
	var form = document.createElement('form');
	form.method = 'POST';
	form.action = '/order/goOrderPage';

	var gIdInput = document.createElement('input');
	gIdInput.type = 'hidden';
	gIdInput.name = 'gId';
	gIdInput.value = gId;

	var mIdInput = document.createElement('input');
	mIdInput.type = 'hidden';
	mIdInput.name = 'mId';
	mIdInput.value = mId;

	var oQtyInput = document.createElement('input');
	oQtyInput.type = 'hidden';
	oQtyInput.name = 'oQty';
	oQtyInput.value = bQty;

	form.appendChild(gIdInput);
	form.appendChild(mIdInput);
	form.appendChild(oQtyInput);

	// 폼을 body에 추가하고 전송
	document.body.appendChild(form);
	form.submit();
	
// 	window.location.href = '/order/goOrderPage?gId=' + gId + '&mId=' + mId + '&oQty=' + bQty;
	});

// 이미지 클릭 => 상품 디테일 페이지로 보내기
$(document).on('click', '.cart_img', function() {
	chkMod();
	if(modYn == true) {
		var result = confirm("이동하시기 전에 수정 사항을 저장하시겠습니까?");
		if(result) {
			saveAll();
		} else {
			basketList(mId);
		}
	} else {
		basketList(mId);
		alert("수량이 변경되지 않았습니다.");
	}	
	var cartItemId = $(this).closest('.cart_item').attr('id').substring(5);
	console.log("클릭한 상품id: ", cartItemId);
	window.location.href = '/goods/detail?gId=' + cartItemId;
	});

function saveAll() {
	saveList = [];
	var modList = $("span[id$='_qty']");
	$.each(modList, function(i, v){
		if("Y" == $(v).data("modyn")){
			var gId = $(v).attr("id").split("_qty")[0];
			var data = {"mId":mId, "gId": gId,"bQty":$(v).html()}
			saveList.push(data);
		}
	});
	console.log("컨트롤러로 보낼 saveList : " , saveList);
	saveAction(saveList);
	firstQtyUpdate(saveList); // 초기값 업데이트 함수
}

// 지금 구분안되는게 data, contentType, dataType
// data는 서버로 보내는 값
// contentType는 서버로 보내는 데이터 형식
// dataType은 서버에서 받아올 데이터의 형식
function saveAction(saveList){
	$.ajax({
		url: "/goods/basketListUpdate",
		type: "POST",
		data: JSON.stringify(saveList), // saveList를 JSON 문자열로 변환하여 전송
		contentType: "application/json", // JSON 형식으로 데이터 전송
		success: function(response) {
			alert("해당 상품의 수량이 변경되었습니다.");
		}
	});
}

//초기값 변경
function firstQtyUpdate(saveList){
	console.log("초기값 업데이트 해줄 차례!!!!");
	// bQty값으로 data-firstqty값을 바꿔주고싶음
	 saveList.forEach(item => {
			$("#" + item.gId + "_qty").data("firstqty", item.bQty);
// 			var firstqty = $("#" + item.gId + "_qty").data("firstqty");
// 			console.log("firstqty초기값 변경 확인 : " + firstqty); // 변경 확인!
			$("#" + item.gId + "_qty").data("modyn", "N");		
			$("#saveBtn_" + item.gId).hide(); // 다시 저장버튼 숨기기
		  });
}

// 삭제버튼 클릭 => deleteAction 함수 호출하기
function deleteOne(gid) {
	deleteAction(gid);
}

// 전체삭제버튼 클릭 => deleteAction 함수 호출하기
function deleteAll() {
	deleteAction(null);
}

function deleteAction(gid){
	$.ajax({
		url:"/goods/basketDelete",
		type:"POST",
		data: {
			mId:mId,
			gId:gid
		},	
		success: function(response) {	
			alert("해당 상품이 삭제되었습니다.");
			currPage = 1;
			isReset = true;
			basketList(mId);
		}
	})	
}

// top 버튼
function scrollToTop() {
	  $("html, body").animate({ scrollTop: 0 }, "slow");
}
	
// top 이벤트 처리
$(window).scroll(function() {
  if ($(this).scrollTop() > 100) {
    $('#topBtn').fadeIn();
  } else {
    $('#topBtn').fadeOut();
  }
});
</script>
</body>
</html>