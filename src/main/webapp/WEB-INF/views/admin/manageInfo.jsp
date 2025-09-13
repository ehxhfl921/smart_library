<!-- 관리자 전용 / 도서관 정보 관리 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>

<section class="jinju1">

<aside class="sidebar">
      <div class="sidebar-header">운영/관리</div>
      <div class="sidebar-item"><a href="${path}/user/memberList">회원 관리</a></div>
      <div class="sidebar-item"><a href="${path}/book/admin/list">도서 관리</a></div>
      <div class="sidebar-item"><a href="${path}/studyroom/admin/reservationList">스터디룸 예약 관리</a></div>
      <div class="sidebar-item">
      	<a href="${path}/manageInfo"  style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">
      		도서관 정보 관리
      	</a>
      </div>
</aside>

<main class="libraryInfo">
	<div class="head">
		<h2>도서관 정보 관리</h2>
		<button onclick="if(confirm('도서관 정보를 수정하시겠습니까?'))location.href='${path}/libraryInfo/modify';">도서관 정보 수정</button>
	</div>
	<hr>
	<div class="content">
		<p class="libName">• ${info.library_name}</p>
		<p>▶ 전화 번호 : <span>${info.tel}</span></p>
		<p>▶ 위치 : <span>${info.location}</span></p>
		<p>▶ 이용 시간 : <span>${info.operating_hour}</span></p>
		<p>▶ 휴관일 : <span>${info.closed_date}</span></p>
		
		<br>
		<p>- 모든 도서의 대출 기간은 2주입니다. 반납일에 꼭 반납해 주세요.</p>
		<p>- 휴관일에는 스터디룸 이용이 불가합니다. 휴관일에 예약 신청하실 경우 예약이 거절됩니다.</p>
	</div>
</main>

</section>

<%@ include file="../common/footer.jsp" %>
