<!-- 건의 사항 목록 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>

<section class="mainSection1">

<aside class="sidebar">
      <div class="sidebar-header">열린 공간</div>
      <div class="sidebar-item">
      		<a href="${path}/notice/list">
      	   		공지 사항
      	   	</a>
      </div>
      <div class="sidebar-item">
      		<a href="${path}/suggest/list"
				style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">
      	   		건의 사항
      	   	</a>
      </div>
</aside>

    <main class="noticeList">
    	<div class="head">
	        <h2>건의 사항</h2>
	        <c:if test="${userInfo.id ne 'admin'}">
		        <button class="btn" 
		            onclick="if(confirm('건의 사항을 작성하시겠습니까?')) location.href='${path}/suggest/register';">
		            게시글 작성
		        </button>
	        </c:if>
		</div>
		<hr>
        <table class="form-table">
            <thead>
                <tr>
                    <th>no.</th>
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
                                <td class="center">${suggestion.rnum}</td>
                                <td>
                                    <a href="${path}/suggest/detail?sug_no=${suggestion.sug_no}&rnum=${suggestion.rnum}">
                                        ${suggestion.s_title}
                                        <c:if test="${suggestion.s_update_date != null}">
                                        	&nbsp; <span style="color:#0d47a1">(수정됨)</span>
                                        </c:if>
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
                            <td colspan="4" class="center">등록된 건의사항이 없습니다.</td>
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
                        <a href="${path}/suggest/list?page=1">[처음]</a>
                    </c:if>

                    <c:if test="${pm.prev}">
                        <a href="${path}/suggest/list?page=${pm.startPage-1}">[이전]</a>
                    </c:if>

                    <c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
                        <a href="${path}/suggest/list?page=${i}" 
                           <c:if test='${i == pm.cri.page}'> class='activePage' </c:if>>
                            [${i}]
                        </a>
                    </c:forEach>

                    <c:if test="${pm.next}">
                        <a href="${path}/suggest/list?page=${pm.endPage+1}">[다음]</a>
                    </c:if>

                    <c:if test="${pm.last}">
                        <a href="${path}/suggest/list?page=${pm.maxPage}">[마지막]</a>
                    </c:if>
                </div>
            </c:when>
        </c:choose>
    </main>
</section>

<%@ include file="../common/footer.jsp" %>
