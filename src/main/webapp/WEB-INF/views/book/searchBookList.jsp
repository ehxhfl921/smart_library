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
        <div>
        	<c:forEach var="pageBtn" items="${pm}">
        		<button></button>
        	</c:forEach>
        </div>
        
      </div>
      
    </main>
</section>


<script>

const contextPath = document.querySelector("meta[name='context-path']").content;


const searchBtn = document.querySelector("#searchBtn");

searchBtn.onclick = function() {
	console.log("ㅠㅠ");
    const searchBox = document.querySelector("#keyword");
    const keyword = searchBox.value;

    const params = new URLSearchParams({
        keyword: keyword,
        page: 1
    });

    fetch(contextPath + "/book/search/list?" + params.toString())
        .then(res => res.json())
        .then(data => {
           
        	let list = data.list;
        	
        	console.log(list[0].title);
        	console.log(list[0].cover);
        	console.log(list);
        	
        	printPage(data);
            
        })
        .catch(err => console.error(err));
}

// 검색된 도서 목록, pm 객체 정보 페이지에 출력
function printPage(data){
	let list = data.list;
	let pm = data.pm;
	
	console.log(data.list);
    console.log(data.pm);
    
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
	    			<img alt='\${title}' src=\${contextPath}/\${cover}>
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
      					<p class='\${availableClass}' style='width:500px; padding-left:50px;'>\${available}</p>
    				</div>
	    		</div>
	    		
    		</div>
		`;
	}
	resultDiv.innerHTML = html;
}

</script>

<%@ include file="../common/footer.jsp" %>