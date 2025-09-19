<!-- 관리자 전용 / 스터디룸 예약 관리 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="mainSection1">
<aside class="sidebar">
      <div class="sidebar-header">운영/관리</div>
      <div class="sidebar-item"><a href="${path}/user/admin/memberList">회원 관리</a></div>
      <div class="sidebar-item"><a href="${path}/book/admin/list">도서 관리</a></div>
      <div class="sidebar-item">
      	<a href="${path}/studyroom/admin/reservationList"
      	   style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">
      		스터디룸 예약 관리
      	</a>
      </div>
      <div class="sidebar-item"><a href="${path}/manageInfo">도서관 정보 관리</a></div>
</aside>

<main class="manageReservation">

<h2>스터디룸 예약 관리</h2>
<hr>
<p style="font-size:14px; font-weight: bold; color:#0d47a1;">
	* 같은 날짜, 같은 스터디룸에 대한 예약 신청이 2개 이상일 경우 1개의 예약 승인 시 그 외 예약 신청은 자동 거절 처리됩니다.
</p>
<table class="form-table">
  <thead>
    <tr>
      <th>no.</th>
      <th>예약 번호</th>
      <th>신청자 (아이디)</th>
      <th>스터디룸</th>
      <th>예약 신청일</th>
      <th>예약 희망일</th>
      <th>상태</th>
      <th>예약 관리</th>
    </tr>
  </thead>
  <tbody>
    <c:if test="${not empty list}">
		<c:forEach var="reservation" items="${list}">
	          <tr>
	            <td>${reservation.rnum}</td>
	            <td>${reservation.rno}</td>
	            <td>${reservation.user_name} (${reservation.user_id})</td>
	            <td>스터디룸 ${reservation.sno}</td>
	            <td>
	            	<fmt:formatDate value="${reservation.apply_date}" pattern="yyyy-MM-dd"/>
	            </td>
	            <td>
	            	<fmt:formatDate value="${reservation.reserve_date}" pattern="yyyy-MM-dd"/>
	            </td>
	
	            <!-- 상태 -->
	            <td>
	            	<c:choose>
	            		<c:when test="${reservation.status eq 'PENDING'}">
			            	<span class="badge badge-pending">대기중</span>
	            		</c:when>
	            		<c:when test="${reservation.status eq 'APPROVED'}">
			            	<span class="badge badge-approved">승인됨</span>
	            		</c:when>
	            		<c:when test="${reservation.status eq 'REJECTED'}">
			            	<span class="badge badge-rejected">거절됨</span>
	            		</c:when>
	            		<c:when test="${reservation.status eq 'CANCELED'}">
			            	<span class="badge badge-cancelled">취소됨</span>
	            		</c:when>
	            		<c:otherwise>
 			                <span class="badge badge-finished">완료됨</span>
	            		</c:otherwise>
	            	</c:choose>
	            </td>
	
	            <!-- 예약 관리 버튼 -->
	            <td>
	              <div class="actions">
	              		<c:choose>
		            		 <c:when test="${reservation.status eq 'PENDING'}">
			                 	<button class="btn btn-approve" data-rno="${reservation.rno}">승인</button>
			                    <button class="btn btn-reject" data-rno="${reservation.rno}">거절</button>
			                 </c:when>
							<c:when test="${reservation.status eq 'APPROVED'
											and reservation.reserve_date >= today}">
			                    <button class="btn btn-cancel" data-rno="${reservation.rno}">취소</button>
		                    </c:when>
		                    <c:when test="${reservation.status eq 'APPROVED'
		                    				and reservation.reserve_date < today}">
		                    	<span style="color:#aaa;font-size:14px;">이용 완료</span>
		                    </c:when>
		                    <c:otherwise>
		                    	-
		                    </c:otherwise>
	           			</c:choose>
	              </div>
	            </td>
	          </tr>
		</c:forEach>
	</c:if>
	<c:if test="${empty list}">
        <tr>
          <td colspan="8">예약 내역이 없습니다.</td>
        </tr>
    </c:if>
  </tbody>
</table>
<!-- 페이징 처리 -->
<c:choose>
	<c:when test="${not empty pm}"> 
		<div class="pagination">
		
			<c:if test="${pm.first}">
	    		<a href="${path}/studyroom/admin/reservationList?page=1">[처음]</a>
	    	</c:if>

			<c:if test="${pm.prev}">
	    		<a href="${path}/studyroom/admin/reservationList?page=${pm.startPage-1}">[이전]</a>
	    	</c:if>
	    	
			<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
			      	<a href="${path}/studyroom/admin/reservationList?page=${i}"
			      	   <c:if test='${i == pm.cri.page}'> class='activePage' </c:if> >
			      		[${i}]
			      	</a>
  			</c:forEach>
		
			<c:if test="${pm.next}">
	    		<a href="${path}/studyroom/admin/reservationList?page=${pm.endPage+1}">[다음]</a>
	    	</c:if>
	    	
	    	<c:if test="${pm.last}">
		      	<a href="${path}/studyroom/admin/reservationList?page=${pm.maxPage}">[마지막]</a>
		    </c:if>
		</div>
  	</c:when>
</c:choose>

</main>
</section>

<script>

function handleAction(selector, action, msg) {
    document.querySelectorAll(selector).forEach(btn => {
        btn.addEventListener("click", () => {
            const rno = btn.dataset.rno;
            const ok = confirm(`(예약 번호 : \${rno}) 스터디룸 예약을 \${msg}하시겠습니까?`);
            
            if(ok){
                fetch(`${path}/studyroom/\${action}/\${rno}`, {
                    method : "PATCH",
                    headers : {"Content-Type" : "application/json"}
                })
                .then(res => res.text())
                .then(alert)
                .then(() => location.reload())
                .catch(err => console.log(err.message));
            }
        });
    });
}

// 예약 승인 처리
handleAction(".btn-approve", "approve", "승인");
//예약 거절 처리
handleAction(".btn-reject", "reject", "거절");
// 예약 취소 처리
handleAction(".btn-cancel", "cancel", "취소");

</script>
<%@ include file="../common/footer.jsp" %>