<!-- 회원 가입 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju2">
<main>
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
	        <th>개인 정보 이용 동의</th>
	        <td>
	          <textarea rows="15" cols="15">
개인정보처리방침

제1조(목적)
스마트도서관(이하 '회사'라고 함)는 회사가 제공하고자 하는 서비스(이하 '회사 서비스')를 이용하는 개
인(이하 '이용자' 또는 '개인')의 정보(이하 '개인정보')를 보호하기 위해, 개인정보보호법, 정보통신망 이
용촉진 및 정보보호 등에 관한 법률(이하 '정보통신망법') 등 관련 법령을 준수하고, 서비스 이용자의 개
인정보 보호 관련한 고충을 신속하고 원활하게 처리할 수 있도록 하기 위하여 다음과 같이 개인정보처리
방침(이하 '본 방침')을 수립합니다.

제2조(개인정보 처리의 원칙)
개인정보 관련 법령 및 본 방침에 따라 회사는 이용자의 개인정보를 수집할 수 있으며 수집된 개인정보는
개인의 동의가 있는 경우에 한해 제3자에게 제공될 수 있습니다. 단, 법령의 규정 등에 의해 적법하게 강
제되는 경우 회사는 수집한 이용자의 개인정보를 사전에 개인의 동의 없이 제3자에게 제공할 수도 있습
니다.

제3조(본 방침의 공개)
1. 회사는 이용자가 언제든지 쉽게 본 방침을 확인할 수 있도록 회사 홈페이지 첫 화면 또는 첫 화면과의 연결
화면을 통해 본 방침을 공개하고 있습니다.
2. 회사는 제1항에 따라 본 방침을 공개하는 경우 글자 크기, 색상 등을 활용하여 이용자가 본 방침을 쉽게 확
인할 수 있도록 합니다.

제4조(본 방침의 변경)
1. 본 방침은 개인정보 관련 법령, 지침, 고시 또는 정부나 회사 서비스의 정책이나 내용의 변경에 따라 개정될
수 있습니다.
2. 회사는 제1항에 따라 본 방침을 개정하는 경우 다음 각 호 하나 이상의 방법으로 공지합니다.
가. 회사가 운영하는 인터넷 홈페이지의 첫 화면의 공지사항란 또는 별도의 창을 통하여 공지하는 방법
나. 서면·모사전송·전자우편 또는 이와 비슷한 방법으로 이용자에게 공지하는 방법
3. 회사는 제2항의 공지는 본 방침 개정의 시행일로부터 최소 7일 이전에 공지합니다. 다만, 이용자 권리의 중
요한 변경이 있을 경우에는 최소 30일 전에 공지합니다.

제5조(회원 가입을 위한 정보)
회사는 이용자의 회사 서비스에 대한 회원가입을 위하여 다음과 같은 정보를 수집합니다.
1. 필수 수집 정보: 이메일 주소, 비밀번호, 이름, 생년월일 및 휴대폰 번호
2. 선택 수집 정보: 프로필 사진, 주소

제6조(본인 인증을 위한 정보)
회사는 이용자의 본인인증을 위하여 다음과 같은 정보를 수집합니다.
1. 필수 수집 정보: 휴대폰 번호 및 이메일 주소


제7조(개인정보 수집 방법)
회사는 다음과 같은 방법으로 이용자의 개인정보를 수집합니다.
1. 이용자가 회사의 홈페이지에 자신의 개인정보를 입력하는 방식
2. 어플리케이션 등 회사가 제공하는 홈페이지 외의 서비스를 통해 이용자가 자신의 개인정보를 입력하는 방식
3. 회원가입

제8조(개인정보의 이용)
회사는 개인정보를 다음 각 호의 경우에 이용합니다.
1. 공지사항의 전달 등 회사운영에 필요한 경우
2. 이용문의에 대한 회신, 불만의 처리 등 이용자에 대한 서비스 개선을 위한 경우
3. 회사의 서비스를 제공하기 위한 경우
4. 법령 및 회사 약관을 위반하는 회원에 대한 이용 제한 조치, 부정 이용 행위를 포함하여 서비스의 원활한 운
영에 지장을 주는 행위에 대한 방지 및 제재를 위한 경우
5. 신규 서비스 개발을 위한 경우

제9조(개인정보의 보유 및 이용기간)
1. 회사는 이용자의 개인정보에 대해 개인정보의 수집·이용 목적 달성을 위한 기간 동안 개인정보를 보유 및
이용합니다.
2. 전항에도 불구하고 회사는 내부 방침에 의해 서비스 부정이용기록은 부정 가입 및 이용 방지를 위하여 회원
탈퇴 시점으로부터 최대 1년간 보관합니다.

제10조(법령에 따른 개인정보의 보유 및 이용기간)
회사는 관계법령에 따라 다음과 같이 개인정보를 보유 및 이용합니다.
1. 전자상거래 등에서의 소비자보호에 관한 법률에 따른 보유정보 및 보유기간
가. 계약 또는 청약철회 등에 관한 기록 : 5년
나. 대금결제 및 재화 등의 공급에 관한 기록 : 5년
다. 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년
라. 표시·광고에 관한 기록 : 6개월
2. 통신비밀보호법에 따른 보유정보 및 보유기간
가. 웹사이트 로그 기록 자료 : 3개월
3. 전자금융거래법에 따른 보유정보 및 보유기간
가. 전자금융거래에 관한 기록 : 5년
4. 위치정보의 보호 및 이용 등에 관한 법률
가. 개인위치정보에 관한 기록 : 6개월

