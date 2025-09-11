<!-- 공지 사항 상세 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="hyojin">
<aside class="notice-sidebar">
    <ul>
    <li><a>열린공간</a></li>
    <li><a href="${path}/notice/list" class="active">공지 사항</a></li>
    <li><a href="${path}/suggest/list">건의 사항</a></li>
    </ul>
</aside>
	 <main class="content">
            <h2>공지사항</h2>
            <div class="notice-header">
                <span>No.</span>
                <span>제목</span>
                <span>작성자</span>
                <span>작성일</span>
            </div>
            <div class="notice-list">
            </div>
            <div class="notice-footer">
                <div class="button">수정</div>
                <div class="button">삭제</div>
            </div>
        </main>
</section>

<%@ include file="../common/footer.jsp" %>