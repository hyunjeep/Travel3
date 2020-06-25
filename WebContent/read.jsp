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
	<div class="container">
		<%
			BoardDTO dto = (BoardDTO) request.getAttribute("dto");
		%>

		<h4 style="margin-bottom: 1rem">${dto.title}</h4>
		<table class="table">
			<thead>
				<tr>
					<th><svg class="bi bi-calendar" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1zm1-3a2 2 0 0 0-2 2v11a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V3a2 2 0 0 0-2-2H2z" />
  <path fill-rule="evenodd" d="M3.5 0a.5.5 0 0 1 .5.5V1a.5.5 0 0 1-1 0V.5a.5.5 0 0 1 .5-.5zm9 0a.5.5 0 0 1 .5.5V1a.5.5 0 0 1-1 0V.5a.5.5 0 0 1 .5-.5z" />
</svg> ${dto.writeday} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<svg class="bi bi-tag" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M.5 2A1.5 1.5 0 0 1 2 .5h4.586a1.5 1.5 0 0 1 1.06.44l7 7a1.5 1.5 0 0 1 0 2.12l-4.585 4.586a1.5 1.5 0 0 1-2.122 0l-7-7A1.5 1.5 0 0 1 .5 6.586V2zM2 1.5a.5.5 0 0 0-.5.5v4.586a.5.5 0 0 0 .146.353l7 7a.5.5 0 0 0 .708 0l4.585-4.585a.5.5 0 0 0 0-.708l-7-7a.5.5 0 0 0-.353-.146H2z" />
  <path fill-rule="evenodd" d="M2.5 4.5a2 2 0 1 1 4 0 2 2 0 0 1-4 0zm2-1a1 1 0 1 0 0 2 1 1 0 0 0 0-2z" /></svg>
  ${dto.locationName} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<svg class="bi bi-person-circle" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg"><path d="M13.468 12.37C12.758 11.226 11.195 10 8 10s-4.757 1.225-5.468 2.37A6.987 6.987 0 0 0 8 15a6.987 6.987 0 0 0 5.468-2.63z" />
  <path fill-rule="evenodd" d="M8 9a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" /> <path fill-rule="evenodd" d="M8 1a7 7 0 1 0 0 14A7 7 0 0 0 8 1zM0 8a8 8 0 1 1 16 0A8 8 0 0 1 0 8z" /></svg>
  ${dto.writer} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
  <svg class="bi bi-eye-fill" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg"><path d="M10.5 8a2.5 2.5 0 1 1-5 0 2.5 2.5 0 0 1 5 0z" /><path fill-rule="evenodd" d="M0 8s3-5.5 8-5.5S16 8 16 8s-3 5.5-8 5.5S0 8 0 8zm8 3.5a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7z" /></svg>
   ${dto.readcnt}</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><br>
					<img src="upload/${fileName}" class="mx-auto d-block img-thumbnail"> <br>
					<br> ${dto.content} <br>
									</td></tr>
			</tbody>
		</table>
					<div class="d-flex">
						<div class="mr-auto">
							<c:if test="${dto.writer eq login.id}">
								<a class="btn btn-outline-primary" href="modifyui.do?curPage=${curPage}&locationCode=${locationCode}&num=${dto.num}">수정</a>
								<a class="btn btn-outline-primary" href="delete.do?num=${dto.num}">삭제</a>
							</c:if>
							<c:if test="${null ne login.id}">
								<a class="btn btn-outline-primary" href="replyui.do?curPage=${curPage}&locationCode=${locationCode}&num=${dto.num}">답글</a>
							</c:if>
							<a class="btn btn-outline-primary" href="list.do?curPage=${curPage}&locationCode=${locationCode}">목록</a>
						</div>
						<div>
							<a class="btn btn-primary ${dto.num <= 1 ? 'disabled' : ''}" href="read.do?curPage=${curPage}&locationCode=${locationCode}&num=${(dto.num)-1}">이전</a>
							<a class="btn btn-primary ${dto.num eq totalNum ? 'disabled' : ''}"
								href="read.do?curPage=${curPage}&locationCode=${locationCode}&num=${(dto.num)+1}">다음</a>
						</div>
					</div>

	</div>
	<br>
	<br>
	<%@ include file="./com/footer.jsp"%>
</body>
</html>