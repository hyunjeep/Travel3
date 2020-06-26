<%@page import="java.util.List"%>
<%@page import="kr.co.dto.FileDTO"%>
<%@ page import="kr.co.dto.PageTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmf"%>

<jsp:useBean id="now" class="java.util.Date" />
<fmf:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss" var="today" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%@ include file="./com/head.jsp"%>
</head>
<body>
	<%@ include file="./com/top.jsp"%>
	<%@ include file="./com/navbar.jsp"%>
	<br>

	<div class="container">
		<div class="d-flex">
			<div class="mr-auto">
				<h3>mate</h3>
			</div>
			<div>
				<c:if test="${null ne login.id}">
					<a href="writeui.do?curPage=${null ? 1 : param.curPage}&locationCode=${locationCode}" class="btn btn-outline-primary">글쓰기</a>
				</c:if>
				<c:if test="${null eq login.id}">
					<button class="btn btn-success" onclick="if(confirm('로그인 후 이용해주세요'))location.href='loginui.jsp';" type="button">글쓰기</button>
				</c:if>
			</div>
		</div>
		<br>
		<div class="btn-group-md" name="locationCode" id="locationCode">
			<c:forEach items="${locationList}" var="dto">
				<a href="list.do?curPage=1&locationCode=${dto.locationCode}"
					class="btn btn-outline-primary ${locationCode eq dto.locationCode ? 'active' : '' } my-1" role="button" value="${dto.locationCode}">#${dto.locationName}</a>
			</c:forEach>
		</div>
		<br>
		<table class="table table-hover">
			<thead style="text-align: center">
				<tr>
					<th>번호</th>
					<th>지역</th>
					<th>제목</th>
					<th>글쓴이</th>
					<th>날짜</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${list}" var="dto">
					<tr>
						<td style="text-align: center">${dto.num}</td>
						<td style="text-align: center">${dto.locationName}</td>
						<td width="350px"><c:forEach begin="1" end="${dto.repIndent}">
						&nbsp;&nbsp;<svg class="bi bi-arrow-return-right" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M10.146 5.646a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708-.708L12.793 9l-2.647-2.646a.5.5 0 0 1 0-.708z" />
  <path fill-rule="evenodd" d="M3 2.5a.5.5 0 0 0-.5.5v4A2.5 2.5 0 0 0 5 9.5h8.5a.5.5 0 0 0 0-1H5A1.5 1.5 0 0 1 3.5 7V3a.5.5 0 0 0-.5-.5z" /></svg>
							</c:forEach> <a href="read.do?curPage=${to.curPage}&locationCode=${locationCode}&num=${dto.num}">${dto.title}</a> &nbsp; <c:forEach items="${fileNumList}"
								var="fto">
								<c:if test="${dto.num eq fto.fileNum}">
									<svg class="bi bi-card-image" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  									<path fill-rule="evenodd" d="M14.5 3h-13a.5.5 0 0 0-.5.5v9a.5.5 0 0 0 .5.5h13a.5.5 0 0 0 .5-.5v-9a.5.5 0 0 0-.5-.5zm-13-1A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5v-9A1.5 1.5 0 0 0 14.5 2h-13z" />
  									<path d="M10.648 7.646a.5.5 0 0 1 .577-.093L15.002 9.5V13h-14v-1l2.646-2.354a.5.5 0 0 1 .63-.062l2.66 1.773 3.71-3.71z" />
  									<path fill-rule="evenodd" d="M4.502 7a1.5 1.5 0 1 0 0-3 1.5 1.5 0 0 0 0 3z" />
								</svg>
								</c:if>
							</c:forEach></td>
						<td style="text-align: center">${dto.writer}</td>
						<c:choose>
							<c:when test="${fn:substring(today,0,10) eq fn:substring(dto.writeday,0,10)}">
								<td style="text-align: center">${fn:substring(dto.writeday,11,16)}</td>
							</c:when>
							<c:otherwise>
								<td style="text-align: center">${fn:substring(dto.writeday,0,10)}</td>
							</c:otherwise>
						</c:choose>
						<td style="text-align: center">${dto.readcnt}</td>

					</tr>
				</c:forEach>

			</tbody>

		</table>
	</div>
	<br>
	<ul class="pagination justify-content-center">
		<li class="page-item ${to.curPage <= 1 ? 'disabled' : '' }"><a class="page-link"
				href="list.do?curPage=1&locationCode=${locationCode > 0 ? locationCode : 0}">&nbsp;<svg class="bi bi-chevron-double-left" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M8.354 1.646a.5.5 0 0 1 0 .708L2.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
  <path fill-rule="evenodd" d="M12.354 1.646a.5.5 0 0 1 0 .708L6.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z"/>
&nbsp;</svg></a></li>
		<li class="page-item ${to.curPage <= 1 ? 'disabled' : '' }"><a class="page-link"
				href="list.do?curPage=${idx > 1 ? (idx -1) : 1}&locationCode=${locationCode > 0 ? locationCode : 0}">
				&nbsp;<svg class="bi bi-chevron-left" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z" /></svg>&nbsp;</a></li>
		<c:forEach begin="${to.beginPageNum}" end="${to.stopPageNum}" var="idx">
			<li class="page-item ${to.curPage eq idx ? 'active' : '' }"><a class="page-link"
					href="list.do?curPage=${idx}&locationCode=${locationCode > 0 ? locationCode : 0}">${idx}</a></li>
		</c:forEach>
		<li class="page-item ${to.curPage >= to.totalPage ? 'disabled' : ''}"><a class="page-link"
				href="list.do?curPage=${idx < to.totalPage ? (idx +1) : to.totalPage}&locationCode=${locationCode > 0 ? locationCode : 0}">
				&nbsp;
				<svg class="bi bi-chevron-right" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z" />
</svg>&nbsp;</a></li>
<li class="page-item ${to.curPage >= to.totalPage ? 'disabled' : ''}"><a class="page-link"
				href="list.do?curPage=${to.totalPage}&locationCode=${locationCode > 0 ? locationCode : 0}">
				&nbsp;
				<svg class="bi bi-chevron-double-right" width="1em" height="1em" viewBox="0 0 16 16" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  <path fill-rule="evenodd" d="M3.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L9.293 8 3.646 2.354a.5.5 0 0 1 0-.708z"/>
  <path fill-rule="evenodd" d="M7.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L13.293 8 7.646 2.354a.5.5 0 0 1 0-.708z"/>
</svg>&nbsp;</a></li>
	</ul>
	<br>
	<br>
	<%@ include file="./com/footer.jsp"%>
</body>
</html>