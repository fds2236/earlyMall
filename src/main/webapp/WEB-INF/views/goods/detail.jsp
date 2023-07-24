<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 상세</title>

<style>
.container {
	width: 70%;
	margin: 30px 15%;
}

.categori {
	margin-bottom: 10px;
}

.container-box {
	display: flex;
	align-items: center;
	gap: 20px;
	margin-bottom: 20px;
	border: 2px solid skyblue;
	padding: 20px;
}

.container-box img {
	max-width: 100%;
	height: auto;
}

.container-box .product-info {
	flex-grow: 1;
}

.product-info p {
	margin: 5px 0;
}

.totalPrice {
	display: flex;
	justify-content: flex-end;
	align-items: center;
	margin-top: 10px;
}

.totalPrice span {
	margin-right: 10px;
	font-weight: bold;
  	font-size: 25px;
}

.totalPrice input {
	text-align: right;
	border: none;
	background-color: transparent;
}

.product-buttons {
	margin-top: 10px;
	display: flex;
	justify-content: flex-end;
	align-items: center;
}

.product-buttons input[type="number"] {
	height: 32px;
	line-height: 32px;
	width: 50px;
	text-align: center;
	margin-right: 10px;
}

.product-buttons button {
	margin-right: 5px;
}

#detailImg {
	width: 100%;
	margin-top: 20px;
}

#mainImg {
	width: 400px;
	height: 300px;
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
	font-size: 15px;
	cursor: pointer;
}

.btn:hover {
	background-color: #4297d7;
}



.product-name {
  margin: 0px;
  font-weight: bold;
  font-size: 20px;
  padding:10px;
}

.product-price {
  margin: 0px;
  font-weight: bold;
  font-size: 16px;
  padding-top: 15px;
  padding-bottom: 5px;
 
}

.product-price-sale {
  margin: 0px;
  font-weight: bold;
  font-size: 16px; 
  padding-top:5px;
  padding-bottom: 15px;
  color: red;
}
.textline {
	text-decoration: line-through;
}



</style>
</head>

<body>

<jsp:include page="../import/mainFrame.jsp"/>

<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>

<div class="container">
	<div class="categori">
		전체 > <span id="category"></span>
	</div>
	<div class="container-box">
		<div>
			<img id="mainImg" src="${goodsDetail.G_IMG}">
		</div>
		<div class="product-info">
			<div>
				<p class="product-name">${goodsDetail.G_NAME}</p>				
				
				<c:if test="${goodsDetail.EG_PRICE == null}">
					<p class="product-price">
						<fmt:formatNumber value="${goodsDetail.G_PRICE}" type="number" pattern="#,##0 원" />
					</p>
				</c:if>	
				<c:if test="${goodsDetail.EG_PRICE != null}">
					<p class="product-price textline">
						<fmt:formatNumber value="${goodsDetail.G_PRICE}" type="number" pattern="#,##0 원" />
					</p>					
					<p class="product-price-sale">
						<fmt:formatNumber value="${goodsDetail.EG_PRICE}" type="number" pattern="#,##0 원" />
					</p>			
				</c:if>
				
									
			</div>

			<div class="totalPrice">
				<div id="displayPrice">
					<span>총 금액</span> <span id="totalPrice" class="price-value"></span> <span>원</span>
				</div>	
				<span id="outOfStock" style="display: none">일시품절</span>
			</div>

			<div class="product-buttons">
				<input id="count" type="number" value="1">
				<button class="btn" id="addToCartBtn" type="button">장바구니</button>
				<button class="btn" id="directPurchaseBtn" type="button">바로구매</button>
			</div>		
			
		</div>
	</div>
	<div>
		<div>
			<img id="detailImg" src="${goodsDetail.G_IMG_DTL}">
		</div>
	</div>
</div>


<script type="text/javascript">

var price = parseInt("${goodsDetail.G_PRICE}");
var salePrice = parseInt("${goodsDetail.EG_PRICE}");

if (isNaN(salePrice)) {
	  salePrice = null;
	}


var totalPrice = 0;


