<!-- 이용 안내 페이지  -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="hyojin">
<aside class="suggestion-sidebar">
    <ul>
    <li><a>열린공간</a></li>
    <li><a href="${path}/notice/list">공지 사항</a></li>
    <li><a href="${path}/suggest/list">건의 사항</a></li>
    </ul>
</aside>
    <main class="content">
      <h2>이용 안내</h2>
      <div class="notice-header">
      </div>
      <div class="notice-list">
      </div>
    </main>
</section>

<%@ include file="../common/footer.jsp" %>