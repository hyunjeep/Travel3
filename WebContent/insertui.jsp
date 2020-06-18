<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>
<%@ include file="./com/head.jsp"%>
<script type="text/javascript">
	$(document).ready(function() {
		$("#btnIdCheck").on("click", function(e) {
			var newId = $("#id").val();
			alert(newId);

			$.ajax({
				url : "idChack",
				data : {
					id : newId
				},
				type : "GET",
				dataType : "text",
			}).done(function(result) {
				alert(result);
			})
			/* 			.fail(function(xhr, status, errorThrown) {
			 alert("Sorry, there was a problem!");
			 console.log("Error: " + errorThrown);
			 console.log("Status: " + status);
			 console.dir(xhr);
			 })
			 .always(function(xhr, status) {
			 alert("The request is complete!");
			 }); */
		});
	});
</script>
</head>
<body>
	<%@ include file="./com/top.jsp"%>
	<%@ include file="./com/navbar.jsp"%>

	<div class="container" style="margin: 30px auto 30px auto;">
		<h2>어서오세요!!</h2>
		<p>
			저희 Travel사이트에 가입을 위해 몇가지 입력 할 게 있습니다.
			<code>아래 빈칸을 빠짐없이 입력</code>
			해주시면 가입 할 수 있습니다.
		</p>
		<form action="insert.do" class="was-validated" method="post">
			<div class="form-group">
				<div class="row">
					<div class="col-sm-12">
						<label for="id">Id:</label>
					</div>
					<div class="col-sm-10">
						<input type="text" class="form-control" id="id" placeholder="ID를 입력해주세요" name="id" required>
					</div>
					<div class="col-sm-2 text-center">
						<a class="btn btn-secondary" id="btnIdCheck" style="color: white;">ID중복확인</a>
					</div>
				</div>
				<div class="valid-feedback">완료됨.</div>
				<div class="invalid-feedback">정보를 입력해주세요.</div>
			</div>
			<div class="form-group">
				<label for="pw">Password:</label> <input type="password" class="form-control" id="pw" placeholder="Password를 입력해주세요" name="pw" required>
				<div class="valid-feedback">완료됨.</div>
				<div class="invalid-feedback">정보를 입력해주세요.</div>
			</div>
			<div class="form-group">
				<label for="name">Name:</label> <input type="text" class="form-control" id="name" placeholder="이름을 입력해주세요" name="name" required>
				<div class="valid-feedback">완료됨.</div>
				<div class="invalid-feedback">정보를 입력해주세요.</div>
			</div>
			<div class="form-group">
				<label for="age">Age:</label> <input type="text" class="form-control" id="age" placeholder="나이를 입력해주세요" name="age" required>
				<div class="valid-feedback">완료됨.</div>
				<div class="invalid-feedback">정보를 입력해주세요.</div>
			</div>
						<div class="form-group">
				<label for="email">E-mail:</label> <input type="text" class="form-control" id="email" placeholder="E-mail을 입력해주세요" name="email">
				<div class="valid-feedback">완료됨.</div>
				<div class="invalid-feedback">정보를 입력해주세요.</div>
			</div>
			<div class="form-group form-check">
				<label class="form-check-label"> <input class="form-check-input" type="checkbox" name="remember" required> 정보제공에 동의 합니다.
					<div class="valid-feedback">완료됨.</div>
					<div class="invalid-feedback">정보를 입력해주세요.</div>
				</label>
			</div>
			<button type="submit" class="btn btn-primary">회원가입</button>
		</form>
	</div>
	<%@ include file="./com/footer.jsp"%>
</body>
</html>