<!-- 내가 작성한 건의사항 페이지 -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../common/header.jsp" %>

<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>

<section class="jinju1">

<aside class="sidebar" style="width:220px;">
      <div class="sidebar-header">내 서재</div>
      <div class="sidebar-item"><a href="${path}/book/myPage/loans?page=1">도서 대출 현황</a></div>
      <div class="sidebar-item">
      		<a href="${path}/studyroom/myReservationList?page=1">
      			스터디룸 예약 현황
      		</a>
      </div>
      <div class="sidebar-item"><a href="${path}/suggest/mySuggestion"
      	   style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">
       작성한 건의 사항
       </a>
      </div>
</aside>

    <main class="suggestionList">
    	<div class="head">
	        <h2>내가 작성한 건의사항</h2>
		</div>
		<hr>
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
            <c:choose>
                <c:when test="${not empty list}">
                    <c:forEach var="suggestion" items="${list}">
                        <tr>
                            <td class="center">${suggestion.sug_no}</td>
                            <td>
                                <a href="${path}/suggest/detail?sug_no=${suggestion.sug_no}">
                                    ${suggestion.s_title}
                                </a>
                            </td>
                            <td>${suggestion.s_author}</td>
                           <td class="center">
   							 <fmt:formatDate value="${suggestion.s_create_date}" pattern="yyyy-MM-dd"/>
						</td>
	      				</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
                    <tr>
                        <td colspan="4" class="center">내가 작성한 건의사항이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>

        <!-- ✅ 페이징 -->
        <c:choose>
            <c:when test="${not empty list and not empty pm}">
                <div class="pagination">
                    <c:if test="${pm.first}">
                        <a href="${path}/suggest/mySuggestion?page=1">처음</a>
                    </c:if>

                    <c:if test="${pm.prev}">
                        <a href="${path}/suggest/mySuggestion?page=${pm.startPage-1}">이전</a>
                    </c:if>

                    <c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
                        <a href="${path}/suggest/mySuggestion?page=${i}" 
                           <c:if test='${i == pm.cri.page}'> class='activePage' </c:if>>
                            [${i}]
                        </a>
                    </c:forEach>

                    <c:if test="${pm.next}">
                        <a href="${path}/suggest/mySuggestion?page=${pm.endPage+1}">다음</a>
                    </c:if>

                    <c:if test="${pm.last}">
                        <a href="${path}/suggest/mySuggestion?page=${pm.maxPage}">마지막</a>
                    </c:if>
                </div>
            </c:when>
        </c:choose>
    </main>
</section>

<%@ include file="../common/footer.jsp" %>
