<!-- 비밀번호 찾기 - 변경할 새로운 비밀번호 입력 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju2>
<div id="wrap">
    <h1>비밀번호 변경</h1>

    <form action="" method="post">
      <input type="hidden" name="id" value="" />
      <input type="hidden" name="email" value="" />
      <input type="hidden" name="token" value="" />

      <table>
        <tr>
          <th>새 비밀번호</th>
          <td><input type="password" name="newPassword" required /></td>
        </tr>
        <tr>
          <th>새 비밀번호 확인</th>
          <td><input type="password" name="confirmPassword" required /></td>
        </tr>
      </table>

      <br />

      <input type="submit" value="변경하기" class="btn_login" />
    </form>
  </div>
</section>

<%@ include file="../common/footer.jsp" %>