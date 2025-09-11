<!-- 건의 사항 목록 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="hyojin">
<aside class="suggestions-sidebar">
    <ul>
    <li><a>열린공간</a></li>
    <li><a href="${path}/notice/list">공지 사항</a></li>
    <li><a href="${path}/suggest/list" class="active">건의 사항</a></li>
    </ul>
</aside>
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