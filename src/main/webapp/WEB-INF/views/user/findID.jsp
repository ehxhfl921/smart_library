<!-- 아이디 찾기 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju2>
<div id="wrap">
  <h1>아이디 찾기</h1>

  <!-- 에러 메시지 -->
  <c:if test="${not empty error}">
    <p class="result" style="color:red">${error}</p>
  </c:if>

  <!-- 성공 메시지 -->
  <c:if test="${not empty userId}">
    <p>회원님의 아이디는 <b>${userId}</b> 입니다.</p>
  </c:if>

  <!-- 아이디 찾기 입력 폼 -->
  <form action="${path}/user/findId" method="post">
    <table>
      <tr>
        <th>이름</th>
        <td><input type="text" name="name" required></td>
      </tr>
      <tr>
        <th>이메일</th>
        <td><input type="email" name="email" required></td>
      </tr>
    </table>
    <br>
    <input type="submit" value="아이디 찾기" class="btn_login">
  </form>

</div>
</section>
<%@ include file="../common/footer.jsp" %>