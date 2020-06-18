<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<%@ include file="./com/head.jsp"%>
</head>
<body>
	<%@ include file="./com/top.jsp"%>
	<%@ include file="./com/navbar.jsp"%>

	<form class="container" action="modify.do" method="post">
		<br> <br>
		<h2>글 수정하기</h2>
		<input name="num" value="${dto.num}" hidden="true"> <br>
		<div class="form-inline">
			지역 :&nbsp;&nbsp;&nbsp; <select class="custom-select" name="locationCode" id="locationCode">
				<option value="2">서울</option>
				<option value="51">부산</option>
				<option value="53">대구</option>
				<option value="32">인천</option>
				<option value="62">광주</option>
				<option value="42">대전</option>
				<option value="52">울산</option>
				<option value="44">세종</option>
				<option value="31">경기</option>
				<option value="33">강원</option>
				<option value="43">충북</option>
				<option value="41">충남</option>
				<option value="63">전북</option>
				<option value="61">전남</option>
				<option value="54">경북</option>
				<option value="55">경남</option>
				<option value="64">제주</option>
				<option value="1">기타</option> 
				</select>
				&nbsp;&nbsp;&nbsp;
				<label for="exampleFormControlInput1"> 제목 : </label>&nbsp;&nbsp;&nbsp;
				<input name="title" class="form-control" id="exampleFormControlInput1" value="${dto.title}" required="required">
		</div>

		<label for="exampleFormControlInput2"> 작성자 : ${dto.writer}&nbsp;&nbsp;|&nbsp;&nbsp;조회수 : ${dto.readcnt} </label>

		<div class="form-group">
			<label for="exampleFormControlTextlocation1">content</label>
			<textarea class="form-control" id="exampleFormControlTextlocation1" rows="10" name="content">${dto.content}</textarea>
		</div>
		<button class="btn btn-primary" type="submit">수정</button>
		<a class="btn btn-outline-primary" href="delete.do?num=${dto.num}">삭제</a>
		<a class="btn btn-outline-primary" href="replyui.do?num=${dto.num}&title=${dto.title}">답글</a>
		<a class="btn btn-outline-primary" href="list.do">목록</a>
	</form>

	<script>
		$(document).ready(function() {
			$("#locationCode").val("${dto.locationCode}");
		});
	</script>
	<%@ include file="./com/footer.jsp"%>
</body>
</html>