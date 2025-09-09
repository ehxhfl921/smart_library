<!-- 회원 가입 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju2>
	<div id="wrap">
  <h1>회원가입</h1>

  <form id="joinForm" action="" method="POST">
    <table>
      <tr>
        <th>아이디(email)</th>
        <td>
          <input type="text" name="id" id="id" autocomplete="off">
          <input type="button" class="btn-outline" id="acceptEmail" value="이메일 인증">
          <div class="result" id="idMsg"></div>
          <div id="emailCodeWrap" style="margin-top:8px;">
            <input type="text" id="userCode" placeholder="코드 입력">
            <button type="button" class="btn-outline" id="emailAcceptBtn">인증 완료</button>
          </div>
        </td>
      </tr>
      <tr>
        <th>비밀번호</th>
        <td>
          <input type="password" name="pw" id="pw">
          <div class="result" id="pwMsg"></div>
        </td>
      </tr>
      <tr>
        <th>비밀번호 확인</th>
        <td>
          <input type="password" id="re_pw">
          <div class="result" id="rePwMsg"></div>
        </td>
      </tr>
      <tr>
        <th>이름</th>
        <td>
          <input type="text" name="name" id="name">
          <div class="result" id="nameMsg"></div>
        </td>
      </tr>
      <tr>
        <th>전화번호</th>
        <td>
          <input type="text" name="phone" id="phone" placeholder="01012345678">
          <div class="result" id="phoneMsg"></div>
        </td>
      </tr>
      <tr>
        <th>생년월일</th>
        <td>
          <input type="text" name="birth" id="birth" placeholder="YYYYMMDD">
          <div class="result" id="birthMsg"></div>
        </td>
      </tr>
      <tr>
        <th>주소</th>
        <td>
          <div style="margin-bottom:6px;">
            <input type="text" name="addr_post" id="addr_post" placeholder="우편번호" readonly>
            <input type="button" class="btn-outline"value="주소찾기" onclick="daumApiCode();">
          </div>
          <input type="text" name="addr" id="addr" placeholder="주소" readonly style="margin-bottom:6px;">
          <input type="text" name="addr_detail" id="addr_detail" placeholder="상세주소">
        </td>
      </tr>
      <tr>
        <th>개인정보이용약관</th>
        <td>
          <textarea readonly cols="40" rows="5">개인정보는 ~~~~~</textarea>
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <label>
            <input type="checkbox" name="info" id="info" value="y"> 개인정보 이용 동의
          </label>
        </td>
      </tr>
      <tr>
        <td colspan="2">
          <button type="submit" class="btn_login">회원등록</button>
        </td>
      </tr>
    </table>
  </form>
</div>

<script>
  function daumApiCode(){
    alert("");
  }
</script>
</section>

<%@ include file="../common/footer.jsp" %>
