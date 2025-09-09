<!-- 관리자 전용 - 도서 정보 수정 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju1>
<div class="container">

    <h2>도서 정보 수정</h2>

    <form action="/book/register" method="post">
      <table class="form-table">
        <tr>
          <th>제목</th>
          <td><input type="text" name="title"></td>
        </tr>
        <tr>
          <th>저자</th>
          <td><input type="text" name="author"></td>
        </tr>
        <tr>
          <th>출판사</th>
          <td><input type="text" name="publisher"></td>
        </tr>
        <tr>
          <th>발행연도</th>
          <td><input type="date" name="p_date"></td>
        </tr>
      </table>

      <!-- 버튼 중앙 정렬 -->
      <div style="text-align:center; margin-top:16px;">
        <input type="file" name="file">
        <input type="submit" value="수정" class="btn">
      </div>
    </form>
  </div>
</section>

<%@ include file="../common/footer.jsp" %>