<!-- 관리자 전용 / 회원 관리 - 회원 목록 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="mainSection1">
<aside class="sidebar">
      <div class="sidebar-header">운영/관리</div>
      <div class="sidebar-item">
      	<a href="${path}/user/admin/memberList"
           style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">회원 관리</a></div>
	  <div class="sidebar-item"><a href="${path}/book/admin/list">도서 관리</a></div>
      <div class="sidebar-item"><a href="${path}/studyroom/admin/reservationList">스터디룸 예약 관리</a></div>
      <div class="sidebar-item"><a href="${path}/manageInfo">도서관 정보 관리</a></div>
</aside>

<main class="manageMember">
<h2>회원 관리</h2>
<hr>
<table class="form-table">
	<tr>
	    <th>no.</th>
	    <th>회원번호</th>
	    <th>아이디</th>
	    <th>이름</th>
  	</tr>
    
    <c:choose>
    <c:when test="${not empty list}">
      <c:forEach var="member" items="${list}">
        <tr onclick="location.href='${path}/user/admin/memberDetail?mno=${member.mno}&page=${pm.cri.page}'">
          <td>${member.rnum}</td>
          <td class="center">${member.mno}</td>
          <td>${member.id}</td>
          <td>${member.name}</td>
        </tr>
      </c:forEach>
    </c:when>
    <c:otherwise>
    	<tr>
    		<td colspan="4">등록된 회원이 없습니다.</td>
    	</tr>
    </c:otherwise>
  	</c:choose>
    

</table>

<!-- 페이징 -->
<c:choose>
	<c:when test="${not empty list and not empty pm}">
		<div class="pagination">
		
			<c:if test="${pm.first}">
	    		<a href="${path}/user/admin/memberList?page=1">[처음]</a>
	    	</c:if>
			
						<c:if test="${pm.prev}">
	    		<a href="${path}/user/admin/memberList?page=${pm.startPage-1}">[이전]</a>
	    	</c:if>
	    	
			<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
			      	<a href="${path}/user/admin/memberList?page=${i}"
			      	   <c:if test='${i == pm.cri.page}'> class='activePage' </c:if> >
			      		[${i}]
			      	</a>
  			</c:forEach>
		
			<c:if test="${pm.next}">
	    		<a href="${path}/user/admin/memberList?page=${pm.endPage+1}">[다음]</a>
	    	</c:if>
	    	
	    	<c:if test="${pm.last}">
		      	<a href="${path}/user/admin/memberList?page=${pm.maxPage}">[마지막]</a>
		    </c:if>	
		</div>
	</c:when>
</c:choose>
</main>
</section>

<%@ include file="../common/footer.jsp" %>