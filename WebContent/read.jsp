<%@page import="kr.co.dto.BoardDTO"%>
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
	<br>
	<br>
	<div class="container">
		<h2>글 자세히 보기</h2>
		<br>
		<%
			BoardDTO dto = (BoardDTO) request.getAttribute("dto");
		%>

		번호 : ${dto.num} | 작성일 : ${dto.writeday} | 조회수 : ${dto.readcnt} <br> <br> 제목 : ${dto.title} <br> 작성자 : ${dto.writer} <br> 지역 : ${dto.locationName} <br> 내용 : ${dto.content} <br>
		<br>

		<c:if test="${dto.writer eq login.id}">
			<a class="btn btn-primary" href="modifyui.do?curPage=${param.curPage}&locationCode=${param.locationCode}&num=${dto.num}">수정</a>
			<a class="btn btn-outline-primary" href="delete.do?num=${dto.num}">삭제</a>
		</c:if>
		<c:if test="${null ne login.id}">
		<a class="btn btn-outline-primary" href="replyui.do?curPage=${param.curPage}&locationCode=${param.locationCode}&num=${dto.num}">답글</a>
		</c:if>
		<a class="btn btn-outline-primary" href="list.do?curPage=${param.curPage}&locationCode=${param.locationCode}">목록</a>
	</div>
	<br>
	<br>
	<%@ include file="./com/footer.jsp"%>
</body>
</html>