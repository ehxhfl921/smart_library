<!-- 로그인 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju2>
<div id="wrap">

    <h1>SMART 도서관</h1>

  <div class="login_wrap">
    <!-- 로그인 폼 -->
    <form id="frmLogin" method="POST" action="/login">
      <div class="input_item">
        <input type="text" id="id" name="id" maxlength="15" placeholder="아이디" required>
      </div>
      <div class="input_item">
        <input type="password" id="pw" name="pw" maxlength="15" placeholder="비밀번호" required>
      </div>

      <div class="login_keep_wrap">
        <label>
          <input type="checkbox" name="keep"> 로그인 상태 유지
        </label>
      </div>

      <button type="submit" class="btn_login">로그인</button>
    </form>
  </div>

  <!-- 아이디/비번 찾기/회원가입 -->
  <ul class="find_wrap">
    <li><a href="#">비밀번호 찾기</a></li>
    <li><a href="#">아이디 찾기</a></li>
    <li><a href="#">회원가입</a></li>
  </ul>
</div>
</section>

<%@ include file="../common/footer.jsp" %>
