<!-- 내 서재 / 스터디룸 이용 내역 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="hyojin">
<aside class="rooms-sidebar">
    <ul>
    	<li><a>도서관 이용</a></li>
        <li><a href="${path}/libraryInfo" class="active">이용 안내</a></li>
        <li><a href="${path}/studyroom">스터디룸 예약</a></li>
    </ul>
</aside>
	 <main class="content">
      <h2>스터디룸 이용 내역</h2>
      <div class="notice-header">
        <span>스터디룸 번호</span>
        <span>예약 희망일</span>
        <span>예약 신청일</span>
        <span>예약 상태</span>
      </div>
      <div class="notice-list">
      </div>
    </main>
</section>

<%@ include file="../common/footer.jsp" %>