제11조(개인정보의 파기원칙)
회사는 원칙적으로 이용자의 개인정보 처리 목적의 달성, 보유·이용기간의 경과 등 개인정보가 필요하지
않을 경우에는 해당 정보를 지체 없이 파기합니다.

제12조(개인정보파기절차)
1. 이용자가 회원가입 등을 위해 입력한 정보는 개인정보 처리 목적이 달성된 후 별도의 DB로 옮겨져(종이의
경우 별도의 서류함) 내부 방침 및 기타 관련 법령에 의한 정보보호 사유에 따라(보유 및 이용기간 참조) 일
정 기간 저장된 후 파기 되어집니다.
2. 회사는 파기 사유가 발생한 개인정보를 개인정보보호 책임자의 승인절차를 거쳐 파기합니다.

제13조(개인정보파기방법)
회사는 전자적 파일형태로 저장된 개인정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 삭제하며,
종이로 출력된 개인정보는 분쇄기로 분쇄하거나 소각 등을 통하여 파기합니다.

제14조(광고성 정보의 전송 조치)
1. 회사는 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하는 경우 이용자의 명시적인 사전동
의를 받습니다. 다만, 다음 각호 어느 하나에 해당하는 경우에는 사전 동의를 받지 않습니다
가. 회사가 재화 등의 거래관계를 통하여 수신자로부터 직접 연락처를 수집한 경우, 거래가 종료된 날로
부터 6개월 이내에 회사가 처리하고 수신자와 거래한 것과 동종의 재화 등에 대한 영리목적의 광고성
정보를 전송하려는 경우
나. 「방문판매 등에 관한 법률」 에 따른 전화권유판매자가 육성으로 수신자에게 개인정보의 수집출처
를 고지하고 전화권유를 하는 경우
2. 회사는 전항에도 불구하고 수신자가 수신거부의사를 표시하거나 사전 동의를 철회한 경우에는 영리목적의
광고성 정보를 전송하지 않으며 수신거부 및 수신동의 철회에 대한 처리 결과를 알립니다.
3. 회사는 오후 9시부터 그다음 날 오전 8시까지의 시간에 전자적 전송매체를 이용하여 영리목적의 광고성 정
보를 전송하는 경우에는 제1항에도 불구하고 그 수신자로부터 별도의 사전 동의를 받습니다.
4. 회사는 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하는 경우 다음의 사항 등을 광고성 정
보에 구체적으로 밝힙니다.
가. 회사명 및 연락처
나. 수신 거부 또는 수신 동의의 철회 의사표시에 관한 사항의 표시
5. 회사는 전자적 전송매체를 이용하여 영리목적의 광고성 정보를 전송하는 경우 다음 각 호의 어느 하나에 해
당하는 조치를 하지 않습니다.
가. 광고성 정보 수신자의 수신거부 또는 수신동의의 철회를 회피·방해하는 조치
나. 숫자·부호 또는 문자를 조합하여 전화번호·전자우편주소 등 수신자의 연락처를 자동으로 만들어 내
는 조치
다. 영리목적의 광고성 정보를 전송할 목적으로 전화번호 또는 전자우편주소를 자동으로 등록하는 조치
라. 광고성 정보 전송자의 신원이나 광고 전송 출처를 감추기 위한 각종 조치
마. 영리목적의 광고성 정보를 전송할 목적으로 수신자를 기망하여 회신을 유도하는 각종 조치

제15조(아동의 개인정보보호)
1. 회사는 만 14세 미만 아동의 개인정보 보호를 위하여 만 14세 이상의 이용자에 한하여 회원가입을 허용합
니다.
2. 제1항에도 불구하고 회사는 이용자가 만 14세 미만의 아동일 경우에는, 그 아동의 법정대리인으로부터 그
아동의 개인정보 수집, 이용, 제공 등의 동의를 그 아동의 법정대리인으로부터 받습니다.
3. 제2항의 경우 회사는 그 법정대리인의 이름, 생년월일, 성별, 중복가입확인정보(ID), 휴대폰 번호 등을 추
가로 수집합니다.

제16조(이용자의 의무)
1. 이용자는 자신의 개인정보를 최신의 상태로 유지해야 하며, 이용자의 부정확한 정보 입력으로 발생하는 문
제의 책임은 이용자 자신에게 있습니다.
2. 타인의 개인정보를 도용한 회원가입의 경우 이용자 자격을 상실하거나 관련 개인정보보호 법령에 의해 처
벌받을 수 있습니다.
3. 이용자는 전자우편주소, 비밀번호 등에 대한 보안을 유지할 책임이 있으며 제3자에게 이를 양도하거나 대
여할 수 없습니다.

