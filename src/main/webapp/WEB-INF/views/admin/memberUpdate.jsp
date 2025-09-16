<!-- 관리자 전용 / 회원 관리 - 회원 정보 수정 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju1>
<main class="manageUpdate">
<h2>회원 정보 수정</h2>

<form action="${path}/user/admin/modifyInfo" method="post">
  <input type="hidden" name="mno" value="${member.mno}">

<table class="form-table">
    <tr>
      <th>아이디</th>
      <td><input type="text" name="id" value="${member.id}" readonly></td>
    </tr>
    <tr>
      <th>비밀번호</th>
      <td><input type="password" name="pw" id="pw" placeholder="새 비밀번호 입력 (미입력 시 변경 없음)">
      <div class="result"></div>
      </td>
    </tr>
    <tr>
      <th>이름</th>
      <td><input type="text" name="name" value="${member.name}" required></td>
    </tr>
    <tr>
      <th>전화번호</th>
      <td><input type="text" name="phone" value="${member.phone}"></td>
    </tr>
    <tr>
      <th>이메일</th>
      <td><input type="email" name="email" value="${member.email}" required></td>
    </tr>
    <tr>
      <th>주소</th>
      <td><input type="text" name="addr" value="${member.addr}"></td>
    </tr>
    <tr>
      <th>개인정보 동의</th>
      <td>
        <input type="text" value="${member.info == 'Y' ? '동의' : '미동의'}" readonly>
        <input type="hidden" name="info" value="${member.info}">
      </td>
    </tr>
  </table>

  <div style="margin-top:16px; text-align:center;">
    <input type="submit" value="수정 완료" class="btn">
    <input type="button" value="목록" class="btn outline"
       onclick="location.href='${path}/user/admin/memberList?page=${cri.page}'">
  </div>
</form>
</main>
</section>

<script>
	function checkRegex(el, value, regex, msg){
		  if(!regex.test(value)){
		    showMessage(el, msg, false);
		    return false;
		  }
		  return true;
		}
	
		function showMessage(el, msg, isValid){
		  el.innerText = msg;
		  el.style.color = isValid ? "green" : "red";
		}
	
	
	// 비밀번호 확인
	let boolPw = false; 
	
	var regexPw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;	
	
	let pw = document.querySelector("#pw");
	
	pw.oninput = function(e){
		let el = pw.parentElement.querySelector(".result");
		let msg = "특수문자,숫자,영문 포함 8~16자 이내 작성"; 
		boolPw = checkRegex(el, pw.value, regexPw, msg);
		
		if(boolPw) showMessage(el, "사용가능합니다." , true);
	
	};

</script>

<%@ include file="../common/footer.jsp" %>