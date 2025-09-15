<!-- 건의 사항 목록 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>

<section class="jinju1">
    <main class="content">
        <h2 class="up">건의사항</h2>
        <button class="btn" 
            onclick="if(confirm('건의 사항을 작성하시겠습니까?')) location.href='${path}/suggest/register';">
            작성
        </button>

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
                        <a href="${path}/suggest/list?page=1">처음</a>
                    </c:if>

                    <c:if test="${pm.prev}">
                        <a href="${path}/suggest/list?page=${pm.startPage-1}">이전</a>
                    </c:if>

                    <c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
                        <a href="${path}/suggest/list?page=${i}" 
                           <c:if test='${i == pm.cri.page}'> class='activePage' </c:if>>
                            [${i}]
                        </a>
                    </c:forEach>

                    <c:if test="${pm.next}">
                        <a href="${path}/suggest/list?page=${pm.endPage+1}">다음</a>
                    </c:if>

                    <c:if test="${pm.last}">
                        <a href="${path}/suggest/list?page=${pm.maxPage}">마지막</a>
                    </c:if>
                </div>
            </c:when>
        </c:choose>
    </main>
</section>

<%@ include file="../common/footer.jsp" %>
