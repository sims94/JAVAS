<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<style>
.btn {
    border: none;
    color: white;
    font-size: 15px;
    cursor: pointer;
}
.bt {
	background-color: white; 
	color: black;
	 border : 1px solid gray;
} 
</style>
<div style="padding-bottom: 10px;">
	<h2>게시판</h2>
	<div class="input-group" style="padding-bottom: 15px;">
		<form action="/freetalk/allTalks.jv" id="submit">
			<select style="width: 223px;" class="form-control" name="category" id="category">
				<option value="" class="form-control">카테고리별 검색</option>
				<c:forTokens var="t" items="교통,PC관리,인터넷,기타" delims=",">
					<option value="${t}" class="form-control">${t}</option>
				</c:forTokens>
			</select>
		</form>
	</div>

	<div class="table-responsive">
		<table class="table">
			<thead>
				<tr class="Info">
					<th width="10%"></th>
					<th width="10%">카테고리</th>
					<th width="50%">제목</th>
					<th width="10%">작성자</th>
					<th width="10%">추천수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="m" items="${list}">
					<tr>
						<td>${m.NUM}</td>
						<td>${m.CATEGORY}</td>
						<td><a href="/freetalk/viewTalk.jv?num=${m.NUM}">${m.TITLE}</a>
							<c:if test="${m.CNT ne null }">[${m.CNT}]</c:if></td>
						<td>${m.WRITER eq null ? '(알수없음)' : m.WRITER}</td>
						<td style="text-align: center;"><fmt:formatNumber
								value="${m.RECOMMEND}" pattern="#,###" var="t" />${t }</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<c:if test="${empty list}">게시글이 없습니다.</c:if>
	<div style="padding-right: 20px; padding-bottom: 10px;" align="right">
		<a href="/freetalk/addNew.jv">
			<button type="button" class="btn bt">글쓰기 <span class="glyphicon glyphicon-pencil"></span></button>
		</a>
	</div>
</div>

<div align="center">
	<form action="/freetalk/allTalks.jv">
		<div class="input-group">
			<span><input type="text" class="form-control"
				placeholder="Search" name="search" style="width: 250px;"></span>&nbsp;
			<button type="submit" class="btn bt">검색 <span class="glyphicon glyphicon-search"></span></button>
		</div>
	</form>

	<ul class="pagination">
		<c:forEach var="i" begin="1" end="${size}">
			<li class="${i eq page ? 'active' :'' }"><a
				href="/freetalk/allTalks.jv?p=${i }&search=${param.search}">${i}</a></li>
		</c:forEach>
	</ul>
</div>

<script>
	$("#category").on("change", function() {
		$("#submit").submit();
	});
</script>
