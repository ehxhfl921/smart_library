<!-- 건의 사항 수정 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju1">
  <main class="content">
    <h2 class="up">건의사항 수정</h2>
    <form method="POST" action="${path}/suggest/modify">
        <input type="hidden" name="sug_no" value="${suggestion.sug_no}">
        
        <div>
            <label>제목</label>
            <input type="text" name="s_title" required value="${suggestion.s_title}">
        </div>
        
        <div>
            <label>작성 내용</label>
            <textarea name="s_content" required rows="5" cols="20">${suggestion.s_content}</textarea>
        </div>
        
        <div>
            <label>작성자</label>
            <input type="text" name="s_author" value="${suggestion.s_author}" readonly>
        </div>
        
        <div>
            <button type="submit" class="btn"
                onclick="return confirm('건의 사항을 수정하시겠습니까?')">수정</button>
        </div>
    </form>
  </main>
</section>

<%@ include file="../common/footer.jsp" %>