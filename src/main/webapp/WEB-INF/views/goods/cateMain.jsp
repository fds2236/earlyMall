<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카테고리별 상품</title>

<style>
.product-item {
    flex-basis: 19%;
    box-sizing: border-box;
    text-align: center;
    border-width: 1px;
    border-color: black;
    border-style: solid;
    margin-bottom: 10px;   
    margin-right: 10px; 
    padding: 10px;
}

.product-item img {
    max-width: 90%;
    height: 200px;
   
}

.product-row {
    display: flex;
    flex-wrap: wrap;
    
}

.container {
	margin: 70px 15%;
    width: 70%;
}

#loadingSpinner {
    text-align: center;
    margin-top: 20px;
    font-weight: bold;
}

.salePrice {
	color: red;
}
</style>

</head>

<body>

<jsp:include page="../import/mainFrame.jsp"/>

<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<div class="container">


	<div style="padding: 5px;">
		<button name="sortType" value="lowPrice">낮은가격순</button>
		<button name="sortType" value="highPrice">높은가격순</button>
		<button name="sortType" value="newest">최신순</button>
	</div>


    <div id="productList">
        <!-- 상품 목록이 동적으로 추가될 부분 -->
    </div>

    <div id="loadingSpinner"></div>

</div>

</body>

<script type="text/javascript">
var page = 1; // 현재 페이지
var isLoading = false; // 데이터 로딩 중 여부

var gCateCd = '${cateCd}'
var sortType = "newest";
var itemsPerPage = 20;
var totalItems = 0;

  
  $(document).ready(function() {
	  var list = JSON.parse('${list}');
	  renderProductList(list.cateGoodsList);
	  console.log(list.cateGoodsList);
  });
  


$('button[name="sortType"]').click(function() {
    sortType = $(this).val();
    console.log('Selected sort type:', sortType);

    page = 1;
    getProductList(page);
    infiniteScroll();
});

$('#goodsGategory').change(function() {
    gCateCd = $(this).val();
    console.log('Selected category:', gCateCd);

    page = 1;
//     getProductList(page);
});

// 초기화 함수
function initialize() {
//     getProductList(page);
//     $(window).scroll(infiniteScroll);
	infiniteScroll();

    // 새로고침 시 스크롤 맨 위로 이동
    $(window).on('beforeunload', function() {
        $(window).scrollTop(0);
    });
}

// 상품 목록 가져오기
function getProductList(page) {
    if (isLoading) return;
    isLoading = true;

    $.ajax({
        url: '/goods/CateGoodsList',
        type: 'GET',
        data: {
            gCateCd: gCateCd,
            sortType: sortType,
            page: page           
        },
        success: function(response) {
            var productList = response.cateGoodsList; // 리스트 목록
            totalItems = productList.length;  // item 총 개수
            
            renderProductList(productList);  //리스트 렌더링


            isLoading = false;
        },
        error: function(error) {
            console.log(error);
            isLoading = false;
        }
    });
}

//상품 목록 렌더링
function renderProductList(productList) {
    var productListElement = $('#productList');
    var loadingSpinnerElement = $('#loadingSpinner');

    if (page === 1) {
        productListElement.empty();
    }

    var rowsCount = Math.ceil(productList.length / 5); // 현재 페이지에서 필요한 행의 수 계산
    for (var rowIndex = 0; rowIndex < rowsCount; rowIndex++) {
        var rowElement = $('<div class="product-row"></div>'); // 각 행 요소 생성

        // 한 행에 들어갈 상품 개수 계산
        var startIndex = rowIndex * 5;
        var endIndex = Math.min(startIndex + 5, productList.length);
        for (var i = startIndex; i < endIndex; i++) {
            var product = productList[i];

            var productElement = $('<div class="product-item"></div>');
            var imageElement = $('<img src="' + product.G_IMG + '">');
            var nameElement = $('<p><a href="/goods/detail?gId=' + product.G_ID + '">' + product.G_NAME + '</a></p>');

            
            productElement.append(imageElement); //이미지 
            productElement.append(nameElement);	//상품명
            
            // EG_PRICE 값 추가
            if (product.hasOwnProperty('EG_PRICE')) {
                var priceElement = $('<p class="originalPrice" style="text-decoration: line-through;">' + product.G_PRICE.toLocaleString() + '원</p>');
                var egPriceElement = $('<p class="salePrice">' + product.EG_PRICE.toLocaleString() + '원</p>');
                productElement.append(priceElement); //원래 가격
                productElement.append(egPriceElement); //할인 가격
            } else {
                var priceElement = $('<p class="originalPrice">' + product.G_PRICE.toLocaleString() + '원</p>');
                productElement.append(priceElement); //원래 가격
            }

            

            rowElement.append(productElement);
        }

        productListElement.append(rowElement); // 행을 상품 목록에 추가
    }

    if (productList.length < itemsPerPage || page * itemsPerPage >= totalItems) {
        loadingSpinnerElement.text('No more items');
    } else {
        loadingSpinnerElement.text('Loading...');
    }
}

//무한 스크롤 이벤트 핸들러
function infiniteScroll() {
 	
    var fullContent = document.querySelector("#productList"); // 전체를 둘러싼 컨텐츠 정보획득
	var screenHeight = screen.height; // 화면 크기
	var oneTime = false; // 일회용 글로벌 변수
	document.addEventListener('scroll',OnScroll,{passive:true}) // 스크롤 이벤트함수정의
	
	function OnScroll () { //스크롤 이벤트 함수
		var fullHeight = fullContent.clientHeight; // infinite 클래스의 높이   
		var scrollPosition = pageYOffset; // 스크롤 위치
		if(fullHeight-screenHeight <= scrollPosition && !oneTime) { // 만약 전체높이-화면높이/2가 스크롤포지션보다 작아진다면, 그리고 oneTime 변수가 거짓이라면
			page++;
			oneTime = true; // oneTime 변수를 true로 변경해주고,
			getProductList(page); // 컨텐츠를 추가하는 함수를 불러온다.
		}
	} 	 	
}


  // 초기화 함수 호출
  initialize();

</script>

</html>