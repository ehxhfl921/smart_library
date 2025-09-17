<!-- 건의 사항 상세 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="../common/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>

<section class="jinju1">
	<main class="noticeDetail">
        <h2>건의사항</h2>
		<hr>
		<div class="contentBox">
		
			<div class="head">
				<p class="noAndTitle">
					<span class="no">No.${suggestion.sug_no}</span>
					<span class="title">${suggestion.s_title}</span>
				</p>
				<p class="authAndDate">
					<span>◦ 작성자 : ${suggestion.s_author}</span> <br>
					<span>◦ 작성일 : <fmt:formatDate value="${suggestion.s_create_date}" pattern="yyyy-MM-dd hh:mm"/></span>
					
					<c:if test="${suggestion.s_update_date != null}">	
						<span>&nbsp;&nbsp;◦ 수정일 : <fmt:formatDate value="${suggestion.s_update_date}" pattern="yyyy-MM-dd hh:mm"/></span>
					</c:if>
				</p>
			</div>
			<div class="body">
				<pre>${suggestion.s_content}</pre>
			</div>
			
		</div>
	
		<div class="btnBox" style="margin-bottom:15px;">
			<c:if test="${userInfo.id eq suggestion.s_userid}">
			    <button type="button" class="btn"
                		onclick="if(confirm('건의 사항을 수정하시겠습니까?')) location.href='${path}/suggest/modifyForm?sug_no=${suggestion.sug_no}'">
                	수정
            	</button>
			</c:if>
			<c:if test="${(userInfo.id eq suggestion.s_userid) or (userInfo.id eq 'admin')}">	
			    <form action="${path}/suggest/delete" method="post" style="display:inline;">
	                <input type="hidden" name="sug_no" value="${suggestion.sug_no}">
	                <button type="submit" class="btn" onclick="return confirm('건의 사항을 삭제하시겠습니까?')">삭제</button>
            	</form>
			</c:if>
		</div>
		
		<hr>

		<!-- 댓글 작성 폼 -->
	 	<div class="replyFormBox" id="replyFormBox">
			<div class="replyHead">
				댓글 작성
			</div>
		 	<div class="replyContent">
		 		<textarea rows="5" cols="15" autofocus class="text"></textarea>
		 	</div>
		 	<div class="btnBox">
	 			<button class="btn" id="addReply">작성하기</button>
	 		</div>
	 	</div>
	 	
		<!-- 댓글 섹션 -->
		<div class="replyBox" id="replyBox">
		
		</div>
		
		<!-- 페이징 블럭 -->
		<div class="pagenation" id="pagenation">
		
		</div>
		
		<!-- 댓글 수정 폼 -->
		<div class="modifyFormBox" id="modifyFormBox" style="display:none;">
			<div class="replyHead">
				댓글 수정
			</div>
		 	<div class="replyContent">
		 		<textarea rows="5" cols="15" autofocus id="modifyText"></textarea>
		 	</div>
		 	<div class="btnBox">
	 			<button class="btn" id="modifyReply">수정하기</button>
	 		</div>
	 	</div>
		
	</main>
</section>

<script>

const path = "${path}";
let sug_no = "${suggestion.sug_no}";
const loginUser = "${userInfo.id}";

const textarea = document.querySelector(".text");
const replyBtn = document.querySelector("#addReply");

let modifyRplNo = null;

let page = 1;

// 댓글 목록 불러오기
getReplyList(page, sug_no);

function getReplyList(page, sug_no){
	
	let modDiv = document.querySelector("#modifyFormBox");
	modDiv.style.display = "none";
	// 수정 태그 이동
	document.body.prepend(modDiv);
	
	fetch(`${path}/comment/\${sug_no}/commentList?page=\${page}`)
	.then(res => res.json())
	.then(data => {
		
		// 페이징 처리된 댓글 목록 출력
		printReplies(data);
		
	})
	.catch(err => {
		console.log(err.message);
	});
} // end getReplyList()


let btnHtml = "";


