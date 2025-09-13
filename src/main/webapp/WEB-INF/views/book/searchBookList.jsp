<!-- 도서 검색 & 도서 목록 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="searchBook">
	 <main class="content">
	 
      <div class="search-section">
      
        <h2>통합 검색</h2>
        <div class="search-box">
	          <input type="text" id="keyword" placeholder="검색어를 입력하세요">
	          <button id="searchBtn" type="submit">검색</button>
        </div>
        
        <!-- 검색된 도서 목록 -->
        <div id="searchList">
        	
        </div>
        
        <!-- 페이징 블럭 -->
        <div id="pagenation">
        
        </div>
        
      </div>
      
    </main>
</section>


<script>

const contextPath = "${path}";


const searchBox = document.querySelector("#keyword");
const searchBtn = document.querySelector("#searchBtn");


document.addEventListener("DOMContentLoaded", () => {
	 const urlParams = new URLSearchParams(window.location.search);
	 const keyword = urlParams.get("keyword"); // ?keyword=xxx 로 넘어온 값
	 const page = urlParams.get("page") || 1;  // 없으면 기본 1페이지

	 if (keyword) {
	   // 검색어가 있으면 검색 결과 바로 보여주기
	   document.querySelector("#keyword").value = keyword; // 검색창에도 표시
	   getSearchList(keyword, page);
	 }
});





// 최초 검색 시 키워드 + 페이지 1로 도서 목록 검색
searchBtn.addEventListener("click", () => {
	const keyword = searchBox.value;
	getSearchList(keyword, 1);
});


// 검색어로 검색된 도서 목록과 pm 객체 받아와서 화면에 출력
function getSearchList(keyword, page) {

	const params = new URLSearchParams({
        keyword: keyword,
        page: page
    });

    fetch(contextPath + "/book/search/list?" + params.toString())
    .then(res => res.json())
    .then(data => {

       	let list = data.list;
          	let pm = data.pm;
       	
       	if(list && list.length > 0){
        	printList(list);
        	printPageNum(pm, keyword);
        	
        	window.scrollTo({
        		top : 30,
        		behavior : 'smooth'
        	});
       	}else{
       		const resultDiv = document.querySelector("#searchList");
       	    resultDiv.innerHTML = `<div class='none'>검색된 도서가 없습니다.</div>`;
       	    
       	 	document.querySelector("#pagenation").innerHTML = "";
       	}
            
    }).catch(err => {
        	console.error(err);
    });
} // end getSearchList()


// 검색된 도서 목록 페이지에 출력
function printList(list){
	
	console.log(list);
    
    // 검색된 도서 목록
    const resultDiv = document.querySelector("#searchList");
    resultDiv.innerHTML = ""; // 기존 내용 지우기
    let html = '';
    
	for(let i = 0; i < list.length; i++){
		
		let title = list[i].title;
		let author = list[i].author;
		let publisher = list[i].publisher;
		let p_date = list[i].p_date;
		let is_available = list[i].is_available;
		let cover = list[i].cover;
		
		let availableClass = is_available === "AVAILABLE" ? "available" : "unavailable";
		let available = availableClass === "available" ? "O 대출 가능" : "X 대출 불가";
		let color = availableClass === "available" ? "color:blue;" : "color:red;";
		html += `
			<div id='bookCard'>
    		<div class='coverBox'>
    			<img alt=\${title} src=\${contextPath}/\${cover}>
    		</div>
    		<div class='bookInfo'>
    			<div class='info-left'>
        			<p>제목</p>
        			<p>저자</p>
        			<p>발행 기관</p>
        			<p>발행 연도</p>
    			</div>
    			<div class='info-right'>
        			<p>\${title}</p>
        			<p>\${author}</p>
        			<p>\${publisher}</p>
        			<p>\${p_date}년</p>
    			</div>
    			<div>
  					<p class=\${availableClass} id='avail' style=\${color}>\${available}</p>
				</div>
    		</div>
    		
		</div>
		`;
	} // end for
	
	resultDiv.innerHTML = html;
	
} // end printList()


// 검색된 도서 목록 아래에 페이징 블럭 출력
function printPageNum(pm, keyword){

	console.log(pm);
	
	// 페이징 블럭
	const pageDiv = document.querySelector("#pagenation");
	pageDiv.innerHTML = "";
	let pagenation = '';
	
	let first = pm.first;
	let prev = pm.prev;
	let next = pm.next;
	let last = pm.last;
	
	let startPage = pm.startPage;
	let endPage = pm.endPage;
	let maxPage = pm.maxPage;
	
	if(first){
		pagenation += `
			<button class='pageBtn' id='textBtn' data-page=1>처음</button>
		`;
	}
	
	if(prev){
		pagenation += `
			<button class='pageBtn' id='textBtn' data-page=${pm.startPage-1}>이전</button>
		`;
	}
	
	for(let i = pm.startPage; i <= pm.endPage; i++){
		
		let active = '';
		
		if(i == pm.cri.page){
			active = 'active';
		}
		
		pagenation += `
			<button class='pageBtn' data-page=\${i} id=\${active}>
				\${i}
			</button>
		`;
	}
	
	if(next){
		pagenation += `
			<button class='pageBtn' id='textBtn' data-page=\${pm.endPage+1}>다음</button>
		`;
	}

	if(last){
		pagenation += `
			<button class='pageBtn' id='textBtn' data-page=\${pm.maxPage}>마지막</button>
		`;
	}
	
	pageDiv.innerHTML = pagenation;
	
	document.querySelectorAll(".pageBtn").forEach( btn => {
		btn.addEventListener("click", (e) => {
			const page = e.target.dataset.page;
			getSearchList(keyword, page);
		});
	});

} // end printPageNum()




</script>

<%@ include file="../common/footer.jsp" %>