$(document).ready(function() {
	  var qty = "${goodsDetail.G_QTY}";
		console.log(qty);
	  
	  var category = "${goodsDetail.G_CATE_CD}";
	  if (category === '10') {
	    $("#category").text("가전");
	  } else if (category === '20') {
	    $("#category").text("컴퓨터");
	  } else if (category === '30') {
	    $("#category").text("모바일");
	  }
	  
	  // 수량이 0일떄
	  if (qty === "0") {
		  $("#count").hide();
		  $("#addToCartBtn").hide();
		  $("#directPurchaseBtn").hide();
		  $("#displayPrice").hide();
		  $("#outOfStock").show();		    
		  }
	  

	  // 초기 값 설정
	  var count = parseInt($("#count").val());
	  if (isNaN(count) || count < 1) {
	    $("#count").val("1");
	    count = 1;
	  }	  
	  
	  if(salePrice != null){
		  totalPrice = salePrice * count;
	  }
	  else {
		  totalPrice = price * count;		  
	  }
	  
	  $("#totalPrice").text(totalPrice.toLocaleString());

	  // 수량 변경 시 이벤트 핸들러
	  $("#count").on("input", function() {
	    var count = parseInt($(this).val());
	    if (isNaN(count) || count < 1) {
	      $(this).val("1");
	      count = 1;
	    }
	    
	  //  var totalPrice = 0;
		  
		if(salePrice != null){
			  totalPrice = salePrice * count;
		  }
		else {
			  totalPrice = price * count;		  
		  }
		
	    $("#totalPrice").text(totalPrice.toLocaleString());
	  });

	  // 장바구니 추가 함수
	  function addToCart() {
	    var count = parseInt($("#count").val());
	    if (count < 1) {
	      alert("수량은 1 이상이어야 합니다.");
	      return;
	    }

	    var data = {
	      gId: "${goodsDetail.G_ID}",
	      mId: "${memberInfo.mId}",
	      bQty: count
	    };

	    $.ajax({
	      url: "/goods/basketAdd",
	      method: "POST",
	      data: data,
	      success: function(response) {
	        var confirmAddToCart = confirm("장바구니에 상품이 추가되었습니다. 장바구니로 이동하시겠습니까?");
	        if (confirmAddToCart) {
	          window.location.href = "/goods/basket";  // 장바구니 페이지로 이동
	        }
	       
	      },
	      error: function(xhr, status, error) {
	        alert("장바구니 추가 중 오류가 발생했습니다. 다시 시도해주세요.");
	        console.error(error);
	      }
	    });
	  }
	  
	  
	// 바로구매 함수
	  function byeNow() {
	    var count = parseInt($("#count").val());
	    if (count < 1) {
	      alert("수량은 1 이상이어야 합니다.");
	      return;
	    }

	    var gId = "${goodsDetail.G_ID}";
	    var mId = "${memberInfo.mId}";
	    var oQty = count;
	    
	    var form = $('<form></form>');
	    form.attr('method', 'POST');
	    form.attr('action', '/order/goOrderPage');

	    var gIdInput = $('<input/>');
	    gIdInput.attr('type', 'hidden');
	    gIdInput.attr('name', 'gId');
	    gIdInput.val(gId);

	    var mIdInput = $('<input/>');
	    mIdInput.attr('type', 'hidden');
	    mIdInput.attr('name', 'mId');
	    mIdInput.val(mId);

	    var oQtyInput = $('<input/>');
	    oQtyInput.attr('type', 'hidden');
	    oQtyInput.attr('name', 'oQty');
	    oQtyInput.val(oQty);

	    form.append(gIdInput);
	    form.append(mIdInput);
	    form.append(oQtyInput);

	    $('body').append(form);
	    form.submit();
	     
	  }
	  
	  

	  // 장바구니 버튼 클릭 시 이벤트 핸들러
	  $("#addToCartBtn").click(function() {
	    // if 로그인이 안된 상태면
	    if (!("${memberInfo.mId}".trim())) {
	      alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
	      window.location.href = "/login";
	      return;
	    }
	    addToCart();
	  });

	  // 바로구매 버튼 클릭 시 이벤트 핸들러
	  $("#directPurchaseBtn").click(function() {
	    // if 로그인이 안된 상태면
	    if (!("${memberInfo.mId}".trim())) {
	      alert("로그인이 필요합니다. 로그인 페이지로 이동합니다.");
	      window.location.href = "/login";
	      return;
	    }
	   	byeNow();
	  });
	});
	
	
	
	
</script>

</body>
</html>