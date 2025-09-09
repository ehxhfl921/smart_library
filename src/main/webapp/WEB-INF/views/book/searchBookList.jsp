<!-- 도서 검색 & 도서 목록 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="hyojin">
	 <main class="content">
      <div class="search-section">
        <h2>통합 검색</h2>
        <div class="search-box">
          <input type="text" placeholder="검색어를 입력하세요">
          <button>검색</button>
        </div>
      </div>
      <div class="info-section">
        <h3>안내 내용</h3>
        <!-- 안내 내용이 들어갈 자리 -->
      </div>
    </main>
</section>

<%@ include file="../common/footer.jsp" %>