function printReplies(data){
	let list = data.list;
	let pm = data.pm;
	
	let replyBox = document.querySelector("#replyBox");
	
	let html = '';
	
	for(let i = 0; i < list.length; i++){
		let rpl_no = list[i].rpl_no;
		let sug_no = list[i].sug_no;
		let user_id = list[i].user_id;
		let content = list[i].content;
		let rpl_create_date = list[i].rpl_create_date;
		let rpl_update_date = list[i].rpl_update_date;

		let createDate = new Date(rpl_create_date);
		let createDateStr = createDate.toLocaleString();
		
		let updateDate = null;
		let updateDateStr = null;
		
		//작성자인 경우
		if (loginUser === user_id) {
		 btnHtml = `
		     <a data-rplNo=\${rpl_no} class='modify'>수정</a> | 
		     <a data-rplNo=\${rpl_no} class='delete'>삭제</a>
		 `;
		}
		//관리자인 경우
		else if (loginUser === "admin") {
		 btnHtml = `
		     <a data-rplNo=\${rpl_no} class='delete'>삭제</a>
		 `;
		}
		
		if(rpl_update_date != null){
			updateDate = new Date(rpl_update_date);
			updateDateStr = updateDate.toLocaleString();
		}
		
		let author = (user_id === "admin") ? "관리자" : "글쓴이";
		
		html += `
			<div class='reply'>
			
				<div class='authorAndDate' style='display:flex;align-items:center;justify-content:space-between;'>
					<div class='author'>
						\${author}
					</div>
				
					<div class='date'>
						<p>작성 : <span>\${createDateStr}</span></p> `;
					
					
		if(updateDateStr != null){
			html += `
				
						<p class='updateDate'>수정 : <span>\${updateDateStr}</span></p>
			`;
		} // 수정 시간이 있다면 출력		
				
		
		html += `
					</div>
				</div>
				<div class='content'>
					<pre data-content=\${content}>\${content}</pre>
					<p>
						\${btnHtml}
					</p>
				</div>
				
			</div>
		`;
	} // end for
	
	if(page === 1){
		replyBox.innerHTML = html;
	}else{
		replyBox.insertAdjacentHTML("beforeend", html);
	} // end check 1 page
	

		
	// 페이징 블럭 출력
	const pagenation = document.querySelector("#pagenation");
	pagenation.innerHtml = '';
	let pageHtml = '';
	
	let first = pm.first;
	let prev = pm.prev;
	let next = pm.next;
	let last = pm.last;
	
	let startPage = pm.startPage;
	let endPage = pm.endPage;
	let maxPage = pm.maxPage;
	
	if(first){
		pageHtml += `
			<a class="pageBtn" data-page=1>[처음]</a>
		`;
	}
	
	if(prev){
		let prevPage = (pm.startPage > 1 ? pm.startPage - 1 : 1);
		
		pageHtml += `
			<a class="pageBtn" data-page=\${prevPage}>[이전]</a>
		`;
	}
	
	for(let i = pm.startPage; i <= pm.endPage; i++){
		
		let active = '';
		
		if(i == pm.cri.page){
			active = 'active';
		}
		
		pageHtml += `
			<a class="pageBtn" data-page=\${i} id=\${active}>
				[\${i}]
			</a>
		`;
	}
	
	if(next){
		pageHtml += `
			<a class="pageBtn" data-page=\${pm.endPage+1}>[다음]</a>
		`;
	}

	if(last && pm.maxPage > 1){
		pageHtml += `
			<a class="pageBtn" data-page=\${pm.maxPage}>[마지막]</a>
		`;
	}
	
	pagenation.innerHTML = pageHtml;
	
	document.querySelectorAll(".pageBtn").forEach( btn => {
		btn.addEventListener("click", (e) => {
			const page = e.target.dataset.page;
			getReplyList(page, sug_no);
		});
	});

} // end printReplies()


// 댓글 작성 버튼 클릭 이벤트
replyBtn.addEventListener("click", ()=>{
	
	const reply = textarea.value;
	
	if(reply == null || reply == ''){
		alert("댓글 내용을 작성해 주세요.");
		location.reload();
		return
	}
	
	const data = {
		content : reply	
	};

	fetch(`${path}/comment/\${sug_no}/addComment`, {
		method : "post",
		headers : {
			"Content-Type": "application/json",
        	"X-Requested-With": "XMLHttpRequest"
		},
		body : JSON.stringify(data)
	})
	.then(res => {
		if(!res.ok) return res.json().then(json => { throw new Error(json.msg) });
		return res.json();
 	})
	.then(data =>{
		alert("댓글이 등록되었습니다.");
		
		let newReply = data.comment;
		
		addReply(newReply);
		
	})
	.catch(err => {
		console.log(err.message);
	});
	
}); // end replyBtn addEventListener


