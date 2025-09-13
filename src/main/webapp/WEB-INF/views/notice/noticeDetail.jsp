<!-- 공지 사항 상세 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju1">
	<main class="content">
        <h2 class="up">공지사항</h2>

        <!-- 공지사항 정보 테이블 -->
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
		        <tr>
		            <td>${boardVO.nno}</td>
		            <td>${boardVO.n_title}</td>
		            <td>${boardVO.n_author}</td>
		            <td><fmt:formatDate value="${boardVO.n_create_date}" pattern="yyyy-MM-dd"/></td>
		        </tr>
		    </tbody>
		</table>
		<div>
		    <textarea name="n_content" readonly>${boardVO.n_content}</textarea>
		</div>
       <div>
    <button type="button" class="btn"
                onclick="if(confirm('공지 사항을 수정하시겠습니까?')) location.href='${path}/notice/modifyForm?nno=${boardVO.nno}'">
                수정
            </button>

    <form action="${path}/notice/delete" method="post" style="display:inline;">
    <input type="hidden" name="nno" value="${boardVO.nno}">
    <button type="submit" class="btn" onclick="return confirm('공지 사항을 삭제하시겠습니까?')">
        삭제
    </button>
</form>

</div>

    </main>
</section>

<%@ include file="../common/footer.jsp" %>
