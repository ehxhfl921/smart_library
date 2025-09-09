<!-- 관리자 전용 / 도서 관리 - 도서 목록 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju1>
<h2>도서 목록</h2>

  <!-- 도서 목록 테이블 -->
  <table class="form-table">
    <tr>
      <th>번호</th>
      <th>제목</th>
      <th>저자</th>
      <th>출판사</th>
      <th>발행연도</th>
    </tr>

      <tr>
        <td class="center">${book.bno}</td>
        <td>
          <a href="">
            ${book.title}
          </a>
        </td>
        <td>${book.author}</td>
        <td>${book.publisher}</td>
        <td class="center">${book.p_date}</td>
      </tr>

      <tr>
        <td colspan="5" class="center">등록된 도서가 없습니다.</td>
      </tr>
  </table>

  <!-- 페이징 처리 -->
<div class="pagination">
    <a href="/book/list?page=${page-1}&size=${size}">이전</a>

          [${p}]
      <a href="/book/list?page=${p}&size=${size}">[${p}]</a>

      <a href="/book/list?page=${page+1}&size=${size}">다음</a>
  </div>
</section>

<%@ include file="../common/footer.jsp" %>