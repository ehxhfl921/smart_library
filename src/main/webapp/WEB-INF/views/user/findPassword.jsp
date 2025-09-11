<!-- 비밀번호 찾기 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju2>
<div id="wrap">
  <h1>비밀번호 찾기</h1>

  <!-- 에러 메시지 출력 테스트 -->
  <p class="result">msg</p>
  <p class="result" style="color:red">error </p>

  <!-- 아이디 + 이메일 입력 -->
  <h3>STEP 1 : 아이디 + 이메일 입력</h3>
  <form action="#" method="post">
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
  <h3>STEP 2 : 인증코드 입력</h3>
  <p>입력하신 이메일(<b>example@test.com</b>)로 인증코드를 발송했습니다.</p>
  <form action="#" method="get">
    <input type="hidden" name="id" value="testId">
    <input type="hidden" name="email" value="example@test.com">
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
  <h3>STEP 3 : 비밀번호 변경</h3>
  <p>이메일 인증이 완료되었습니다. 새 비밀번호를 입력해주세요!</p>
  <form action="#" method="post">
    <input type="hidden" name="id" value="testId">
    <table>
      <tr>
        <th>새 비밀번호</th>
        <td><input type="password" name="pw" required></td>
      </tr>
      <tr>
        <th>비밀번호 확인</th>
        <td><input type="password" name="pwConfirm" required></td>
      </tr>
    </table>
    <br>
    <input type="submit" value="비밀번호 변경" class="btn_login">
  </form>

</div>
</section>


<%@ include file="../common/footer.jsp" %>