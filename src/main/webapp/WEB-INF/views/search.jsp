<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>검색결과</title>
</head>
<body>
	<jsp:include page="import/mainFrame.jsp"/>
	
	<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	
	<div class="container">
		<div class="resultDiv">'${keyword}'에 대한 검색 결과입니다.</div>
		<div class="dataDiv">
			<div class="titleDiv">이벤트</div>
			<div class="listDiv eventListData">
			</div>
			<div class="moreDiv eventMore" onClick="clickMore('event');">더 보기</div>
		</div>
		<div class="dataDiv">
			<div class="titleDiv">상품</div>
			<div class="listDiv goodsListData">
			</div>
			<div class="moreDiv goodsMore" onClick="clickMore('goods');">더 보기</div>
		</div>
	</div>

</body>

<style>
.container {
	width: 70%;
	min-height: 500px;
	margin: 80px 15%;
}
.resultDiv {
	width:100%;
	height: 30px;
    margin-bottom: 10px;
}
.dataDiv {
    min-height: 200px;
    margin-bottom: 30px;
}
.titleDiv {
	font-size: 20px;
    font-weight: bold;
    margin-bottom: 15px;
}
.listDiv {
    min-height: 150px;
}
.moreDiv {
    min-height: 30px;
    margin-top: 10px;
    text-align: center;
	display: none;
    cursor: pointer;
    background-color: lightblue;
}
.searchData {
    height: 60px;
    margin-bottom: 10px;
}
.dataImg {
    width: 60px;
    height: 60px;
    float: left;
}
.goodsImg {
 	cursor: pointer;
}
.dataInfo {
	width: calc(100% - 60px);
    height: 60px;
    float: left;
    text-overflow: ellipsis;
    line-height: 3.5;
}
.searchImg {
	width:60px;
	height: 60px;
}
.eventHideDiv, .goodsHideDiv {
	display: none;
}
</style>

<script>

var eventList = JSON.parse('${eventList}');
var goodsList = JSON.parse('${goodsList}');


// var eventList = '${eventList}';
// var goodsList = '${goodsList}';

var keyword = '${keyword}';

$(document).ready(function() {
	
	$("#searchInput").val(keyword);
	
	setEvent();
	setGoods();
	
});

function setEvent() {
	
	if(eventList.length > 3) {
		$(".eventMore").show();
	} else {
		$(".eventMore").hide();
	}
	
	var html = "";
	
	if(eventList.length > 0) {
		$.each(eventList, function(i, v) {
			html += '<div class="searchData';
			if(i > 2) {
			html +=	' eventHideDiv';
			}
			html += '">';
			html += '<div class="dataImg"><img class="searchImg" src=\'' + eventList[i].IMG + '\'/></div>';
			html += '<div class="dataInfo">&nbsp;&nbsp;'+ eventList[i].NAME +' ('+ eventList[i].SDT + '~' + eventList[i].EDT + ') ' + eventList[i].CMT +'</div>';
			html += '</div>';
		});
	} else {
		html += '이벤트 검색 결과가 없습니다.';
	}
	
	$(".eventListData").append(html);
	
}

function setGoods() {
	
	if(goodsList.length > 3) {
		$(".goodsMore").show();
	} else {
		$(".goodsMore").hide();
	}
	
	var html = "";
	
	if(goodsList.length > 0) {
		$.each(goodsList, function(i, v) {
			html += '<div class="searchData';
			if(i > 2) {
			html +=	' goodsHideDiv';
			}
			html +=	'">';
			html += '<div class="dataImg goodsImg" onclick="goDetail(\''+ goodsList[i].ID +'\')"><img class="searchImg" src=\'' + goodsList[i].IMG + '\'/></div>';
			html += '<div class="dataInfo">&nbsp;&nbsp;<a href="#" onclick="goDetail(\''+ goodsList[i].ID +'\')">'+ goodsList[i].NAME +' (\\'+ addComma(goodsList[i].PRICE);
			if(goodsList[i].EPRICE != null) {
			html += ' -> \\' + addComma(goodsList[i].EPRICE);
			}
			html += ') 남은수량: ' + goodsList[i].QYT +'</a></div>';
			html += '</div>';
		});
	} else {
		html += '상품 검색 결과가 없습니다.';
	}
		
	$(".goodsListData").append(html);
	
}

function addComma(value) {
	value = String(value).replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	return value;
}

function clickMore(type) {
	var hideDivList = $("." + type + "HideDiv");
	if(hideDivList.length > 0) {
		for(var i = 0; i < 3; i++) {
			$(hideDivList[i]).show();
			$(hideDivList[i]).removeClass(type + "HideDiv");
		}
	}
	
	hideDivList = $("." + type + "HideDiv");
	if(hideDivList.length > 0) {
		$("." + type +"More").show();
	} else {
		$("." + type +"More").hide();
	}
}

function goDetail(gId) {
	window.location.href="/goods/detail?gId=" + gId;
}

</script>

</html>