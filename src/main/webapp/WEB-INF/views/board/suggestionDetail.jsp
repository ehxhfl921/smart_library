<!-- 건의 사항 상세 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="hyojin">
	<main class="content">
      <h2>건의사항</h2>
      <div class="notice-header">
        <span>No.</span>
        <span>제목</span>
        <span>작성자</span>
        <span>작성일</span>
      </div>
      <div class="notice-list"></div>

      <div class="notice-footer">
        <div class="button">수정</div>
        <div class="button">삭제</div>
      </div>

      <!-- 댓글 섹션 -->
      <div class="comment-section">
        <h3>댓글</h3>
        <div class="comment-list"></div>
        <div class="comment-form">
          <input type="text" class="comment-input" placeholder="댓글을 입력하세요">
          <button class="comment-btn">수정</button>
          <button class="comment-btn">삭제</button>
        </div>
      </div>
    </main>
</section>

<%@ include file="../common/footer.jsp" %>