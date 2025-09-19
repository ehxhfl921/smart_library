<!-- 공지 사항 상세 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="../common/header.jsp" %>

<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>

<section class="mainSection1">
	<main class="noticeDetail">
        <h2>공지 사항</h2>
		<hr>
		<div class="contentBox">
		
			<div class="head">
				<p class="noAndTitle">
					<span class="no">No.${boardVO.rnum}</span>
					<span class="title">${boardVO.n_title}</span>
				</p>
				<p class="authAndDate">
					<span>◦ 작성자 : ${boardVO.n_author}</span> <br>
					<span>◦ 작성일 : <fmt:formatDate value="${boardVO.n_create_date}" pattern="yyyy-MM-dd"/></span>
				</p>
			</div>
			<div class="body">
				<pre>${boardVO.n_content}</pre>
			</div>
			
		</div>
	
		<c:if test="${userInfo.id eq 'admin'}">
	       <div class="btnBox">
			    <button type="button" class="btn"
			                onclick="if(confirm('공지 사항을 수정하시겠습니까?')) location.href='${path}/notice/modifyForm?nno=${boardVO.nno}&rnum=${boardVO.rnum}'">
			                수정
			    </button>
			
			    <form action="${path}/notice/delete" method="post" style="display:inline;">
			    	<input type="hidden" name="nno" value="${boardVO.nno}">
				    <button type="submit" class="btn" onclick="return confirm('공지 사항을 삭제하시겠습니까?')">
				        삭제
				    </button>
				</form>
			</div>
		</c:if>

    </main>
</section>

<%@ include file="../common/footer.jsp" %>
