<!-- 내가 작성한 건의사항 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="hyojin">
	 <main class="content">
      <div class="main-header">
        <h2>건의사항</h2>
        <button class="write-btn">작성</button>
      </div>

      <div class="notice-header">
        <span>No.</span>
        <span>제목</span>
        <span>작성자</span>
        <span>작성일</span>
      </div>
      <div class="notice-list">
      </div>
    </main>
</section>

<%@ include file="../common/footer.jsp" %>