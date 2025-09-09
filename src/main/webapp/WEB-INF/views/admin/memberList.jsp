<!-- 관리자 전용 / 회원 관리 - 회원 목록 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju1>
<h2>회원 목록</h2>

<table class="table" style="width:600px; margin:auto;">
  <tr>
    <th>회원번호</th>
    <th>아이디</th>
    <th>이름</th>
  </tr>

    <tr onclick="goDetail()">
      <td class="center"></td>
      <td></td>
      <td></td>
    </tr>

</table>

<!-- 페이징 -->
<div class="pagination">

    <a href="/member/list?page=${page-1}">이전</a>





        <b>${p}</b>


        <a href="/member/list?page=${p}">${p}</a>



    <a href="/member/list?page=${page+1}">다음</a>

</div>
</section>

<%@ include file="../common/footer.jsp" %>