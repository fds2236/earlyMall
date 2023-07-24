<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품수정</title>
</head>

<script type="text/javascript" src="https://code.jquery.com/jquery-1.10.2.min.js"></script>

<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f7f7f7;
        margin: 0;
        padding: 0;
    }
    
    div {
        background-color: #f2f2f2;
        padding: 10px;        
    }
    
    span {
        font-weight: bold;
    }
    
    input[type="button"] {
        background-color: #e5e5e5;
        border: none;
        color: #333;
        padding: 5px 10px;
        cursor: pointer;
    }
    
    form {
        margin: 20px;
    }
    
    select, input[type="text"], input[type="number"], input[type="file"] {
        margin-top: 5px;
        padding: 5px;
        width: 200px;
    }
    
    button[type="submit"], button[type="button"] {
        background-color: #4caf50;
        color: white;
        border: none;
        padding: 10px 20px;
        margin-top: 10px;
        cursor: pointer;
    }
</style>



<body>

<div>
	<span>상품수정</span>
	<input type="button" value="X" onclick="javascript:btnClose();">
</div>

<form id="editContents" action="/admin/editGoods" method="post" enctype="multipart/form-data">
	<div>
		<div>
			<div>
				카테고리
				<select id="gCateCd" name="gCateCd">								
					<c:forEach var="gdsCate" items="${goodsCateList}">
						<option value="${gdsCate.DID}">${gdsCate.DNAME}</option>
					</c:forEach> 							
				</select>
			</div>
			<div>
				상품명
				<input id="gName" type="text" name="gName" required>
			</div>
			<div>
				가격
				<input id="gPrice" type="number" name="gPrice" required>
			</div>
			<div>
				수량
				<input id="gQty" type="number" name="gQty" required>
			</div>
			<div>
				대표이미지			
				<input id="gImg" type="file" name="gImg" required>
			</div>
			<div>
				상세이미지
				<input id="gImgDtl" type="file" name="gImgDtl" required>
			</div>
			<div>
				노출여부
				<select id="gShowYn" name="gShowYn">
					<option value="N">N</option>
					<option value="Y">Y</option>			
				</select>
			</div>
			<div>
				삭제여부
				<select id="gDelYn" name="gDelYn">
					<option value="N">N</option>
					<option value="Y">Y</option>			
				</select>
			</div>
		</div>
		<button id="editBtn" type="submit" onclick="return confirm('수정하시겠습니까?')">상품수정</button>
		<button id="delBtn" type="button">삭제</button>
		<button type="button" onclick="javascript:btnClose();">닫기</button>
	</div>
</form>


</body>




<script type="text/javascript">

var cate = rowData.G_CATE_CD;
var id = rowData.G_ID;
var name = rowData.G_NAME;
var price = rowData.G_PRICE;
var qty = rowData.G_QTY;
var showYN = rowData.G_SHOW_YN;
var delYN = rowData.G_DEL_YN;
var img = rowData.G_IMG;
var imgDtl = rowData.G_IMG_DTL;




function btnClose(){
	opener.parent.location.reload(); //부모페이지 reload
	window.close();
}


$(function(){
	// 현재 페이지의 URL에서 매개변수를 추출하는 함수
	console.log(rowData);
		
	$('#gName').val(name);
	$('#gPrice').val(price);
	$('#gQty').val(qty);
	$('#gShowYn').val(showYN);
	$('#gDelYn').val(delYN);
	
		
	});


</script>

</html>