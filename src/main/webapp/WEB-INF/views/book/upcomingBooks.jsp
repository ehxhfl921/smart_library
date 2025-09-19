<!-- 출간 예정 도서 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../common/header.jsp" %>

<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>

<section class="upcomingBooks">

    <!-- 사이드바 -->
    <aside class="sidebar">
        <div class="sidebar-header">자료 찾기</div>
        <div class="sidebar-item"><a href="${path}/book/search">도서 검색</a></div>
        <div class="sidebar-item">
            <a href="${path}/upcoming"
               style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">
               출간 예정 도서
            </a>
        </div>
    </aside>

    <!-- 메인 콘텐츠 -->
    <main class="content">
        <h2>출간 예정 도서</h2>
        <hr style="margin: 10px 0;">

        <!-- 도서 리스트 -->
        <div id="upcomingList">
            <c:choose>
                <c:when test="${not empty list}">
                    <c:forEach var="book" items="${list}">
                        <div id="bookCard">

                            <!-- 책 표지 -->
                            <div class="coverBox">
                                <c:if test="${not empty book.img_src}">
                                    <img src="${book.img_src}" alt="${book.title}">
                                </c:if>
                                <c:if test="${empty book.img_src}">
                                    <img src="${path}/resources/images/no-cover.png" alt="no cover">
                                </c:if>
                            </div>

                            <!-- 책 정보 -->
                            <div class="bookInfo">
                                <div class="info-left">제목</div>
                                <div class="info-right">
                                    <c:choose>
                                        <c:when test="${not empty book.link}">
                                            <a href="${book.link}" target="_blank">${book.title}</a>
                                        </c:when>
                                        <c:otherwise>
                                            ${book.title}
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="info-left">저자</div>
                                <div class="info-right">${book.author}</div>

                                <div class="info-left">출판사</div>
                                <div class="info-right">${book.publisher}</div>

                                <div class="info-left">출간일</div>
                                <div class="info-right">
                                    <fmt:formatDate value="${book.p_date}" pattern="yyyy-MM-dd"/>
                                </div>

                                <div class="info-left">유형</div>
                                <div class="info-right">${book.book_type}</div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <p class="none">출간 예정 도서가 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 페이지네이션 -->
        <div id="pagenation">
            <c:if test="${not empty pm}">
                <c:if test="${pm.first}">
                    <button id="textBtn" onclick="location.href='${path}/upcoming?page=1'">처음</button>
                </c:if>

                <c:if test="${pm.prev}">
                    <button id="textBtn" onclick="location.href='${path}/upcoming?page=${pm.startPage-1}'">이전</button>
                </c:if>

                <c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
                    <button class="pageBtn"
                            <c:if test="${i == pm.cri.page}">id="active"</c:if>
                            onclick="location.href='${path}/upcoming?page=${i}'">${i}</button>
                </c:forEach>

                <c:if test="${pm.next}">
                    <button id="textBtn" onclick="location.href='${path}/upcoming?page=${pm.endPage+1}'">다음</button>
                </c:if>

                <c:if test="${pm.last}">
                    <button id="textBtn" onclick="location.href='${path}/upcoming?page=${pm.maxPage}'">마지막</button>
                </c:if>
            </c:if>
        </div>

    </main>
</section>

<%@ include file="../common/footer.jsp" %>
