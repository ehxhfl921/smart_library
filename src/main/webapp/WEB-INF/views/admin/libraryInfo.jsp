<!-- 관리자 전용 / 도서관 정보 수정 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju1">

<aside class="sidebar">
      <div class="sidebar-header">운영/관리</div>
      <div class="sidebar-item"><a href="${path}/user/memberList">회원 관리</a></div>
      <div class="sidebar-item"><a href="${path}/book/admin/list">도서 관리</a></div>
      <div class="sidebar-item"><a href="${path}/studyroom/admin/reservationList">스터디룸 예약 관리</a></div>
      <div class="sidebar-item" style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">
      	<a href="${path}/manageInfo">
      		도서관 정보 관리
      	</a>
      </div>
</aside>

<main class="libraryInfo">
	<div class="head">
		<h2>도서관 정보 관리</h2>
	</div>
	<hr>
	<div class="content">
		<form action="${path}/libraryInfo/modify" method="POST">
			<table class="form-table">
				<tr>
					<th>도서관 이름</th>
					<td>
						<input type="text" name="library_name" value="${info.library_name}">
					</td>
				</tr>
				<tr>
					<th>전화 번호</th>
					<td>
						<input type="text" name="tel" value="${info.tel}">
					</td>
				</tr>
				<tr>
					<th>위치</th>
					<td>
						<input type="text" name="location" value="${info.location}">
					</td>
				</tr>
				<tr>
					<th>이용 시간</th>
					<td>
						<input type="text" name="operating_hour" value="${info.operating_hour}">
					</td>
				</tr>
				<tr>
					<th>휴관일</th>
					<td>
						<input type="text" name="closed_date" value="${info.closed_date}">
					</td>
				</tr>
			</table>
			<button type="submit" class="btn">수정하기</button>
		</form>
	
	</div>
</main>

</section>

<%@ include file="../common/footer.jsp" %>

<%@ include file="../common/footer.jsp" %>