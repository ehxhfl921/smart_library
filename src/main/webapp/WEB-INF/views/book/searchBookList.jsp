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
	          <button id="searchBtn">검색</button>
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

const contextPath = document.querySelector("meta[name='context-path']").content;

const searchBtn = document.querySelector("#searchBtn");
const searchBox = document.querySelector("#keyword");
const keyword = searchBox.value;


// 최초 검색 시 키워드 + 페이지 1로 도서 목록 검색
searchBtn.addEventListner

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
        	
        	console.log(list[0].title);
        	console.log(list[0].cover);
        	console.log(list);
        	
        	printList(list);
        	printPageNum(pm, keyword);
            
        })
        .catch(err => console.error(err));
}


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
		let available = availableClass === "available" ? "대출 가능" : "대출 불가";
		
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
      					<p class=\${availableClass} style='width:500px; padding-left:50px;'>\${available}</p>
    				</div>
	    		</div>
	    		
    		</div>
		`;
	}
	
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
			<button class='pageBtn' data-page=1>처음</button>
		`;
	}
	
	if(prev){
		pagenation += `
			<button class='pageBtn' data-page=\${pm.startPage}-1>이전</button>
		`;
	}
	
	for(let i = pm.startPage; i <= pm.endPage; i++){
		pagenation += `
			<button class='pageBtn' data-page=i>i</button>
		`;
	}
	
	if(next){
		pagenation += `
			<button class='pageBtn' data-page=\${pm.endPage}+1>다음</button>
		`;
	}

	if(last){
		pagenation += `
			<button class='pageBtn' data-page=\${pm.endPage}>마지막</button>
		`;
	}

} // end printPageNum()




</script>

<%@ include file="../common/footer.jsp" %>