<!-- 비밀번호 찾기 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju2>
<div id="wrap">
  <h1>비밀번호 찾기</h1>

  <!--  에러 메시지
  <c:if test="${not empty msg}">
    <p class="result">${msg}</p>
  </c:if>
  <c:if test="${not empty error}">
    <p class="result" style="color:red">${error}</p>
  </c:if>
  -->

  <!-- 아이디 + 이메일 입력 -->
    <form action="" method="post">
      <table>
        <tr>
          <th>아이디</th>
          <td><input type="text" name="id" required></td>
        </tr>
        <tr>
          <th>이메일</th>
          <td><input type="email" name="email" required></td>
        </tr>
      </table>
      <br>
      <input type="submit" value="인증코드 요청" class="btn_login">
    </form>

  <!-- 인증코드 입력 -->

    <p>입력하신 이메일(<b>${email}</b>)로 인증코드를 발송했습니다.</p>
    <form action="" method="post">
      <input type="hidden" name="id" value="${id}">
      <input type="hidden" name="email" value="${email}">
      <table>
        <tr>
          <th>인증코드</th>
          <td><input type="text" name="code" required></td>
        </tr>
      </table>
      <br>
      <input type="submit" value="인증하기" class="btn_login">
    </form>


  <!-- 인증 성공 → 비밀번호 변경 -->

    <p>이메일 인증이 완료되었습니다.</p>
    <form action="" method="get">
      <input type="hidden" name="id" value="">
      <input type="hidden" name="email" value="">
      <input type="hidden" name="token" value="">
      <input type="submit" value="비밀번호 변경" class="">
    </form>
</div>
</section>

<%@ include file="../common/footer.jsp" %>