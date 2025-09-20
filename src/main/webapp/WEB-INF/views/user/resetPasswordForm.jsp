<!-- 비밀번호 찾기 - 변경할 새로운 비밀번호 입력 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>

<section class="mainSection2">
<main>
<div id="wrap">
    <h1>비밀번호 변경</h1>

    <form action="${path}/user/resetPw" method="post" >
      <input type="hidden" name="id" value="${id}" />


      <table>
        <tr>
          <th>새 비밀번호</th>
          <td>
          	<input type="password" name="pw" id="pw" required />
          	<div class="result"></div>
          </td>
          
        </tr>
        <tr>
          <th>새 비밀번호 확인</th>
          <td>
          	<input type="password" name="confirmPassword"  id ="confirmPassword" required />
          	<div class="result"></div>
          	</td>
        </tr>
      </table>
      <input type="submit" value="변경하기" class="btn_login" style="margin-top:15px;"/>
    </form>
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
			el.innerHTML = `<span style="color:\${isValid ? 'green':'red'}">\${msg}</span>`;
			el.style.display = "block";
		}
	
	
	// 비밀번호 확인
	let boolPw = false; 
	
	var regexPw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;	
	
	let pw = document.querySelector("#pw");
	
	pw.oninput = function(e){
		let el = pw.parentElement.querySelector(".result");
		console.log(el);
		let msg = "특수 문자, 숫자, 영문 포함 8~16자 이내 작성"; 
		boolPw = checkRegex(el, pw.value, regexPw, msg);
		
		if(boolPw) showMessage(el, "사용 가능한 비밀번호입니다." , true);
	
	};
	
	// 비밀번호 확인 여부
	let boolPwCheck = false;
	
	let re_pw = document.querySelector("#confirmPassword");
	
	re_pw.oninput = function(e){
		
		let el = re_pw.parentElement.querySelector(".result");
		
		if(boolPw){
			boolPwCheck = (re_pw.value === pw.value);
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