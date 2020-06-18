<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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

</head>
<body>
	<%
		Map<String, String> map = new HashMap<String, String>();
		map.put("num", "1");
		map.put("title", "제목입니다.");
		map.put("writer", "kim");
		map.put("readcnt", "12");
		map.put("location", "부산");

		request.setAttribute("dto", map);
	%>
	<form class="container" action="update.do" method="get">
		<h2>게시글</h2>
		<input name="num" value="${dto.num }" hidden="true"> <label for="exampleFormControlInput1">Title</label> <br>
		<div class="form-inline">
			<select class="custom-select" name="location" id="location">
				<!-- <optgroup label="지역"> -->
				<option value="서울">서울</option>
				<option value="부산">부산</option>
				<option value="대구">대구</option>
				<option value="인천">인천</option>
				<option value="광주">광주</option>
				<option value="대전">대전</option>
				<option value="울산">울산</option>
				<option value="세종">세종</option>
				<option value="경기">경기</option>
				<option value="강원">강원</option>
				<option value="충북">충북</option>
				<option value="충남">충남</option>
				<option value="전북">전북</option>
				<option value="전남">전남</option>
				<option value="경북">경북</option>
				<option value="경남">경남</option>
				<option value="제주">제주</option>
				<option value="기타">기타</option>
				<!-- </optgroup> -->
			</select> &nbsp; <input name="title" class="form-control" id="exampleFormControlInput1" value="${dto.title }" required="required">
		</div>

		<label for="exampleFormControlInput1">작성자: ${dto.writer } | 조회수: ${dto.readcnt} </label>

		<div class="form-group">
			<label for="exampleFormControlTextarea1">textarea</label>
			<textarea class="form-control" id="exampleFormControlTextarea1" rows="5" name="content">${dto.content }</textarea>
		</div>
		<button class="btn btn-primary">수정</button>
		<a class="btn btn-outline-primary" href="delete.do?num=${dto.num }">삭제</a> <a class="btn btn-outline-primary" href="replyui.do?num=${dto.num }&title=${dto.title}">답글</a> <a class="btn btn-outline-primary" href="list.do">목록</a>
	</form>

	<script>
		
	<%--
   window.onload = function() {//윈도우가 열리면
      var location = "<c:out value='${dto.location}'/>";
      $("#location").val(location).prop("selected", true); //값이 dto.location인 option 선택
   }
--%>
		$(document).ready(function() {
			$("#location").val("${dto.location }");
		});
	</script>
</body>
</html>