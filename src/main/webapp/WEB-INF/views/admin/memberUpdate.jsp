<!-- 관리자 전용 / 회원 관리 - 회원 정보 수정 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju1>
<h2>회원 정보 수정</h2>

<form action="/member/update" method="post">
  <input type="hidden" name="mno" value="${member.mno}">

<table class="form-table">
    <tr>
      <th>아이디</th>
      <td><input type="text" name="id" value="${member.id}" readonly></td>
    </tr>
    <tr>
      <th>비밀번호</th>
      <td><input type="password" name="pw" placeholder="새 비밀번호 입력 (변경 시)"></td>
    </tr>
    <tr>
      <th>이름</th>
      <td><input type="text" name="name" value="${member.name}" required></td>
    </tr>
    <tr>
      <th>전화번호</th>
      <td><input type="text" name="phone" value="${member.phone}"></td>
    </tr>
    <tr>
      <th>이메일</th>
      <td><input type="email" name="email" value="${member.email}" required></td>
    </tr>
    <tr>
      <th>주소</th>
      <td><input type="text" name="addr" value="${member.addr}"></td>
    </tr>
    <tr>
      <th>개인정보 동의</th>
      <td>
        <input type="text" value="${member.info == 'Y' ? '동의' : '미동의'}" readonly>
        <input type="hidden" name="info" value="${member.info}">
      </td>
    </tr>
  </table>

  <div style="margin-top:16px; text-align:center;">
    <input type="submit" value="수정 완료" class="btn">
    <input type="button" value="목록" class="btn outline" onclick="location.href='/member/detail?mno=${member.mno}'">
  </div>
</form>
</section>

<%@ include file="../common/footer.jsp" %>