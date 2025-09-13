<!-- 메인 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>

<section class="main">

<div class="mainBox1">
	<form action="book/search" method="GET">
		<input type="text" name="keyword" placeholder="검색할 도서의 제목이나 저자를 입력하세요">
		<input type="hidden" name="page" value="1">
		<button>검색</button>
	</form>
</div>

<div class="mainBox2">
	<p class="titleBom">
		<span class="bom">📚 이달의 도서</span>
	</p>
	<p class="title">
		<span>📢 도서관 안내</span>
	</p>
	
	<!-- 이달의 도서 출력 -->
	<div class="bookOftheMonth">
	
		<div class="slideWrapper">
		
			<div class="slide">
			<c:forEach var="book" items="${list}">
			
				<div class="slideBookCard">
						<div class="img">
							<img alt="표지 이미지" src="${book.cover}">
						</div>
						<div class="bomInfo">
							<div class="bold">
								<p>제목</p>
								<p>저자</p>
								<p>발행기관</p>
								<p>발행일</p>
							</div>
							<div>
								<p>${book.title}</p>
								<p>${book.author}</p>
								<p>${book.publisher}</p>
								<p>${book.p_date}년</p>
							</div>
						</div>
				</div>
				
			</c:forEach>
			</div>
		</div> <!-- end slideWrapper -->
		
	</div> <!-- end bom -->

	<!-- 도서관 정보 출력 -->
	<div class="libraryInfo">
		<div class="libName">
			<p>⦁ ${info.library_name}</p>
		</div>
		<div class="libInfo">
			<div class="infoLeft">
				<p>전화번호</p>
				<p>위치</p>
				<p>이용 시간</p>
				<p>휴관일</p>
			</div>
			<div class="infoRight">
				<p>${info.tel}</p>
				<p>${info.location}</p>
				<p>${info.operating_hour}</p>
				<p>${info.closed_date}</p>
			</div>
		</div>
	</div>

</div>
</section>

<script>
	const slide = document.querySelector(".slide");
	const totalCards = slide.children.length;
	let currentIndex = 0;
	
	function slideCard(){
		currentIndex = (currentIndex + 1) % totalCards;
		slide.style.transform = "translateX(-"+ (currentIndex * 600) +"px)";
	}
	
	setInterval(slideCard, 4000);
</script>

<%@ include file="common/footer.jsp" %>