제17조(개인정보 유출 등에 대한 조치)
회사는 개인정보의 분실·도난·유출(이하 "유출 등"이라 한다) 사실을 안 때에는 지체 없이 다음 각 호의
모든 사항을 해당 이용자에게 알리고 방송통신위원회 또는 한국인터넷진흥원에 신고합니다.
1. 유출 등이 된 개인정보 항목
2. 유출 등이 발생한 시점
3. 이용자가 취할 수 있는 조치
4. 정보통신서비스 제공자 등의 대응 조치
5. 이용자가 상담 등을 접수할 수 있는 부서 및 연락처

제18조(개인정보 유출 등에 대한 조치의 예외)
회사는 전조에도 불구하고 이용자의 연락처를 알 수 없는 등 정당한 사유가 있는 경우에는 회사의 홈페이
지에 30일 이상 게시하는 방법으로 전조의 통지를 갈음하는 조치를 취할 수 있습니다.

제19조(개인정보 자동 수집 장치의 설치·운영 및 거부에 관한 사항)
1. 회사는 이용자에게 개별적인 맞춤서비스를 제공하기 위해 이용 정보를 저장하고 수시로 불러오는 개인정
보 자동 수집장치(이하 '쿠키')를 사용합니다. 쿠키는 웹사이트를 운영하는데 이용되는 서버(http)가 이용
자의 웹브라우저(PC 및 모바일을 포함)에게 보내는 소량의 정보이며 이용자의 저장공간에 저장되기도 합
니다.
2. 이용자는 쿠키 설치에 대한 선택권을 가지고 있습니다. 따라서 이용자는 웹브라우저에서 옵션을 설정함으
로써 모든 쿠키를 허용하거나, 쿠키가 저장될 때마다 확인을 거치거나, 아니면 모든 쿠키의 저장을 거부할
수도 있습니다.
3. 다만, 쿠키의 저장을 거부할 경우에는 로그인이 필요한 회사의 일부 서비스는 이용에 어려움이 있을 수 있
습니다.

제20조(쿠키 설치 허용 지정 방법)
웹브라우저 옵션 설정을 통해 쿠키 허용, 쿠키 차단 등의 설정을 할 수 있습니다.
1. Edge : 웹브라우저 우측 상단의 설정 메뉴 > 쿠키 및 사이트 권한 > 쿠키 및 사이트 데이터 관리 및 삭제
2. Chrome : 웹브라우저 우측 상단의 설정 메뉴 > 개인정보 및 보안 > 쿠키 및 기타 사이트 데이터
3. Whale : 웹브라우저 우측 상단의 설정 메뉴 > 개인정보 보호 > 쿠키 및 기타 사이트 데이터

제21조(회사의 개인정보 보호 책임자 지정)
1. 회사는 이용자의 개인정보를 보호하고 개인정보와 관련한 불만을 처리하기 위하여 아래와 같이 관련 부서
및 개인정보 보호 책임자를 지정하고 있습니다.
가. 개인정보 보호 책임자
1) 성명: 김진주	
2) 직책: CTO
3) 전화번호: 01020494820
4) 이메일: skris0125@naver.com

제22조(권익침해에 대한 구제방법)
1. 정보주체는 개인정보침해로 인한 구제를 받기 위하여 개인정보분쟁조정위원회, 한국인터넷진흥원 개인정
보침해신고센터 등에 분쟁해결이나 상담 등을 신청할 수 있습니다. 이 밖에 기타 개인정보침해의 신고, 상
담에 대하여는 아래의 기관에 문의하시기 바랍니다.
가. 개인정보분쟁조정위원회 : (국번없이) 1833-6972 (www.kopico.go.kr)
나. 개인정보침해신고센터 : (국번없이) 118 (privacy.kisa.or.kr)
다. 대검찰청 : (국번없이) 1301 (www.spo.go.kr)
라. 경찰청 : (국번없이) 182 (ecrm.cyber.go.kr)
2. 회사는 정보주체의 개인정보자기결정권을 보장하고, 개인정보침해로 인한 상담 및 피해 구제를 위해 노력
하고 있으며, 신고나 상담이 필요한 경우 제1항의 담당부서로 연락해주시기 바랍니다.
3. 개인정보 보호법 제35조(개인정보의 열람), 제36조(개인정보의 정정·삭제), 제37조(개인정보의 처리정지
등)의 규정에 의한 요구에 대 하여 공공기관의 장이 행한 처분 또는 부작위로 인하여 권리 또는 이익의 침해
를 받은 자는 행정심판법이 정하는 바에 따라 행정심판을 청구할 수 있습니다.
가. 중앙행정심판위원회 : (국번없이) 110 (www.simpan.go.kr)

부칙
제1조 본 방침은 2025.09.05.부터 시행됩니다.
    	
	          </textarea>
	          <input type="checkbox" name="info" id="info" value="Y"> 동의합니다
	        </td>
	      </tr>
	      <tr>
	        <td colspan="2" style="text-align:center;">
	          <input type="button" id="joinBtn" value="회원등록" class="btn_login">	
	        </td>
	      </tr>
	    </table>
	    
		</form>
	</div>
</main>
</section>

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
<%@ include file="../common/footer.jsp" %>



















