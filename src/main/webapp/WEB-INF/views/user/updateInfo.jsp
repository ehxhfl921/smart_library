<!-- 내 회원 정보 수정 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju2>
<div id="wrap">
  <h1>회원정보 수정</h1>

  <div class="login_wrap">
    <form id="frmUpdateInfo" method="post" action="" autocomplete="off">
      <table>
        <tr>
          <th>아이디(email)</th>
          <td><input type="text" name="id" value="" readonly></td>
        </tr>
        <tr>
          <th>새 비밀번호</th>
          <td><input type="password" name="new_pw" placeholder="새 비밀번호(미입력 시 변경 없음)"></td>
        </tr>
        <tr>
          <th>새 비밀번호 확인</th>
          <td><input type="password" name="new_pw2" placeholder="새 비밀번호 확인"></td>
        </tr>
        <tr>
          <th>이름</th>
          <td><input type="text" name="name" value="" readonly></td>
        </tr>
        <tr>
          <th>전화번호</th>
          <td><input type="text" name="phone" value="" placeholder="EX)01012345678"></td>
        </tr>
        <tr>
          <th>생년월일</th>
          <td><input type="text" name="birth" value="" readonly></td>
        </tr>
        <tr>
          <th>주소</th>
          <td>
            <div class="addr_post_row">
              <input type="text" name="addr_post" value="" placeholder="우편번호">
              <input type="button" class="btn-outline" value="주소찾기" onclick="daumApiCode();">
            </div>
            <input type="text" name="addr" class="addr" value="" placeholder="주소">
            <input type="text" name="addr_detail" class="addr" value="" placeholder="상세주소">
          </td>
        </tr>
      </table>

      <div class="btn_group">
        <button type="submit" class="btn_login">완료</button>
      </div>
    </form>
  </div>
</div>


<script>
  function daumApiCode(){
    alert('');
  }
</script>
</section>

<%@ include file="../common/footer.jsp" %>