<!-- 회원 가입 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju2">
	<div id="wrap">
	  <h1>회원가입</h1>

	  <form id="joinForm" action="${path}/user/join" method="POST">
	    <table>
	      <tr>
	        <th>아이디</th>
	        <td>
	          <input type="text" name="id" id="id" autocomplete="off" required>
	        </td>
	      </tr>
	      <tr>
	        <th>비밀번호</th>
	        <td>
	          <input type="password" name="pw" id="pw" required>
	        </td>
	      </tr>
	      <tr>
	        <th>이름</th>
	        <td>
	          <input type="text" name="name" id="name" required>
	        </td>
	      </tr>
	      <tr>
	        <th>전화번호</th>
	        <td>
	          <input type="text" name="phone" id="phone" placeholder="ex) 01012345678">
	        </td>
	      </tr>
	      <tr>
 			 <th>이메일</th>
				  <td>
				    <input type="text" name="email" id="email" required>
				  </td>
			</tr>
	      <tr>
	        <th>주소</th>
	        <td>
	          <input type="text" name="addr" id="addr" placeholder="ex) 서울시 강남구 역삼동" required>
	        </td>
	      </tr>
	      <tr>
	        <th>개인정보 동의</th>
	        <td>
	          <input type="checkbox" name="info" id="info" value="Y"> 동의합니다
	        </td>
	      </tr>
	      <tr>
	        <td colspan="2" style="text-align:center;">
	          <button type="submit" class="btn_login">회원등록</button>
	        </td>
	      </tr>
	    </table>
	  </form>
	</div>
</section>

<%@ include file="../common/footer.jsp" %>
