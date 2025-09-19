<!-- 출간 예정 페이지 -->

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

<section class="searchBook">

    <!-- 사이드바 -->
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

    <!-- 메인 콘텐츠 -->
    <main class="content">
        <h2>출간 예정 도서</h2>
        <hr style="margin: 10px 0;">
		<div class="upcomingInfo">
			<p>* 출간 예정 도서 목록은 소장 도서 목록과 상이합니다. 소장 도서 검색은 '도서 검색' 탭을 이용해 주세요.</p>
			<p>* 현재 목록은 2025-09-19 기준 한 달 이내 출간 예정 도서입니다. 이후 출간 예정 도서는 한 달 단위로 매달 1일 갱신됩니다.</p>
	        <p>* 도서 클릭 시 &lt;출판 유통 통합 전산망&gt; 내 해당 도서 페이지로 이동합니다.</p>
	        <p>* 출처 : 한국 출판 문화 산업 진흥원 &lt;출판 유통 통합 전산망&gt;</p>
		</div>
        
        <!-- 출간 예정 도서 목록 -->
        <div class="upcomingBooks">
            <c:choose>
                <c:when test="${not empty list}">
                    <ul class="book-list">
                        <c:forEach var="book" items="${list}">
                            <li class="book-row"
                                <c:if test="${not empty book.link}">
                                    onclick="location.href='${book.link}';"
                                </c:if>
                                style="cursor:pointer;">
                                
                                <!-- 책 표지 -->
                                <div class="thumb">
                                    <c:if test="${not empty book.img_src}">
                                        <img src="${book.img_src}" alt="${book.title}">
                                    </c:if>
                                    <c:if test="${empty book.img_src}">
                                        <img src="${path}/resources/images/no-cover.png" alt="no cover">
                                    </c:if>
                                </div>

                                <!-- 책 정보 -->
                                <div class="info">
                                    <strong class="title">${book.title}</strong><br>
                                    저자: ${book.author} | 출판사: ${book.publisher}<br>
                                    발행일: <fmt:formatDate value="${book.p_date}" pattern="yyyy-MM-dd"/> | 
                                    유형: ${book.book_type}
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </c:when>
                <c:otherwise>
                    <p class="no-data">출간 예정 도서가 없습니다.</p>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- 페이징 -->
       <div class="pagination">

          <c:if test="${not empty pm}">
              <c:if test="${pm.first}">
                  <a href="${path}/upcoming?page=1">처음</a>
              </c:if>
      
              <c:if test="${pm.prev}">
                  <a href="${path}/upcoming?page=${pm.startPage-1}">이전</a>
              </c:if>
      
              <c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
                  <a href="${path}/upcoming?page=${i}"
                     <c:if test="${i == pm.cri.page}">class="activePage"</c:if>>
                     ${i}
                  </a>
              </c:forEach>
      
              <c:if test="${pm.next}">
                  <a href="${path}/upcoming?page=${pm.endPage+1}">다음</a>
              </c:if>
      
              <c:if test="${pm.last}">
                  <a href="${path}/upcoming?page=${pm.maxPage}">마지막</a>
              </c:if>
          </c:if>
      </div>


    </main>
</section>

<%@ include file="../common/footer.jsp" %>
