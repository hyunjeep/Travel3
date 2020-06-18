<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
	<a class="navbar-brand" href="main.jsp">Main</a>
	<button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
		<span class="navbar-toggler-icon"></span>
	</button>
	<div class="collapse navbar-collapse" id="collapsibleNavbar">
		<ul class="navbar-nav">
			<li class="nav-item"><a class="nav-link" href="${empty login.id ? 'loginui.do' : 'memberinfo.do?id='}${login.id}">${empty login.id ? '로그인' : '회원정보'}</a></li>
			<li class="nav-item"><a class="nav-link" href="#">추천 여행지</a></li>
			<li class="nav-item"><a class="nav-link" href="list.do?curPage=1&locationCode=0">여행 메이트 게시판</a></li>
			<li class="nav-item"><a class="nav-link" href="#">숙박 정보</a></li>
			<li class="nav-item"><a class="nav-link" href="#">맛집 정보</a></li>
			<li class="nav-item"><a class="nav-link" href="#">공지 사항</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Q&amp;A</a></li>
		</ul>
	</div>
</nav>