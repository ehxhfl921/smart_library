<!-- 내 서재 / 도서 대출 내역 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="hyojin">
<aside class="book-sidebar">
    <ul>
    	<li><a>도서관 이용</a></li>
        <li><a href="${path}/libraryInfo">이용 안내</a></li>
        <li><a href="${path}/studyroom">스터디룸 예약</a></li>
    </ul>
</aside>
	<main class="content">
      <h2>나의 도서 대출 현황</h2>
      <div class="notice-header">
        <span>대출 번호</span>
        <span>책 제목</span>
        <span>저자</span>
        <span>대출일</span>
        <span>반납일</span>
        <span>대출 상태</span>
      </div>
      <div class="notice-list">
      </div>
    </main>
</section>

<%@ include file="../common/footer.jsp" %>