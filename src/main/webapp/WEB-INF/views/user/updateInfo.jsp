<!-- 내 회원 정보 수정 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju2">
<main>
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
          <td>
          <input type="password" name="pw" id="pw" placeholder="비밀번호(미입력 시 변경 없음)">
          <div class="result"></div>
          </td>
        </tr>
        <tr>
          <th>새 비밀번호 확인</th>
          <td>
          <input type="password" name="pwConfirm" id="re_pw"placeholder="새 비밀번호 확인">
          <div class="result"></div>
          </td>
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
	
	// 비밀번호 확인 여부
	let boolPwCheck = false;
	
	let re_pw = document.querySelector("#re_pw");
	
	re_pw.oninput = function(e){
		
		let el = re_pw.parentElement.querySelector(".result");
		
		if(boolPw){
			boolPwCheck = (re_pw.value == pw.value);
			let msg = boolPwCheck ? "비밀번호가 일치합니다. " : " 비밀번호가 일치하지 않습니다.";
			showMessage(el, msg, boolPwCheck);
		}else{
			showMessage(el, "비밀번호를 먼저 확인해주세요." , false);
		}
	} // 비밀번호 확인 check 
	
	function validateForm() {
	const pw = document.getElementById("pw").value.trim();
	const confirmPw = document.getElementById("confirmPassword").value.trim();
	
	if (pw !== confirmPw) {
	  alert("비밀번호가 일치하지 않습니다.");
	  return false;
	}
	return true;
	}
	

</script>



<%@ include file="../common/footer.jsp" %>