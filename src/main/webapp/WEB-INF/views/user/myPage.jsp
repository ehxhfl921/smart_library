<!-- 내 회원 정보 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju2">
<main>
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

	<div class="btn_group">
	  <form method="get" action="${path}/user/myPage/modifyInfo">
	    <button type="submit" class="btn_login">수정</button>
	  </form>
	
	  <form method="post" action="${path}/user/withdraw"
	        onsubmit="return confirm('정말 탈퇴하시겠습니까? 이 작업은 되돌릴 수 없습니다.');">
	    <input type="hidden" name="mno" value="${userInfo.mno}">
	    <button type="submit" class="btn_login">회원 탈퇴</button>
	  </form>
	</div>
  </div>
</div>

</main>
</section>

<%@ include file="../common/footer.jsp" %>