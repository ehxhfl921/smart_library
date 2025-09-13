<!-- 회원 가입 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju2">
	<div id="wrap">
	  <h1>회원가입</h1>
	  
		<c:if test="${not empty msg}">
		  <script>
		    alert("${msg}");
		  </script>
		</c:if>

	  <form id="joinForm" action="${path}/user/join" method="POST">
	    <table>
			<tr>
			  <th>아이디</th>
			  <td>
			    <input type="text" name="id" id="id" autocomplete="off" required>
			    <div class="result"></div>  
			  </td>
			</tr>
	      <tr>
	        <th>비밀번호</th>
	        <td>
	          <input type="password" name="pw" id="pw" required>
	          <div class="result"></div>
	        </td>
	      </tr>
	      <tr>
	        <th>비밀번호 확인</th>
	        <td>
	          <input type="password" id="re_pw" required>
	          <div class="result"></div>
	        </td>
	      </tr>
	      <tr>
	        <th>이름</th>
	        <td>
	          <input type="text" name="name" id="name" required>
	          <div class="result"></div>
	        </td>
	      </tr>
	      <tr>
	        <th>전화번호</th>
	        <td>
	          <input type="text" name="phone" id="phone" placeholder="ex) 01012345678">
	          <div class="result"></div>
	        </td>
	      </tr>
		<tr>
		  <th>이메일</th>
		  <td>
		    <input type="text" name="email" id="email" required>
		    <button type="button" id="sendEmailBtn">인증코드 발송</button>
		    <div class="result"></div>
		  </td>
		</tr>
		
		<!-- 이메일 인증코드 입력칸 -->
		<tr id="emailCodeWrap" style="display:none;">
		  <th>인증코드</th>
		  <td>
		    <input type="text" id="emailCodeInput" placeholder="인증코드를 입력하세요">
		    <button type="button" id="checkEmailCodeBtn">확인</button>
		  </td>
		</tr>
			<tr>
			  <th>주소</th>
			  <td>
			    <input type="text" name="addr" id="addr" 
			           placeholder="ex) 부산광역시 해운대구 우동" required>
			    <div class="result"></div>
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
	          <input type="button" id="joinBtn" value="회원등록">	
	        </td>
	      </tr>
	    </table>
	    <script>
	
	function checkRegex(el, val, regex, message, ajax){
		if(!regex.test(val)){
			showMessage(el, message, false);
			return false;
		}else if(!ajax){
			showMessage(el, message, true);
			return true;
		}else{
			ajax(el, val);
		}
	} // check Regex
	
	function showMessage(el, msg, isCheck){
		  el.innerHTML = `<span style="\${isCheck ? 'color:green;' : 'color:red;'}">\${msg}</span>`;
		}

	
	// 아이디
	let boolId = false;
	
	let id = document.getElementById("id");
	
	let regexId = /^(?=.*[a-zA-Z])(?=.*[0-9])[a-zA-Z0-9]{4,12}$/;

	id.addEventListener("input", function(e){
		
		let val = id.value;
		console.log(val);
		let el = e.target.parentElement.querySelector(".result");
		console.log(el);
		
		boolId = checkRegex(el, id.value, regexId, "아이디는 4~12자의 영문+숫자 조합이어야 합니다.");
		if(boolId) showMessage(el, "사용가능합니다.", true);
	});
	
	
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
	
	// 이름
	let boolName = false;
	let name = document.getElementById("name");
	let regexName = /^[가-힣]{2,6}$/;

	name.oninput = function(){
		let el = name.parentElement.querySelector(".result");
		boolName = checkRegex(el, name.value, regexName, "이름은 2~6자의 한글만 가능합니다.");
		if(boolName) showMessage(el, "사용가능합니다.", true);
	};

	// 전화번호 
	let boolPhone = false;
	let phone = document.getElementById("phone");
	var regexMobile = /^01[0-9]{8,9}$/;

	phone.addEventListener("input", function(e){
		let el = e.target.parentElement.querySelector(".result");
		boolPhone = checkRegex(el, phone.value, regexMobile, "전화번호 형식(01012345678)으로 입력해주세요.");
		if(boolPhone) showMessage(el, "사용 가능한 전화번호입니다.", true);
	});
	
	// 이메일 
	let boolEmail = false;
	let email = document.getElementById("email");
	var regexEmail =/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;

	email.addEventListener("input", function(e){
		let el = e.target.parentElement.querySelector(".result");
		boolEmail = checkRegex(el, email.value, regexEmail, "올바른 이메일 형식이 아닙니다.");
		if(boolEmail) showMessage(el, "사용 가능한 이메일입니다.", true);
	});

	// 이메일 인증 관련
	let emailCode = "";
	let boolEmailCode = false;

	document.getElementById("sendEmailBtn").onclick = function(){
		if(!boolEmail){
			alert("올바른 이메일을 입력해주세요.");
			email.focus();
			return;
		}
		fetch("${path}/user/sendEmail?email=" + email.value)
		.then(res => res.text())
		.then(code => {
			if(code){
				emailCode = code;
				alert("인증 코드가 이메일로 발송되었습니다.");
				document.getElementById("emailCodeWrap").style.display = "table-row";
			}else{
				alert("이메일 발송 실패되었습니다.");
			}
		})
		.catch(err => alert("서버 오류 발생"));
	};

	document.getElementById("checkEmailCodeBtn").onclick = function(e){
		let userCode = document.getElementById("emailCodeInput").value;
		if(userCode === emailCode){
			boolEmailCode = true;
			alert("이메일 인증 완료");
			document.getElementById("emailCodeWrap").style.display = "none";
		}else{
			boolEmailCode = false;
			alert("인증 코드를 다시 확인해 주세요.");
		}
	};
	
	// 주소
	let boolAddr = false;
	let addr = document.getElementById("addr");

	addr.oninput = function(){
		  let el = addr.parentElement.querySelector(".result");
		  let regexAddr = /[가-힣]+(시|군)\s?[가-힣]+(구)?\s?[가-힣]+동/;
		  boolAddr = regexAddr.test(addr.value.trim());
		  let msg = boolAddr ? "주소 입력 완료" : "주소는 시/군/동까지 입력해주세요.";
		  showMessage(el, msg, boolAddr);
		};
	
		
	// 회원등록 버튼 click 시 입력 데이터 확인 후 데이터 등록 요청
document.getElementById("joinBtn").onclick = function(e){
		

		
    if(!boolId){
        alert("아이디를 확인해주세요.");
        id.focus();
        return;
    }
    if(!boolPw){
        alert("비밀번호를 확인해주세요.");
        pw.focus();
        return;
    }
    if(!boolPwCheck){
        alert("비밀번호를 확인해주세요.");
        re_pw.focus();
        return;
    }
    if(!boolEmailCode){
        document.getElementById("emailCodeInput").focus();
        alert("이메일 인증을 완료해 주세요.");
        return;
    }
    if(!boolName){
        name.focus();
        alert("이름 작성란을 확인해 주세요.");
        return;
    }
    let info = document.getElementById("info");
    if(!info.checked){
        info.focus();
        alert("개인정보 이용동의를 해주세요.");
        return;
    }

		document.querySelector("#joinForm").submit();
		
	} ; //  회원등록 버튼 click event

	


	</script>
</form>
</div>
</section>

<%@ include file="../common/footer.jsp" %>



















