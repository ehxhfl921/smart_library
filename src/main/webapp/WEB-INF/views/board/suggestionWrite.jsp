
<!-- 건의 사항 작성 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju1">
  <main class="content">
    <h2 class="up">건의사항 작성</h2>

    <!-- 건의사항 작성 폼 -->
    <form method="POST" action="${path}/suggest/register">
        <div>
            <label>제목</label>
            <input type="text" name="s_title" required >
        </div>
        <div>
            <label>작성 내용</label>
            <textarea name="s_content" required rows="5" cols="20"></textarea>
        </div>

        <div>
            <label>작성자</label>
            <input type="text" name="s_author" value="${sessionScope.logins.name}" readonly>
        </div>
        <div>
            <button type="submit" class="btn"
                onclick="return confirm('건의 사항을 작성하시겠습니까?')">작성</button>
        </div>
    </form>
  </main>
</section>

<%@ include file="../common/footer.jsp" %>

