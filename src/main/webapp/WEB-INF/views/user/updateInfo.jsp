<!-- 내 회원 정보 수정 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju2>
<div id="wrap">
  <h1>회원정보 수정</h1>

  <div class="login_wrap">
    <form  method="post" action="${path}/user/modifyInfo" autocomplete="off">
       <input type="hidden" name="mno" value="${userInfo.mno}">
      <table>
        <tr>
          <th>아이디</th>
          <td><input type="text" name="id" value="${userInfo.id}" readonly></td>
        </tr>
        <tr>
          <th>비밀번호</th>
          <td><input type="password" name="pw" placeholder="비밀번호(미입력 시 변경 없음)"></td>
        </tr>
        <tr>
          <th>새 비밀번호 확인</th>
          <td><input type="password" name="pwConfirm" placeholder="새 비밀번호 확인"></td>
        </tr>
        <tr>
          <th>이름</th>
          <td><input type="text" name="name" value="${userInfo.name}"></td>
        </tr>
        <tr>
          <th>전화번호</th>
          <td><input type="text" name="phone" value="${userInfo.phone}" ></td>
        </tr>
        <tr>
          <th>이메일</th>
          <td><input type="text" name="email" value="${userInfo.email}" ></td>
        </tr>
        <tr>
          <th>주소</th>
          <td>
          
            <input type="text" name="addr" class="addr" value="${userInfo.addr}" placeholder="주소">

          </td>
        </tr>
      </table>

      <div class="btn_group">
        <button type="submit" class="btn_login">완료</button>
      </div>
    </form>
  </div>
</div>

</section>

<%@ include file="../common/footer.jsp" %>