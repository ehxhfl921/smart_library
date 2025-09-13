<!-- 이용 안내 페이지  -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju1">

<aside class="sidebar" style="width:220px;">
      <div class="sidebar-header">도서관 이용</div>
      <div class="sidebar-item">
      	<a href="${path}/libraryInfo" 
      	   style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">
      	   이용 안내
      	</a>
      </div>
      <div class="sidebar-item"><a href="${path}/studyroom">스터디룸 예약</a></div>
</aside>

<main class="libraryInfo">
	<h2>이용 안내</h2>
	<hr>
	<div class="content">
		<p class="libName">• ${info.library_name}</p>
		<p>▶ 전화 번호 : <span>${info.tel}</span></p>
		<p>▶ 위치 : <span>${info.location}</span></p>
		<p>▶ 이용 시간 : <span>${info.operating_hour}</span></p>
		<p>▶ 휴관일 : <span>${info.closed_date}</span></p>
		
		<br>
		<p>- 모든 도서의 대출 기간은 2주입니다. 반납일에 꼭 반납해 주세요.</p>
		<p>- 휴관일에는 스터디룸 이용이 불가합니다. 휴관일로 예약 시 예약이 거절됩니다.</p>
	</div>
</main>

</section>

<%@ include file="../common/footer.jsp" %>