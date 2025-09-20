

<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="mainSection2">

<main>
  <div id="wrap">
    <h1>비밀번호 찾기</h1>


    <form id="findPwForm">
      <table>
		  <tr>
		    <th>아이디</th>
		    <td><input type="text" id="id" name="id" required></td>
		  </tr>
		  <tr>
		    <th>이메일</th>
		    <td>
		      <input type="email" id="email" name="email" required>
		      <button type="button" id="requestCodeBtn" class="btn_small">인증코드 요청</button>
		    </td>
		  </tr>

		  <tr id="codeRow" style="display:none;">
		    <th>인증코드</th>
		    <td>
		      <input type="text" id="emailCodeInput" placeholder="인증코드 입력">
		      <button type="button" id="verifyCodeBtn" class="btn_small">확인</button>
		    </td>
		  </tr>
		</table>
		<p id="resultMsg" class="info-msg"></p>
    </form>
  </div>
</main>
</section>

<script>
const path = "${path}";
  let emailCode = "";
  let verified = false;
  let requestSent = false; // 중복 방지 

  // 인증코드 요청
  document.getElementById("requestCodeBtn").onclick = function(){
    const id = document.getElementById("id").value.trim();
    const email = document.getElementById("email").value.trim();

 	// 기존 메시지 초기화
    document.getElementById("resultMsg").innerHTML = "";
 
    if(!id || !email){
      alert("아이디와 이메일을 입력해주세요.");
      return;
    }

    requestSent = true;
    document.getElementById("requestCodeBtn").disabled = true;

    fetch(path + "/user/checkEmailForPw?id=" + id + "&email=" + email)
      .then(res => res.text())
      .then(result => {
        if(result){
          return fetch(path + "/user/sendEmail?email=" + email);
        } else {
          throw new Error("일치하는 회원이 없습니다. 아이디와 이메일을 확인해 주세요.");
        }
      })
      .then(res => res.text())
      .then(code => {
        emailCode = code;
        document.getElementById("resultMsg").innerHTML =
          "<p class='info-msg'>인증코드가 이메일로 발송되었습니다.</p>";
        document.getElementById("codeRow").style.display = "table-row";
      })
      .catch(err => {
    	document.getElementById("requestCodeBtn").disabled = false;
        document.getElementById("resultMsg").innerHTML =
          "<p class='info-msg' style='color:red;'>" + err.message + "</p>";
      });
  };

  // 인증코드 확인 → resetPasswordForm.jsp 이동
  document.getElementById("verifyCodeBtn").onclick = function(){
    const inputCode = document.getElementById("emailCodeInput").value.trim();
    const id = document.getElementById("id").value.trim();
	
    console.log(id);
    console.log("테스트");
    
    if(inputCode === emailCode){
    	console.log(path + "/user/resetPwForm?id=" + encodeURIComponent(id));
      window.location.href = path + "/user/resetPwForm?id=" + encodeURIComponent(id);
    } else {
      document.getElementById("resultMsg").innerHTML =
        "<p class='info-msg' style='color:red'>인증코드가 일치하지 않습니다.</p>";
    }
  };
</script>

<%@ include file="../common/footer.jsp" %>

