<!-- 공지 사항 목록 페이지 -->

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
      		<a href="${path}/notice/list"
      	   	   style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">
      	   		공지 사항
      	   	</a>
      </div>
      <div class="sidebar-item"><a href="${path}/suggest/list">건의 사항</a></div>
</aside>

    <main class="noticeList">
    	<div class="head">
	        <h2>공지 사항</h2>
	        <c:if test="${userInfo.id eq 'admin'}">
		        <button class="btn" 
		            onclick="if(confirm('공지 사항을 작성하시겠습니까?')) location.href='${path}/notice/register';">
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
                <c:when test="${not empty lists}">
                    <c:forEach var="notice" items="${lists}">
                        <tr>
                            <td class="center">${notice.rnum}</td>
                            <td>
                                <a href="${path}/notice/detail?nno=${notice.nno}&rnum=${notice.rnum}">
                                    ${notice.n_title}
                                </a>
                            </td>
                            <td>${notice.n_author}</td>
                           <td class="center">
   							 <fmt:formatDate value="${notice.n_create_date}" pattern="yyyy-MM-dd"/>
						</td>
	      				</tr>
							</c:forEach>
						</c:when>
						<c:otherwise>
                    <tr>
                        <td colspan="4" class="center">등록된 공지사항이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
            </tbody>
        </table>

        <!-- ✅ 페이징 -->
        <c:choose>
            <c:when test="${not empty lists and not empty pm}">
                <div class="pagination">
                    <c:if test="${pm.first}">
                        <a href="${path}/notice/list?page=1">[처음]</a>
                    </c:if>

                    <c:if test="${pm.prev}">
                        <a href="${path}/notice/list?page=${pm.startPage-1}">[이전]</a>
                    </c:if>

                    <c:forEach var="i" begin="${pm.startPage}" end="${pm.endPage}">
                        <a href="${path}/notice/list?page=${i}" 
                           <c:if test='${i == pm.cri.page}'> class='activePage' </c:if>>
                            [${i}]
                        </a>
                    </c:forEach>

                    <c:if test="${pm.next}">
                        <a href="${path}/notice/list?page=${pm.endPage+1}">[다음]</a>
                    </c:if>

                    <c:if test="${pm.last}">
                        <a href="${path}/notice/list?page=${pm.maxPage}">[마지막]</a>
                    </c:if>
                </div>
            </c:when>
        </c:choose>
    </main>
</section>

<%@ include file="../common/footer.jsp" %>
