<!-- 내 회원 정보 수정 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="mainSection2">
<main>
<div id="wrap">
  <h1>회원정보 수정</h1>

  <div class="login_wrap">
    <form  method="post" action="${path}/user/modifyInfo" autocomplete="off"  onsubmit="return validateForm()">
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
          <input type="password" name="pwConfirm" id="re_pw" placeholder="새 비밀번호 확인">
          <div class="result"></div>
          </td>
        </tr>
        <tr>
          <th>이름</th>
          <td><input type="text" name="name" value="${userInfo.name}"></td>
        </tr>
        <tr>
          <th>전화번호</th>
          <td><input type="text" name="phone" value="${userInfo.phone}" placeholder="전화번호"></td>
        </tr>
        <tr>
          <th>이메일</th>
          <td><input type="text" name="email" value="${userInfo.email}"></td>
        </tr>
        <tr>
          <th>주소</th>
          <td class="addrBox">
          <input type="text" value="${userInfo.addr_post}" name="addr_post" id="addr_post" readonly placeholder="우편번호">
          <input type="button" onclick="execDaumPostcode()" value="우편번호 찾기"><br>
          <input type="text" value="${userInfo.addr}" name="addr" id="addr" readonly placeholder="주소"><br>
          <input type="text" value="${userInfo.addr_detail}" name="addr_detail" id="addr_detail"
           placeholder="상세 주소" required style="margin-bottom:6px;">
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }

                    addr += (extraAddr != '') ? extraAddr : '';
                
                }

                document.getElementById('addr_post').value = '';
                document.getElementById('addr').value = '';
                document.getElementById('addr_detail').value = '';
                
                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('addr_post').value = data.zonecode;
                document.getElementById('addr').value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('addr_detail').focus();
            }
        }).open();
    }
</script>
<script>
	function checkRegex(el, value, regex, msg){
		  if(!regex.test(value)){
		    showMessage(el, msg, false);
		    return false;
		  }
		  return true;
		}
	
		function showMessage(el, msg, isCheck){
		  el.innerText = msg;
		  el.style.color = isCheck ? "green" : "red";
		  el.style.display = "block";
		}
	
	
	// 비밀번호 확인
	let boolPw = false; 
	
	var regexPw = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,16}$/;	
	
	let pw = document.querySelector("#pw");
	
	pw.oninput = function(e){
		let el = pw.parentElement.querySelector(".result");
		if(pw.value.trim()===""){ el.style.display="none"; return; }
		let msg = "특수문자,숫자,영문 포함 8~16자 이내 작성"; 
		boolPw = checkRegex(el, pw.value, regexPw, msg);
		
		if(boolPw) showMessage(el, "사용 가능합니다." , true);
	
	};
	
	// 비밀번호 확인 여부
	let boolPwCheck = false;
	
	let re_pw = document.querySelector("#re_pw");
	
	re_pw.oninput = function(e){
		
		let el = re_pw.parentElement.querySelector(".result");
		if(re_pw.value.trim()===""){ el.style.display="none"; return; }
		
		if(boolPw){
			boolPwCheck = (re_pw.value == pw.value);
			let msg = boolPwCheck ? "비밀번호가 일치합니다. " : " 비밀번호가 일치하지 않습니다.";
			showMessage(el, msg, boolPwCheck);
		}else{
			showMessage(el, "비밀번호를 먼저 확인해주세요." , false);
		}
	} // 비밀번호 확인 check 
	
	function validateForm() {
	    const pwVal = document.getElementById("pw").value.trim();
	    const reVal = document.getElementById("re_pw").value.trim();


	    if(pwVal !== "" || reVal !== ""){
	      if (pwVal !== reVal) {
	        alert("비밀번호가 일치하지 않습니다.");
	        return false;
	      }
	    }
	    return true;
	  }

</script>



<%@ include file="../common/footer.jsp" %>