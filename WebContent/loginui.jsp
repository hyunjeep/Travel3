<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<%@ include file="./com/head.jsp"%>
</head>
<body>
	<%@ include file="./com/top.jsp"%>
	<%@ include file="./com/navbar.jsp"%>

	<div class="container" style="margin: 30px auto 30px auto;">
		<h2>로그인</h2>
		<c:if test="${null ne error }">
			<div class="alert alert-warning alert-dismissible">
				<button type="button" class="close" data-dismiss="alert">&times;</button>
				<strong>Warning!</strong> ${error}
			</div>
		</c:if>
		<form action="login.do" method="post">
			<div class="form-group">
				<label for="id">ID:</label> <input type="text" class="form-control" id="id" placeholder="ID를 입력하세요" name="id">
				<div class="form-group">
					<label for="pw">Password:</label> <input type="password" class="form-control" id="pw" placeholder="Password를 입력하세요" name="pw">
				</div>
			</div>
			<div class="form-group form-check">
				<label class="form-check-label"> <input class="form-check-input" type="checkbox" name="remember"> 로그인 상태 유지
				</label>
			</div>
			<button type="submit" class="btn btn-primary">로그인</button>
			<a href="insertui.do" class="btn btn-secondary">회원가입</a>
		</form>
	</div>
	<%@ include file="./com/footer.jsp"%>
</body>
</html>