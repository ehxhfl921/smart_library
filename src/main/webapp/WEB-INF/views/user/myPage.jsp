<!-- 내 회원 정보 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju2>
<div id="wrap">
  <h1>마이페이지</h1>

  <div class="login_wrap">
    <table>
      <tr>
        <th>아이디</th>
        <td><input type="text" value="${userInfo.id}" readonly></td>
      </tr>
      <tr>
        <th>비밀번호</th>
        <td><input type="password" value="${userInfo.pw}" readonly></td>
      </tr>
      <tr>
        <th>이름</th>
        <td><input type="text" value="${userInfo.name}" readonly></td>
      </tr>
      <tr>
        <th>전화번호</th>
        <td><input type="text" value="${userInfo.phone}" readonly></td>
      </tr>
	  <tr>
        <th>이메일</th>
        <td><input type="text" value="${userInfo.email}" readonly></td>
      </tr>
		
      <tr>
        <th>주소</th>
        <td>
        
          <input type="text" value="${userInfo.addr}" readonly style="margin-bottom:6px;">

        </td>
      </tr>
    </table>

    <!-- 버튼: 정보 수정 / 회원 탈퇴 -->
    <div style="margin-top:12px; display:flex; gap:10px;">
      <form method="get" action="${path}/user/myPage/modifyInfo" style="flex:1; margin:0;">
        <button type="submit" class="btn_login" style="width:100%;">수정</button>
      </form>

		<form method="post" action="${path}/user/withdraw"
		      onsubmit="return confirm('정말 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.');"
		      style="flex:1; margin:0;">
		  <input type="hidden" name="mno" value="${userInfo.mno}">
		  <button type="submit" class="btn_login" style="width:100%;">회원 탈퇴</button>
		</form>
    </div>
  </div>
</div>


</section>

<%@ include file="../common/footer.jsp" %>