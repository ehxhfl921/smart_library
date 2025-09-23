<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ include file="../common/header.jsp" %>

<section class="mainSection2">
<main>
  <div id="wrap">
    <h1>아이디 찾기</h1>

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
      <p id="resultMsg" class="info-msg" style="margin-bottom:15px;margin-top:-20px;"></p>
      <input type="button" id="findIdBtn" value="아이디 찾기" class="btn_login">
    </form>
  </div>
</main>
</section>

<script>
  const path = "${path}";
  let emailCode = "";
  let verified = false;
  let requestSent = false; // 중복 방지 
  document.getElementById("findIdBtn").style.display = 'block';
  
  // 인증코드 요청 버튼
  document.getElementById("requestCodeBtn").onclick = function(){
    const name = document.getElementById("name").value.trim();
    const email = document.getElementById("email").value.trim();

 	// 기존 메시지 초기화
    document.getElementById("resultMsg").innerHTML = "";
    
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
          throw new Error("일치하는 회원이 없습니다. 이름과 이메일을 확인해 주세요.");
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
          "<p class='info-msg' style='color:red'>" + err.message + "</p>";
      });
  };

  // 인증코드 확인 버튼
  document.getElementById("verifyCodeBtn").onclick = function(){
    const inputCode = document.getElementById("emailCodeInput").value.trim();
    if(inputCode === emailCode){
      verified = true;
      document.getElementById("resultMsg").innerHTML =
        "<p class='info-msg'>인증에 성공했습니다. <br>이제 아이디 찾기 버튼을 눌러 아이디 찾기를 진행하세요.</p>";
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
      .then(res => res.json())
      .then(list => {
			if(list && list.length > 0){
			    let idListHtml = `<p class='info-msg'>회원님의 정보와 일치하는 아이디입니다.</p>
			    	<div class='idListBox'>
			    `;
			
			    list.forEach(id => {
			        idListHtml += `<span class='highlight'>◦ \${id}</span><br>`;
			    });
			
			    idListHtml += `
			    	<p class='goToLogin'><a href='\${path}/user/goToLogin' class='btn-link'>로그인 하러가기</a></p>
			    	</div>
			    `;
			
			    document.getElementById("resultMsg").innerHTML = idListHtml;
			    document.getElementById("findIdBtn").style.display = 'none';
			    
			} else {
			    document.getElementById("resultMsg").innerHTML =
			        "<p class='info-msg' style='color:red'>일치하는 아이디가 없습니다.</p>";
			} // end if else
     }); // end fetch
  }; 
</script>

<%@ include file="../common/footer.jsp" %>




