<!-- 공지 사항 수정 폼 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju1">
  <main class="content">
    <h2 class="up">공지사항 수정</h2>
    <form method="POST" action="${path}/notice/update">
        <input type="hidden" name="nno" value="${boardVO.nno}">
        
        <div>
            <label>제목</label>
            <input type="text" name="n_title" required value="${boardVO.n_title}">
        </div>
        
        <div>
            <label>작성 내용</label>
            <textarea name="n_content" required rows="5" cols="20">${boardVO.n_content}</textarea>
        </div>
        
        <div>
            <label>작성자</label>
            <input type="text" name="n_author" value="${boardVO.n_author}" readonly>
        </div>
        
        <div>
            <button type="submit" class="btn"
                onclick="return confirm('공지 사항을 수정하시겠습니까?')">수정</button>
        </div>
    </form>
  </main>
</section>

<%@ include file="../common/footer.jsp" %>
