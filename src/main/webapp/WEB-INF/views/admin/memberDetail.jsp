<!-- 관리자 전용 / 회원 관리 - 회원 정보 상세 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju1">
<main class="manageUpdate">
<h2 class="up">회원 상세 정보</h2>

<table class="form-table">
  <tr><th>회원번호</th><td>${member.mno}</td></tr>
  <tr><th>아이디</th><td>${member.id}</td></tr>
  <tr><th>비밀번호</th><td>******</td></tr>
  <tr><th>이름</th><td>${member.name}</td></tr>
  <tr><th>전화번호</th><td>${member.phone}</td></tr>
  <tr><th>이메일</th><td>${member.email}</td></tr>
  <tr><th>주소</th><td>${member.addr}</td></tr>
  <tr><th>개인정보 동의</th><td>${member.info}</td></tr>
</table>


<br>

<div class="actions" style="justify-content:center;">
  <form action="${path}/user/admin/memberUpdate" method="get" style="display:inline;">
    <input type="hidden" name="mno" value="${member.mno}">
    <input type="submit" value="수정하기" class="btn outline">
  </form>

  <form action="${path}/user/admin/delete" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
    <input type="hidden" name="mno" value="${member.mno}">
    <input type="hidden" name="page" value="${cri.page}">
    <input type="submit" value="삭제하기" class="btn bad">
  </form>

  <input type="button" value="목록으로" class="btn weak"
       onclick="location.href='${path}/user/admin/memberList?page=${cri.page}'">
</div>
</main>
</section>


<%@ include file="../common/footer.jsp" %>