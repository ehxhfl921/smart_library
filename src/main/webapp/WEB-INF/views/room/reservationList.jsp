<!-- 내 서재 / 스터디룸 이용 내역 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="mainSection1">

<aside class="sidebar" style="width:220px;">
      <div class="sidebar-header">내 서재</div>
      <div class="sidebar-item"><a href="${path}/book/myPage/loans?page=1">도서 대출 현황</a></div>
      <div class="sidebar-item">
      		<a href="${path}/studyroom/myReservationList?page=1" 
      		   style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">
      			스터디룸 예약 현황
      		</a>
      </div>
      <div class="sidebar-item"><a href="${path}/suggest/mySuggestion">작성한 건의 사항</a></div>
</aside>

	<main class="loanList">
      <h2>스터디룸 예약 현황</h2>
      <hr style="margin: 30px 0;">
	<table class="form-table">
    	<tr>
      		<th>no.</th>
      		<th>예약 번호</th>
	        <th>스터디룸</th>
	        <th>예약 신청일</th>
	        <th>예약 희망일</th>
	        <th>예약 상태</th>
	        <th>예약 취소</th>
        </tr>
	<c:choose>
		<c:when test="${not empty list}">
	      	<c:forEach var="reservation" items="${list}">
	      		<tr>
		      		<td>${reservation.rnum}</td>
		      		<td>${reservation.rno}</td>
			        <td>스터디룸 ${reservation.sno}</td>
			        <td>
			        	<fmt:formatDate value="${reservation.apply_date}" pattern="yyyy-MM-dd"/>
			        </td>
			        <td>
			        	<fmt:formatDate value="${reservation.reserve_date}" pattern="yyyy-MM-dd"/>
			        </td>
		        	<c:choose>
			        	<c:when test="${reservation.status eq 'PENDING'}">
			        		<td style="color:green;">승인 대기</td>
			        	</c:when>
			        	<c:when test="${reservation.status eq 'APPROVED'}">
							<td style="color:#0d47a1;">예약 확정</td>
						</c:when>
						<c:when test="${reservation.status eq 'REJECTED'}">
							<td style="color:#b91c1c;">예약 거절</td>
						</c:when>
						<c:when test="${reservation.status eq 'CANCELED'}">
							<td style="color:#cdcdcd">예약 취소</td>
						</c:when>
			        	<c:otherwise>
							-				        	
			        	</c:otherwise>
		        	</c:choose>
		        	
			        <td>
			        	<c:choose>
				        	<c:when test="${(reservation.status eq 'PENDING' or reservation.status eq 'APPROVED')
                    						and reservation.reserve_date >= today}">
				        		<button class="cancelBtn" id="cancelBtn" data-rno="${reservation.rno}">
				        			예약 취소
				        		</button>
				        	</c:when>
				        	<c:otherwise>
								-				        	
				        	</c:otherwise>
			        	</c:choose>
			        	
			        </td>
		        </tr>
	      	</c:forEach>
	      </c:when>
	      <c:otherwise>
		      <tr>
		        <td colspan="7" class="center">스터디룸 예약 기록이 없습니다.</td>
		      </tr>
		  </c:otherwise>
	 </c:choose>
</table>
 	<!-- 페이징 처리 -->
	<c:choose>
		<c:when test="${not empty list and not empty pm}"> 
			<div class="pagination">
			
				<c:if test="${pm.first}">
		    		<a href="${path}/studyroom/myReservationList?page=1">처음</a>
		    	</c:if>
	
				<c:if test="${pm.prev}">
		    		<a href="${path}/studyroom/myReservationList?page=${pm.startPage-1}">이전</a>
		    	</c:if>
		    	
				<c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
				      	<a href="${path}/studyroom/myReservationList?page=${i}"
				      	   <c:if test='${i == pm.cri.page}'> class='activePage' </c:if> >
				      		[${i}]
				      	</a>
	  			</c:forEach>
			
				<c:if test="${pm.next}">
		    		<a href="${path}/studyroom/myReservationList?page=${pm.endPage+1}">다음</a>
		    	</c:if>
		    	
		    	<c:if test="${pm.last}">
			      	<a href="${path}/studyroom/myReservationList?page=${pm.maxPage}">마지막</a>
			    </c:if>
			</div>
	  	</c:when>
	</c:choose>
</main>
</section>
<script>

let rno = null;

document.querySelectorAll(".cancelBtn").forEach(div => {
    div.addEventListener("click", () => {
        
    	
        rno = div.dataset.rno; // data-rno 속성에서 번호 가져오기
        console.log(rno);

        const ok = confirm('(예약 번호 : '+ rno +') 스터디룸 예약을 취소하시겠습니까?');
    	
    	if(ok){
    		
	        
	        fetch(`${path}/studyroom/cancel/\${rno}`, {
	        	method : "PATCH",
				headers : {"Content-Type" : "application/json"}
	        }).then(res => res.text())
	        .then(msg => {
	        	alert(msg);
	        	location.reload();
	        })
	        .catch(err => {
	        	console.log(err.message);
	        });
	        
    	} // end if ok
        
    });	// end eventListener
}); // end forEach

</script>


<%@ include file="../common/footer.jsp" %>