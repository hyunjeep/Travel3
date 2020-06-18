<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<div class="jumbotron text-center" style="margin-bottom: 0">
	<p>Footer</p>

	<ul class="nav">
		<c:if test="${null ne login.id }">
			<li class="nav-item"><a class="nav-link active" href="logout.do?id=${login.id }">로그아웃</a></li>
		</c:if>
		<c:if test="${null eq login.id }">
			<li class="nav-item"><a class="nav-link" href="loginui.do">로그인</a></li>
			<li class="nav-item"><a class="nav-link" href="insertui.do">회원가입</a></li>
		</c:if>
	</ul>
</div>