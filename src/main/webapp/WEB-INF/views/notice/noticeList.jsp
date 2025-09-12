<!-- 공지 사항 목록 페이지 -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="f" %>
<%@ include file="../common/header.jsp" %>

<section class="jinju1">
 	<main class="content">
    <h2 class="up">공지사항</h2>
    <button class="btn" onclick="if(confirm('공지 사항을 작성하시겠습니까?'))location.href='${path}/notice/register';">작성</button>

  
  <table class="form-table">
    <thead>
      <tr>
        <th>No.</th>
        <th>제목</th>
        <th>작성자</th>
        <th>작성일</th>
      </tr>
    </thead>
    <tbody>
      <c:forEach var="notice" items="${list}">
        <tr>
          <td>${notice.nno}</td>
          <td>
            <a href="${path}/notice/read?id=${notice.nno}">${notice.n_title}</a>
          </td>
          <td>${notice.n_author}</td>
          <td>
            <f:formatDate value="${notice.n_create_date}" pattern="yyyy-MM-dd" />
          </td>
        </tr>
      </c:forEach>
    </tbody>
  </table>

  <!-- ✅ 페이징 -->
  <div class="pagination">
    <c:if test="${pm.first}">
      <a href="?page=1">[&laquo;]</a>
    </c:if>
    <c:if test="${pm.prev}">
      <a href="?page=${pm.startPage - 1}">[&lt;]</a>
    </c:if>
    <c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
      <a href="?page=${i}" class="${i == param.page ? 'active' : ''}">[${i}]</a>
    </c:forEach>
    <c:if test="${pm.next}">
      <a href="?page=${pm.endPage + 1}">[&gt;]</a>
    </c:if>
    <c:if test="${pm.last}">
      <a href="?page=${pm.maxPage}">[&raquo;]</a>
    </c:if>
  </div>
  </main>
</section>

<%@ include file="../common/footer.jsp" %>