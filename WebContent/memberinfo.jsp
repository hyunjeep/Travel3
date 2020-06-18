<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<title>회원 정보</title>
<%@ include file="./com/head.jsp"%>
</head>
<body>
	<%@ include file="./com/top.jsp"%>
	<%@ include file="./com/navbar.jsp"%>

	<div class="container" style="margin: 30px auto 30px auto;">
		<h2>${dto.id }님의회원 정보</h2>
		<p>이곳에서 회원 정보 수정, 탈퇴 등을 할수 있습니다.</p>
		<div class="card" style="width: 400px">
			<img class="card-img-top" src="./img/img_avatar1.png" alt="Card image" style="width: 100%">
			<div class="card-body">
				<h4 class="card-title">${dto.id}</h4>
				<p class="card-text">${dto.name}님은현재 ${dto.age}살 입니다.</p>
				<a href="updateui.do?id=${dto.id }" class="btn btn-primary">수정</a>
				<a href="deleteid.do?id=${dto.id}" class="btn btn-primary">탈퇴</a>
			</div>
		</div>
	</div>
	<%@ include file="./com/footer.jsp"%>
</body>
</html>