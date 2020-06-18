<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<title>회원 정보 수정</title>
<%@ include file="./com/head.jsp"%>
</head>
<body>
	<%@ include file="./com/top.jsp"%>
	<%@ include file="./com/navbar.jsp"%>

	<div class="container" style="margin: 30px 0 30px 0;">
		<h2>${dto.id}님의정보 수정</h2>
		<form action="update.do" class="was-validated" method="post">
			<div class="form-group">
				<label for="id">ID:</label> <input type="text" class="form-control" id="id" name="id" value="${dto.id}" readonly="readonly">
			</div>
			<c:if test="${null ne error}">
				<div class="alert alert-warning alert-dismissible">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
					<strong>Warning!</strong> ${error}
				</div>
			</c:if>
			<div class="form-group">
				<label for="pw">Password:</label> <input type="password" class="form-control" id="pw" placeholder="Password를 입력해주세요" name="pw" required>
				<div class="valid-feedback">완료됨.</div>
				<div class="invalid-feedback">정보를 입력해주세요.</div>
			</div>
			<div class="form-group">
				<label for="name">Name:</label> <input type="text" class="form-control" id="name" placeholder="이름을 입력해주세요" name="name" value="${dto.name}"
					required>
				<div class="valid-feedback">완료됨.</div>
				<div class="invalid-feedback">정보를 입력해주세요.</div>
			</div>
			<div class="form-group">
				<label for="age">Age:</label> <input type="text" class="form-control" id="age" placeholder="나이를 입력해주세요" name="age" value="${dto.age}"required>
				<div class="valid-feedback">완료됨.</div>
				<div class="invalid-feedback">정보를 입력해주세요.</div>
			</div>
			<div class="form-group">
				<label for="age">Email:</label> <input type="text" class="form-control" id="email" placeholder="나이를 입력해주세요" name="email" value="${dto.email}">
				<div class="valid-feedback">완료됨.</div>
				<div class="invalid-feedback">정보를 입력해주세요.</div>
			</div>
			<button type="submit" class="btn btn-primary">등록</button>
		</form>
	</div>
	<%@ include file="./com/footer.jsp"%>
</body>
</html>