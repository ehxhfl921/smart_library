<!-- 로그인 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="mainSection2">

<main>
  <div id="wrap">

    <h1>SMART 도서관</h1>
    
    <c:if test="${not empty msg}">
	  <script>
	    alert("${msg}");
	  </script>
	</c:if>

	 <form id="frmLogin" method="POST" action="${path}/user/login">
	  <div class="input_item">
	    <input type="text" id="id" name="id" maxlength="30" placeholder="아이디" required>
	  </div>
	  <div class="input_item">
	    <input type="password" id="pw" name="pw" maxlength="30" placeholder="비밀번호" required>
	  </div>
	
	  <div class="login_keep_wrap">
	    <label>
	      <input type="checkbox" name="autoLogin" value="Y"> 로그인 상태 유지
	    </label>
	  </div>
	
	  <button type="submit" class="btn_login">로그인</button>
	</form>

    <!-- 아이디/비번 찾기/회원가입 -->
    <ul class="find_wrap">
   	  <li><a href="${path}/user/join">회원가입</a></li>
      <li><a href="${path}/user/findIdForm">아이디 찾기</a></li>
      <li><a href="${path}/user/findPwForm">비밀번호 찾기</a></li>
      
      
    </ul>
  </div>
</main>
</section>


<%@ include file="../common/footer.jsp" %>