function addReply(newReply){
	
	let replyBox = document.querySelector("#replyBox");
	
	let newhtml = '';
	
	// textarea 초기화
    textarea.value = "";

    // 댓글 replyBox에 추가
    let rpl_no = newReply.rpl_no;
	let sug_no = newReply.sug_no;
	let user_id = newReply.user_id;
	let content = newReply.content;
	let rpl_create_date = newReply.rpl_create_date;
	let rpl_update_date = newReply.rpl_update_date;

	let createDate = new Date(rpl_create_date);
	let createDateStr = createDate.toLocaleString();
	
	let updateDate = null;
	let updateDateStr = null;
	
	//작성자인 경우
	if (loginUser === user_id) {
	 btnHtml = `
	     <a data-rplNo=\${rpl_no} class='modify'>수정</a> | 
	     <a data-rplNo=\${rpl_no} class='delete'>삭제</a>
	 `;
	}
	//관리자인 경우
	else if (loginUser === "admin") {
	 btnHtml = `
	     <a data-rplNo=\${rpl_no} class='delete'>삭제</a>
	 `;
	}
	
	if(rpl_update_date != null){
		updateDate = new Date(rpl_update_date);
		updateDateStr = updateDate.toLocaleString();
	}
	
	let author = (user_id === "admin") ? "관리자" : "글쓴이";
	
	newhtml += `
		<div class='reply'>
		
			<div class='authorAndDate' style='display:flex;align-items:center;justify-content:space-between;'>
				<div class='author'>
					\${author}
				</div>
			
				<div class='date'>
					<p>작성 : <span>\${createDateStr}</span></p> `;
				
				
	if(updateDateStr != null){
		newhtml += `
			
					<p class='updateDate'>수정 : <span>\${updateDateStr}</span></p>
		`;
	} // 수정 시간이 있다면 출력		
			
	
	newhtml += `
				</div>
			</div>
			<div class='content'>
				<pre data-content=\${content}>\${content}</pre>
				<p>
					\${btnHtml}
				</p>
			</div>
			
		</div>
	`;

    // 맨 뒤에 추가
    replyBox.insertAdjacentHTML("beforeend", newhtml);
}

// 수정 버튼 클릭 시 댓글 아래에 수정 폼 출력
document.querySelector("#replyBox").addEventListener("click", function(e){
    if(e.target && e.target.classList.contains("modify")){
    	
        const pre = e.target.closest(".reply").querySelector("pre");
        const content = pre.innerText; 
        
        modifyRplNo = e.target.dataset.rplno;
        
        const modDiv = document.querySelector("#modifyFormBox");
        modDiv.style.display = "block";
        document.querySelector("#modifyText").value = content;

        e.target.closest(".reply").after(modDiv);
    }
}); // end 수정 폼 출력 eventListener

// 수정하기 버튼 클릭 시 수정 요청
document.querySelector("#modifyReply").onclick = ()=>{
	
	let content = document.querySelector("#modifyText").value;
	
	if(!content){
        alert("댓글 내용을 작성해주세요.");
        return;
    }

    if(!modifyRplNo){
        alert("댓글 번호가 없습니다.");
        return;
    }
	
    let rpl_no = modifyRplNo;
    
    const data = {
        rpl_no: rpl_no,
        content: content
    };
    
    fetch(`${path}/comment/modifyComment/\${modifyRplNo}`, {
        method : "PATCH",
        headers : {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
        },
        body : JSON.stringify(data)
    })
    .then(res => {
        if(!res.ok) return res.json().then(json => { throw new Error(json.msg) });
        return res.json();
    })
    .then(data =>{
        alert(data.msg);

        let modifiedReply = data.modifiedReply;

        // 댓글 화면에 바로 반영
        const replyBox = document.querySelector("#replyBox");
        const replies = replyBox.querySelectorAll(".reply");

        replies.forEach(reply => {
            const modifyLink = reply.querySelector(".modify");
            if(modifyLink && modifyLink.dataset.rplno == modifiedReply.rpl_no){
                const pre = reply.querySelector("pre");
                pre.textContent = modifiedReply.content;
                pre.dataset.content = modifiedReply.content;

                const dateDiv = reply.querySelector(".date");
                let updateDate = new Date(modifiedReply.rpl_update_date).toLocaleString();

                // 이미 수정일 p 태그가 있으면 업데이트, 없으면 생성
                let updateP = dateDiv.querySelector(".updateDate");
                if(updateP){
                    updateP.innerHTML = `수정 : <span>\${updateDate}</span>`;
                } else {
                    updateP = document.createElement("p");
                    updateP.classList.add("updateDate");
                    updateP.innerHTML = `수정 : <span>\${updateDate}</span>`;
                    dateDiv.appendChild(updateP);
                }
            }
        });

        // 수정 폼 숨기기
        document.querySelector("#modifyFormBox").style.display = "none";
        modifyRplNo = null;
    })
    .catch(err => {
        console.log(err.message);
    });
}; // end 댓글 수정 요청 버튼 클릭 이벤트
    	

// 삭제 클릭 시 댓글 삭제 요청
document.querySelector("#replyBox").addEventListener("click", function(e){
    if(e.target && e.target.classList.contains("delete")){
    	
        const rpl_no = e.target.dataset.rplno;
        if(!rpl_no) return;

        if(!confirm("정말 댓글을 삭제하시겠습니까?")) return;

        fetch(`${path}/comment/removeComment/\${rpl_no}`, {
            method: "PATCH",
            headers: {
                "Content-Type": "application/json",
                "X-Requested-With": "XMLHttpRequest"
            }
        })
        .then(res => {
            return res.text();
        })
        .then(msg => {
            alert(msg);

            getReplyList(1, sug_no);
        })
        .catch(err => {
            console.log(err.message);
        });
    }
});

</script>

<%@ include file="../common/footer.jsp" %>
