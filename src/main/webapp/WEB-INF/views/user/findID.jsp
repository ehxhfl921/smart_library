<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>

<%@ include file="../common/header.jsp" %>

<section class="jinju2">
  <div id="wrap">
    <h1>아이디 찾기</h1>

    <!-- 에러 메시지 -->
    <c:if test="${not empty error}">
      <p class="info-msg" style="color:red">${error}</p>
    </c:if>

    <!-- 성공 메시지 -->
    <c:if test="${not empty userId}">
      <p class="info-msg">회원님의 아이디는 <span class="highlight">${userId}</span> 입니다.</p>
    </c:if>

    <!-- 아이디 찾기 입력 폼 -->
    <form id="findIdForm">
      <table>
        <tr>
          <th>이름</th>
          <td><input type="text" id="name" name="name" required></td>
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
      <br>
      <input type="button" id="findIdBtn" value="아이디 찾기" class="btn_login">
      <p id="resultMsg" class="info-msg"></p>
    </form>
  </div>
</section>

<script>
  const path = "${path}";
  let emailCode = "";
  let verified = false;
  let requestSent = false; // 중복 방지 
  
  // 인증코드 요청 버튼
  document.getElementById("requestCodeBtn").onclick = function(){
    const name = document.getElementById("name").value.trim();
    const email = document.getElementById("email").value.trim();

    if(!name || !email){
      document.getElementById("resultMsg").innerHTML =
        "<p class='info-msg' style='color:red'>이름과 이메일을 입력해주세요.</p>";
      return;
    }
    
    // 중복 방지
    requestSent = true;
    document.getElementById("requestCodeBtn").disabled = true;

    fetch(path + "/user/checkEmailForId?name=" + name + "&email=" + email)
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
          "<p class='info-msg' style='color:red'>" + err.message + "</p>";
      });
  };

  // 인증코드 확인 버튼
  document.getElementById("verifyCodeBtn").onclick = function(){
    const inputCode = document.getElementById("emailCodeInput").value.trim();
    if(inputCode === emailCode){
      verified = true;
      document.getElementById("resultMsg").innerHTML =
        "<p class='info-msg'>인증 성공했습니다. 이제 아이디 찾기를 진행하세요.</p>";
    } else {
      verified = false;
      document.getElementById("resultMsg").innerHTML =
        "<p class='info-msg' style='color:red'>인증코드가 일치하지 않습니다.</p>";
    }
  };

  // 아이디 찾기 버튼
  document.getElementById("findIdBtn").onclick = function(){
    if(!verified){
      document.getElementById("resultMsg").innerHTML =
        "<p class='info-msg' style='color:red'>먼저 이메일 인증을 완료해주세요.</p>";
      return;
    }

    const email = document.getElementById("email").value.trim();
    fetch(path + "/user/findId?email=" + email)
      .then(res => res.text())
      .then(userId => {
        document.getElementById("resultMsg").innerHTML =
          "<p class='info-msg'>회원님의 아이디는 <span class='highlight'>" + userId + "</span> 입니다.</p>";
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




