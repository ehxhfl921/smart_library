<!-- 관리자 전용 / 도서 관리 - 도서 목록 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>

<section class="jinju1">

<aside class="sidebar">
      <div class="sidebar-header">운영/관리</div>
      <div class="sidebar-item"><a href="${path}/user/memberList">회원 관리</a></div>
      <div class="sidebar-item">
      	<a href="${path}/book/admin/list" 
      	   style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">
      	   도서 관리
      	</a>
      </div>
      <div class="sidebar-item"><a href="${path}/studyroom/admin/reservationList">스터디룸 예약 관리</a></div>
      <div class="sidebar-item"><a href="${path}/manageInfo">도서관 정보 관리</a></div>
</aside>

<main class="manageBook">
<div class="newBookBtnBox">
	<h2>도서 관리</h2>
	<button class="btn" onclick="if(confirm('신규 도서를 등록하시겠습니까?'))location.href='${path}/book/admin/register';">
		신규 도서 등록
	</button>
</div>
<hr>
  <!-- 도서 목록 테이블 -->
  <table class="form-table">
    <tr>
      <th>번호</th>
      <th>제목</th>
      <th>저자</th>
      <th>발행 기관</th>
      <th>발행 연도</th>
    </tr>

<c:choose>
	<c:when test="${not empty list}"> 
		<c:forEach var="book" items="${list}">
	      <tr>
	        <td class="center">${book.bno}</td>
	        <td>
	          <a href="${path}/book/admin/${book.bno}?page=1">
	            ${book.title}
	          </a>
	        </td>
	        <td>${book.author}</td>
	        <td>${book.publisher}</td>
	        <td class="center">${book.p_date}</td>
	      </tr>
		</c:forEach>
	</c:when>
	<c:otherwise>
      <tr>
        <td colspan="5" class="center">등록된 도서가 없습니다.</td>
      </tr>
    </c:otherwise>
</c:choose>
  </table>

  <!-- 페이징 처리 -->
<c:choose>
	<c:when test="${not empty pm}"> 
		<div class="pagination">
		
			<c:if test="${pm.first}">
	    		<a href="${path}/book/admin/list?page=1">처음</a>
	    	</c:if>

			<c:if test="${pm.prev}">
	    		<a href="${path}/book/admin/list?page=${pm.startPage-1}">이전</a>
	    	</c:if>
	    	
			<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
			      	<a href="${path}/book/admin/list?page=${i}"
			      	   <c:if test='${i == pm.cri.page}'> class='activePage' </c:if> >
			      		[${i}]
			      	</a>
  			</c:forEach>
		
			<c:if test="${pm.next}">
	    		<a href="${path}/book/admin/list?page=${pm.endPage+1}">다음</a>
	    	</c:if>
	    	
	    	<c:if test="${pm.last}">
		      	<a href="${path}/book/admin/list?page=${pm.maxPage}">마지막</a>
		    </c:if>
		</div>
  	</c:when>
</c:choose>
</main>
</section>

<%@ include file="../common/footer.jsp" %>