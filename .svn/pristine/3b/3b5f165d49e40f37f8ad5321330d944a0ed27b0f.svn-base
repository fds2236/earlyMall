<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품등록</title>
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
	<span>상품등록</span>
	<input type="button" value="X" onclick="javascript:btnClose();">
</div>

<form id="insertContents" action="/admin/insertGoods" method="post" enctype="multipart/form-data">
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
		<button id="registerBtn" type="submit" onclick="return confirm('등록하시겠습니까?')">상품등록</button>
		<button type="button" onclick="javascript:btnClose();">닫기</button>
	</div>
</form>


</body>




<script type="text/javascript">

var cate = $("#gCateCd").val();
var name = $("#gName").val();
var price = $("#gPrice").val();
var qty = $("#gQty").val();
var img = $("#gImg").val();
var imgDtl = $("#gImgDtl").val();
var showYn = $("#gShowYn").val();
var delYn = $("#gDelYn").val();

function btnClose(){
	opener.parent.location.reload(); //부모페이지 reload
	window.close();
}






</script>

</html>