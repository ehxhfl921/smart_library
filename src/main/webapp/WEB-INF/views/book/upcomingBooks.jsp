<!-- 출간 예정 도서 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="searchBook">

<aside class="sidebar" style="width:220px;">
      <div class="sidebar-header">자료 찾기</div>
      <div class="sidebar-item"><a href="${path}/book/search">도서 검색</a></div>
      <div class="sidebar-item">
      	<a href="${path}/upcoming" 
      	   style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">
      	   출간 예정 도서
      	</a>
      </div>
</aside>

<main class="content">
	<h2>출간 예정 도서</h2>
	<hr style="margin: 10px 0;">
	
	<!-- 출간 예정 도서 목록 출력 -->
	<div class="upcomingBooks">
	
	</div>
	
 	<!-- 페이징 처리 -->
	<div class="pagination">
	
	</div>

</main>
</section>

<%@ include file="../common/footer.jsp" %>