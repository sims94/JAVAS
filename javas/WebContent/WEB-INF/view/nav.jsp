<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.navbar-default .navbar-nav>li>a {
	color: black;
}
</style>
<!--  navigator  
   navbar-default
   navbar-inverse
-->
<div class="navbar navbar-default"
	style="padding-left: 205px; padding-right: 213px; background-color: white; background-image: none; color: black; margin: 0;">
	<div class="navbar-header">
		<button type="button" class="navbar-toggle" data-toggle="collapse"
			data-target="#myNav">
			<span class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
		</button>
	</div>
	<div class="collapse navbar-collapse" id="myNav"
		style="background-color: white;">
		<c:choose>
			<c:when test="${auth eq null }">
				<ul class="nav navbar-nav navbar-right">
					<li><a href="/user/join.jv" style="color: #939393;"><span
							class="glyphicon glyphicon-user"></span> 회원가입</a></li>
					<li><a href="/user/login.jv" style="color: #939393;"> <span
							class="glyphicon glyphicon-log-in"></span> 로그인
					</a></li>
				</ul>
			</c:when>
				<c:otherwise>
					<ul class="nav navbar-nav">
						<li><p class="navbar-text" style="color: black;">
								<b>${auth }</b>님 환영합니다 (<b>${point}</b> P)
							</p></li>
					</ul>
					<ul class="nav navbar-nav navbar-right">
					<c:if test="${auth ne 'admin' }">
						<li><a href="/store/main.jv" style="color: #939393;"><span
								class="glyphicon glyphicon-gift"></span> 상점</a></li>
						<li><a href="/memo/list.jv" style="color: #939393;"><span
								class="glyphicon glyphicon-envelope"></span> 쪽지함 ${memo }</a></li>
						<li><a href="/user/userInfo.jv" style="color: #939393;"><span
								class="glyphicon glyphicon-wrench"></span> 정보수정</a></li>
						</c:if>
						<li><a href="/user/logout.jv" style="color: #939393;"><span
								class="glyphicon glyphicon-log-out"></span> 로그아웃</a></li>
					</ul>
				</c:otherwise>
		</c:choose>
	</div>
	<hr style="background-color: #939393; margin: 0" />
	<div class="collapse navbar-collapse" id="myNav"
		style="background-color: white;">
		<ul class="nav navbar-nav">
			<li><a href="/" style="padding-left: 0;"><img alt="javas"
					src="/style/javas.png"></a>
		</ul>
		<ul class="nav navbar-nav navbar-right"
			style="font-size: 14pt; margin-top: 17px; font-weight: 600;">
			<c:choose>
				<c:when test="${auth eq 'admin' }">
	
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">게시판관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="/question/list.jv">Q&A</a></li>
							<li><a href="/freetalk/allTalks.jv">공유게시판</a></li>
						</ul></li>

					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="/admin/member.jv">회원명단</a></li>
							<li><a href="/admin/statistics.jv">회원통계</a></li>
						</ul></li>
				</c:when>
				<c:otherwise>

					<li><a href="/menuer.jv">메뉴얼</a></li>
					<li><a href="/question/list.jv">Q&A</a></li>
					<li><a href="/freetalk/allTalks.jv">공유게시판</a></li>
					<li class="dropdown"><a class="dropdown-toggle"
						data-toggle="dropdown" href="#">JAVAS<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="/function/weather.jv">날씨</a></li>
							<li><a href="/function/map.jv">길찾기</a></li>
							<c:if test="${calendar ne null or full ne null or d ne null }">
								<li><a href="/function/calendar.jv">캘린더</a></li>
							</c:if>
							<c:if test="${asset ne null or full ne null or d ne null }">
								<li><a href="/function/asset.jv">자산관리</a></li>
							</c:if>
							<c:if test="${fitness ne null or full ne null }">
								<li><a href="/function/fitness.jv">건강</a></li>
							</c:if>
						</ul></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</div>
</div>
<c:if test="${nav ne 'on'}">
	<div
		style="background-color: Lavender; margin-top: 0; padding-left: 218px;">
		<h1
			style="margin: 0; color: white; font-size: 14pt; padding-top: 10px; padding-bottom: 10px; padding-left: 2px;">${title }</h1>
	</div>
</c:if>