<!-- 관리자 전용 / 도서관 정보 관리 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju1>
<h2>도서관리</h2>
    <div style="text-align: right; margin-bottom: 10px;">
         <form action="/book/registerForm" method="get" style="margin:0;">
            <input type="submit" value="신규 도서 등록">
        </form>
    </div>
<table class="form-table">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>저자</th>
            <th>출판사</th>
            <th>발행연도</th>
        </tr>

        <tr onclick="">
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>
        <tr><td colspan="5" align="center">등록된 도서가 없습니다.</td></tr>

</table>

<!-- 페아장 처리 -->
<div style="margin-top:14px; text-align:center;">

    <a href="/manageInfo?page=${page-1}&size=${size}">이전</a>

        <a href="/manageInfo?page=${p}&size=${size}">[${p}]</a>





    <a href="/manageInfo?page=${page+1}&size=${size}">다음</a>

</div>
</section>

<%@ include file="../common/footer.jsp" %>