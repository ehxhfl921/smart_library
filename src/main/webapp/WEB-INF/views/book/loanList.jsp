<!-- 내 서재 / 도서 대출 내역 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju1">

<aside class="sidebar" style="width:220px;">
      <div class="sidebar-header">내 서재</div>
      <div class="sidebar-item">
      	<a href="${path}/book/myPage/loans?page=1" 
      	   style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">
      	   도서 대출 현황
      	</a>
      </div>
      <div class="sidebar-item"><a href="${path}/studyroom/myReservationList">스터디룸 예약 현황</a></div>
      <div class="sidebar-item"><a href="${path}/suggest/mySuggestion">작성한 건의 사항</a></div>
</aside>

	<main class="loanList">
      <h2>나의 도서 대출 현황</h2>
      <hr style="margin: 30px 0;">
	<table class="form-table">
    	<tr>
	      		<th>대출 번호</th>
		        <th>제목</th>
		        <th>저자</th>
		        <th>대출일</th>
		        <th>반납일</th>
		        <th>대출 상태</th>
	        </tr>
	<c:choose>
		<c:when test="${not empty list}">
	      	<c:forEach var="loan" items="${list}">
	      		<tr>
		      		<td>${loan.loan_no}</td>
			        <td>${loan.title}</td>
			        <td>${loan.author}</td>
			        <td>
			        	<fmt:formatDate value="${loan.borrow_date}" pattern="yyyy-MM-dd"/>
			        </td>
			        <td>
			        	<c:if test="${!empty loan.return_date}">
			        		<fmt:formatDate value="${loan.return_date}" pattern="yyyy-MM-dd"/>
			        	</c:if>
			        	<c:if test="${empty loan.return_date}">
			        	-
			        	</c:if>
			        </td>
			        <td>
			        	<c:if test="${loan.loan_status eq 'BORROWED'}">
			        		대출 중
			        	</c:if>
			        	<c:if test="${loan.loan_status eq 'RETURNED'}">
			        		반납
			        	</c:if>
			        </td>
		        </tr>
	      	</c:forEach>
	      </c:when>
	      <c:otherwise>
		      <tr>
		        <td colspan="6" class="center">도서 대출 기록이 없습니다.</td>
		      </tr>
		  </c:otherwise>
	 </c:choose>
</table>
 	<!-- 페이징 처리 -->
	<c:choose>
		<c:when test="${not empty list and not empty pm}"> 
			<div class="pagination">
			
				<c:if test="${pm.first}">
		    		<a href="${path}/book/myPage/loans?page=1">처음</a>
		    	</c:if>
	
				<c:if test="${pm.prev}">
		    		<a href="${path}/book/myPage/loans?page=${pm.startPage-1}">이전</a>
		    	</c:if>
		    	
				<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
				      	<a href="${path}/book/myPage/loans?page=${i}"
				      	   <c:if test='${i == pm.cri.page}'> class='activePage' </c:if> >
				      		[${i}]
				      	</a>
	  			</c:forEach>
			
				<c:if test="${pm.next}">
		    		<a href="${path}/book/myPage/loans?page=${pm.endPage+1}">다음</a>
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