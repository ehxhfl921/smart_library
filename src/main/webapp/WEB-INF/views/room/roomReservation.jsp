<!-- 스터디룸 예약 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>
<fmt:formatDate value="${today}" pattern="yyyy-MM-dd" var="todayStr" />

<section class="mainSection1">

<aside class="sidebar" style="width:220px;">
      <div class="sidebar-header">도서관 이용</div>
      <div class="sidebar-item">
      	<a href="${path}/libraryInfo">이용 안내</a>
      </div>
      <div class="sidebar-item">
      	<a href="${path}/studyroom"
      	   style="background-color:#f1f3f5;color:#0d47a1;font-weight:bold;">
      		스터디룸 예약
      	</a>
      </div>
</aside>

	<main class="roomReservation">
      <h2>스터디룸 예약</h2>
	  <hr>
      <p>* 당일 예약은 불가합니다.</p>
      <p>* 스터디룸 예약을 신청하신 뒤, 관리자의 승인 후에 이용 가능합니다. (최대 3 영업일 소요)</p>
      <p>* 예약 신청하실 날짜를 선택해 주세요.</p>
      <div class="date-selection">
        <input type="text" id="date" class="date-input">
        <button class="select-button" id="btn">선택</button>
      </div>

      <div id="studyroomBox">
        <!-- 스터디룸 출력 -->
      </div>
    </main>
</section>

<script>

	flatpickr("#date", {
	    enableTime: false,       // 시간 선택 여부
	    dateFormat: "Y-m-d",     // 포맷
	    minDate: "today",        // 오늘 이후만 선택 가능
	    locale: "ko"             // 한국어
	});
	
	const contextPath = "${path}";
	const dateInput = document.querySelector("#date");
	
	const btn = document.querySelector("#btn");
	
	let selectedRoom = null;
	let reserveDate = null;
	
	btn.addEventListener("click", ()=>{
		const date = dateInput.value;
		reserveDate = date;
		
		// 날짜 선택하지 않고 클릭한 경우 return
	    if(!date) return;
	    
	    const todayStr = "${todayStr}";
		
	    // 오늘 날짜가 선택된 경우 return
	    if (date === todayStr) {
	    	alert("당일 예약은 불가합니다.");
	      	return;
	    }
	    
	    // 오늘 이전의 날짜가 선택된 경우 return
	    if(date < todayStr){
	    	alert("오늘 이전 날짜는 예약할 수 없습니다.");
	    	return;
	    }
		
		fetch(`\${contextPath}/studyroom/\${date}`)
		.then(res => {
			return res.json();
		}).then(result => {
			let rooms = result.rooms;
			let reservedRooms = result.reservedRooms;
			
			displayRooms(rooms, reservedRooms);
			
		}).catch(err => {
			console.log(err.message);
		});
		
		
	});
	
	// 스터디룸 박스 출력 함수
	// 출력된 스터디룸 박스 중 하나 선택 시 해당 스터디룸 번호 selectedRoom에 저장
	function displayRooms(rooms, reservedRooms) {
	    const container = document.querySelector("#studyroomBox");
	    container.style.border = "1px solid #ccc";
	    container.style.width = "800px";
	    
	    container.innerHTML = ""; // 기존 내용 초기화
		selectedRoom = null;

	    let html = `
	    	<p>
	    		<span style='color:#0d47a1;'> ■ 예약 가능</span>
	    		<span style='color:grey;'>□ 예약 불가</span>
	    	</p>
	    `;
		
	    const reservedSet = new Set(reservedRooms.map(r => r.sno));
	    
	    rooms.forEach(room => {
	    	
	    	const roomName = room.s_name;
	    	
	        // sno가 예약 리스트에 있으면 false, 없으면 true
	        const isAvailable = !reservedSet.has(room.sno);
	        
	        let className = isAvailable ? "available" : "unavailable";
	
	        html += `
	        	<div class='\${className}' data-sno='\${room.sno}'>
	        		\${roomName}
	        	</div>
	        `;
	        
	    });

	    html += `
	    	<div class='btnBox'>
	    		<button id='reserveBtn' class='select-button'>예약하기</button>
    		</div>
	    `;
	    
	    container.innerHTML = html;
	    
	    document.querySelectorAll(".available").forEach(div => {
	        div.addEventListener("click", () => {
	            const prev = container.querySelector(".selected");
	            if (prev) prev.classList.remove("selected");

	            div.classList.add("selected");
	            selectedRoom = div.dataset.sno; // data-sno 속성에서 번호 가져오기
	            console.log(selectedRoom);
	        });
	    });
	    
	 	// 스터디룸 선택 후 예약하기 버튼 클릭 시 예약 정보 예약 테이블에 저장
		const reserveBtn = document.querySelector("#reserveBtn");
	 
	    if(reserveBtn != null){
	        reserveBtn.addEventListener("click", () => {
	            
	        	if(!selectedRoom){
	                alert("예약할 스터디룸을 선택해주세요.");
	                return;
	            }

	        	// confirm으로 선택 정보 확인
	            const confirmMsg = `\${reserveDate}에 \${selectedRoom}번 스터디룸을 예약 신청하시겠습니까?`;
	            const ok = confirm(confirmMsg);
	            if(!ok) return; // 취소하면 아무것도 안 함
	        	
	        	
	            const data = { 
	                sno: selectedRoom,
	                date: reserveDate
	            };

	            fetch(`\${contextPath}/studyroom`, {
	                method: "POST",
	                headers: { 
	                	"Content-Type": "application/json",
	                	"X-Requested-With": "XMLHttpRequest"
	                },
	                body: JSON.stringify(data)
	            }).then(res =>{
	            	
	            	if (!res.ok) {
	                    return res.json().then(err => { throw err; });  
	                }
	            	
	                return res.text();
	                
	            }).then(msg => {
	            	alert(msg);
	            	
	            	location.reload();
	           
	            }).catch(err => {
	            	alert(err.msg);
	            	if(err.redirect) {
	                    location.href = err.redirect;
	                }
	            });
	            
	        }); // end 예약하기 event
	    }
	} // end displayRooms

	
</script>

<%@ include file="../common/footer.jsp" %>