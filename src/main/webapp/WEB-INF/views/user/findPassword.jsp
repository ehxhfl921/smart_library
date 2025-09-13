<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju2">
  <div id="wrap">
    <h1>비밀번호 찾기</h1>

    <!-- 비밀번호 찾기 입력 폼 -->
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
        <tr id="pwRow" style="display:none;">
          <th>새 비밀번호</th>
          <td><input type="password" id="newPw" required></td>
        </tr>
        <tr id="pwConfirmRow" style="display:none;">
          <th>비밀번호 확인</th>
          <td><input type="password" id="confirmPw" required></td>
        </tr>
      </table>
      <br>
      <input type="button" id="resetPwBtn" value="비밀번호 변경" class="btn_login" style="display:none;">
      <p id="resultMsg" class="info-msg"></p>
    </form>
  </div>
</section>

<script>
  const path = "${pageContext.request.contextPath}";
  let emailCode = "";
  let verified = false;
  let requestSent = false; // 중복 방지 

  // 인증코드 요청
  document.getElementById("requestCodeBtn").onclick = function(){
    const id = document.getElementById("id").value.trim();
    const email = document.getElementById("email").value.trim();

    if(!id || !email){
      document.getElementById("resultMsg").innerHTML =
        "<p class='info-msg'>아이디와 이메일을 입력해주세요.</p>";
      return;
    }
    
    // 중복 방지
    requestSent = true;
    document.getElementById("requestCodeBtn").disabled = true;


    fetch(path + "/user/checkEmailForPw?id=" + id + "&email=" + email)
      .then(res => res.text())
      .then(result => {
        if(result){
          return fetch(path + "/user/sendEmail?email=" + email);
        } else {
          throw new Error("일치하는 회원이 없습니다.");
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
        document.getElementById("resultMsg").innerHTML =
          "<p class='info-msg'>" + err.message + "</p>";
      });
  };

  // 인증코드 확인
  document.getElementById("verifyCodeBtn").onclick = function(){
    const inputCode = document.getElementById("emailCodeInput").value.trim();
    if(inputCode === emailCode){
      verified = true;
      document.getElementById("resultMsg").innerHTML =
        "<p class='info-msg'>인증 성공했습니다. 새 비밀번호를 입력하세요.</p>";
      document.getElementById("pwRow").style.display = "table-row";
      document.getElementById("pwConfirmRow").style.display = "table-row";
      document.getElementById("resetPwBtn").style.display = "block";
    } else {
      verified = false;
      document.getElementById("resultMsg").innerHTML =
        "<p class='info-msg'>인증코드가 일치하지 않습니다.</p>";
    }
  };

  // 비밀번호 변경
  document.getElementById("resetPwBtn").onclick = function(){
    if(!verified){
      document.getElementById("resultMsg").innerHTML =
        "<p class='info-msg'>먼저 이메일 인증을 완료해주세요.</p>";
      return;
    }

    const id = document.getElementById("id").value.trim();
    const newPw = document.getElementById("newPw").value.trim();
    const confirmPw = document.getElementById("confirmPw").value.trim();

    if(newPw !== confirmPw){
      document.getElementById("resultMsg").innerHTML =
        "<p class='info-msg'>비밀번호가 일치하지 않습니다.</p>";
      return;
    }

    fetch(path + "/user/resetPw", {
      method: "POST",
      headers: { "Content-Type": "application/x-www-form-urlencoded" },
      body: "id=" + encodeURIComponent(id) + "&pw=" + encodeURIComponent(newPw)
    })
    .then(res => res.text())
    .then(msg => {
      document.getElementById("resultMsg").innerHTML =
        "<p class='info-msg'><span class='highlight'>비밀번호가 변경되었습니다.</span> 새 비밀번호로 로그인해주세요.</p>";
      setTimeout(() => { window.location.href = path + "/user/goToLogin"; }, 2000);
    })
    .catch(err => {
      document.getElementById("resultMsg").innerHTML =
        "<p class='info-msg'>비밀번호 변경에 실패했습니다. 다시 시도해주세요.</p>";
    });
  };
</script>

<%@ include file="../common/footer.jsp" %>

<style>
section.jinju2 .info-msg {
  text-align: center;
  font-size: 15px;
  margin-top: 15px;
  color: #111; 
}
section.jinju2 .highlight {color: #0d47a1;}
</style>

