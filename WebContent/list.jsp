<%@page import="kr.co.dto.PageTO"%>
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
	<ul class="nav">
		<c:if test="${null ne login.id}">
			<li class="nav-item"><a class="nav-link active" href="logout.do?id=${login.id}">로그아웃</a></li>
		</c:if>
		<c:if test="${null eq login.id}">
			<li class="nav-item"><a class="nav-link" href="loginui.do">로그인</a></li>
			<li class="nav-item"><a class="nav-link" href="insertui.do">회원가입</a></li>
		</c:if>
	</ul>
	</div>
	<br>
	<br>
	<div class="container">
		<h2>게시글 목록</h2>
		<br>
		<div class="btn-group-lg" name="locationCode" id="locationCode">
			<a href="list.do?curPage=1&locationCode=0" class="btn btn-outline-primary" role="button">전체</a>
			<a href="list.do?curPage=1&locationCode=2" class="btn btn-outline-primary" role="button" value="2">서울</a>
			<a href="list.do?curPage=1&locationCode=51" class="btn btn-outline-primary" role="button" value="51">부산</a>
			<a href="list.do?curPage=1&locationCode=53" class="btn btn-outline-primary" role="button" value="53">대구</a>
			<a href="list.do?curPage=1&locationCode=32" class="btn btn-outline-primary" role="button" value="32">인천</a>
			<a href="list.do?curPage=1&locationCode=62" class="btn btn-outline-primary" role="button" value="62">광주</a>
			<a href="list.do?curPage=1&locationCode=42" class="btn btn-outline-primary" role="button" value="42">대전</a>
			<a href="list.do?curPage=1&locationCode=52" class="btn btn-outline-primary" role="button" value="52">울산</a>
			<a href="list.do?curPage=1&locationCode=44" class="btn btn-outline-primary" role="button" value="44">세종</a>
			<a href="list.do?curPage=1&locationCode=31" class="btn btn-outline-primary" role="button" value="31">경기</a>
			<a href="list.do?curPage=1&locationCode=33" class="btn btn-outline-primary" role="button" value="33">강원</a>
			<a href="list.do?curPage=1&locationCode=43" class="btn btn-outline-primary" role="button" value="43">충북</a>
			<a href="list.do?curPage=1&locationCode=41" class="btn btn-outline-primary" role="button" value="41">충남</a>
			<a href="list.do?curPage=1&locationCode=63" class="btn btn-outline-primary" role="button" value="63">전북</a>
			<a href="list.do?curPage=1&locationCode=61" class="btn btn-outline-primary" role="button" value="61">전남</a>
			<a href="list.do?curPage=1&locationCode=54" class="btn btn-outline-primary" role="button" value="54">경북</a>
			<a href="list.do?curPage=1&locationCode=55" class="btn btn-outline-primary" role="button" value="55">경남</a>
			<a href="list.do?curPage=1&locationCode=64" class="btn btn-outline-primary" role="button" value="63">제주</a>
			<a href="list.do?curPage=1&locationCode=1" class="btn btn-outline-primary" role="button" value="1">기타</a>
			<br> <br>

			<table class="table">
				<thead>
					<tr>
						<th>번호</th>
						<th>지역</th>
						<th>제목</th>
						<th>글쓴이</th>
						<th>날짜</th>
						<th>조회수</th>
						<th>repRoot</th>
						<th>repStep</th>
						<th>repIndent</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${list}" var="dto">
						<tr>
							<td>${dto.num}</td>
							<td>${dto.locationName}</td>
							<td width="200px"><c:forEach begin="1" end="${dto.repIndent}">
						&nbsp;&nbsp; Re:
					</c:forEach> <a href="read.do?num=${dto.num}">${dto.title}</a></td>
							<td>${dto.writer}</td>
							<td>${dto.writeday}</td>
							<td>${dto.readcnt}</td>
							<td>${dto.repRoot}</td>
							<td>${dto.repStep}</td>
							<td>${dto.repIndent}</td>
						</tr>
					</c:forEach>

				</tbody>

			</table>
		</div>
		<br>
		<c:if test="${(to.curPage-1) > 0 }">
			<a style="text-decoration: none;" href="list.do?locationCode=${param.locationCode}&curPage=${to.curPage-1}">&laquo;</a>
		</c:if>
		&nbsp;
		<c:forEach begin="${to.beginPageNum}" end="${to.stopPageNum}" var="idx">
			<c:if test="${to.curPage == idx}">
				<a style="font-size: 20px; text-decoration: none;" href="list.do?locationCode=${paramlocationCode}&curPage=${idx}">&nbsp;${idx}&nbsp;</a>&nbsp;
		</c:if>
			<c:if test="${to.curPage != idx}">
				<a style="text-decoration: none;" href="list.do?locationCode=${param.locationCode}&curPage=${idx}">${idx}</a>&nbsp;&nbsp;
		</c:if>
		</c:forEach>

		<c:if test="${to.curPage != to.totalPage}">
			<a style="text-decoration: none;" href="list.do?locationCode=${param.locationCode}&curPage=${to.curPage + 1}">&raquo;</a>
		</c:if>

		<br> <br>
		<c:if test="${null ne login.id}">
			<a href="writeui.do" class="btn btn-outline-primary">글쓰기</a>
		</c:if>
</body>
</html>