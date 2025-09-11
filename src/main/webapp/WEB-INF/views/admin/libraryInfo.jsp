<!-- 관리자 전용 / 스터디룸 예약 관리 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju1>
<aside class="admin-sidebar">
    <ul>
      <li><a href="${path}/user/memberList" class="active">회원 관리</a></li>
      <li><a href="${path}/book/admin/list">도서 관리</a></li>
      <li><a href="${path}/studyroom/admin/reservationList">스터디룸 예약 관리</a></li>
      <li><a href="${path}/libraryInfo">도서관 정보</a></li>
    </ul>
</aside>

<main class="content">
    <h2>도서관 정보</h2>
    <div class="infoTitle">
    
    </div>
    <div class="infoContent">
    
    </div>
</main>
</section>

<%@ include file="../common/footer.jsp" %>