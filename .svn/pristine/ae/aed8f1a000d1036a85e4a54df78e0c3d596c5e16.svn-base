<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="EUC-KR">
	<title>ADMIN</title>
	<style type="text/css">
		ul{
			display: flex; list-style: none;
		}
		li{
			text-align: center; 
			margin-right: 30px; 
			border: 1px solid #000;
			width: 300px;
			height: 300px;
		}
		li>p{
			line-height: 30px;
		}
		li>p:first-child {
			font-size: 100px;
		}
	</style>
</head>
<body>
<jsp:include page="../import/adminFrame.jsp"/>
	<div style="float:left;">
		
		<ul>
			<li>
				<p>${memToday}</p>
				<p>오늘 회원 가입 건수</p>
			</li>
			<li>
				<p>${orderToday}</p>
				<p>오늘 총 주문 건수</p>
			</li>
			<li>
				<p>${eventToday}</p>
				<p>오늘 등록된 이벤트 건수</p>
			</li>
		</ul>
		<ul>
			<li>
				<p>${memMonth}</p>
				<p>최근 한달간 회원 가입 건수</p>
			</li>
			<li>
				<p>${orderMonth}</p>
				<p>최근 한달간 총 주문 건수</p>
			</li>
			<li>
				<p>${eventMonth}</p>
				<p>최근 한달간 등록된 이벤트 건수</p>
			</li>
		</ul>
		
	</div>

<script>
$(document).ready(function() {
	setManageTitle("대시보드");
});

</script>



</body>
</html>