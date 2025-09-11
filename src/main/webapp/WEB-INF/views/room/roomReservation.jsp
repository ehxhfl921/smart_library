<!-- 스터디룸 예약 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="hyojin">
<aside class="rooms-sidebar">
    <ul>
    	<li><a>도서관 이용</a></li>
        <li><a href="${path}/libraryInfo">이용 안내</a></li>
        <li><a href="${path}/studyroom" class="active">스터디룸 예약</a></li>
    </ul>
</aside>
	<main class="content">
      <h2>스터디룸 예약</h2>

      <div class="date-selection">
        <input type="date" class="date-input">
        <button class="select-button">선택</button>
      </div>

      <div class="extra-box">
        <!-- 예약 정보 또는 내용 -->
      </div>
    </main>
</section>

<%@ include file="../common/footer.jsp" %>