<!-- 건의 사항 상세 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<section class="jinju1">
    <main class="content">
        <h2 class="up">건의사항</h2>

        <!-- 건의사항 정보 테이블 -->
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
                    <td>${suggestion.sug_no}</td>
                    <td>${suggestion.s_title}</td>
                    <td>${suggestion.s_author}</td>
                    <td><fmt:formatDate value="${suggestion.s_create_date}" pattern="yyyy-MM-dd"/></td>
                </tr>
            </tbody>
        </table>

        <!-- 건의사항 내용 -->
        <div>
            <textarea name="s_content" readonly rows="6" cols="50">${suggestion.s_content}</textarea>
        </div>

        <!-- 수정 / 삭제 버튼 -->
        <div>
            <button type="button" class="btn"
                onclick="if(confirm('건의 사항을 수정하시겠습니까?')) location.href='${path}/suggest/modifyForm?sug_no=${suggestion.sug_no}'">
                수정
            </button>

            <form action="${path}/suggest/delete" method="post" style="display:inline;">
                <input type="hidden" name="sug_no" value="${suggestion.sug_no}">
                <button type="submit" class="btn" onclick="return confirm('건의 사항을 삭제하시겠습니까?')">삭제</button>
            </form>
        </div>

        <hr>

        <!-- 댓글 섹션 -->
        
    </main>
</section>

<%@ include file="../common/footer.jsp" %>
