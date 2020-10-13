<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>查詢離我最近的活動</title>
<style>
div {
	text-align:center;
}
</style>
</head>
<body>
<c:set var="funcName" value="GEO" scope="session"/>
<jsp:include page="/fragment/top.jsp" />
	<br>
	<div>
		<h1>請輸入您的位置</h1>
		<br>
		<form action="<c:url value='FindNear'/> " method="get">
			<div class="searchBox">
				<input type="text" class="" name="userLocation" value="">
			</div>
			<BR>
			<div class="submitButton">
				<input type="submit" class="" name="submit" value="確認送出"> 
			</div>
		</form>
	</div>
	<br>
	<br>
	<div>
		<h1>猜您喜歡</h1>
	</div>
	<c:forEach var="recommend" items="${recommend}">
		<c:set var="addr" value="${recommend.city.concat(recommend.district).concat(recommend.address)}"/>
		<h3>${recommend.title}</h3>
		<iframe width="100%" height="250" frameborder="0" src="https://www.google.com/maps?q=${addr}&output=embed"></iframe>
	</c:forEach>
</body>
</html>