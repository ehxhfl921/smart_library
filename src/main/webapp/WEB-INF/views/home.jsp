<!-- 메인 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>

<section class="main">

<div class="mainBox1">
	<form action="book/search" method="POST">
		<input type="text" name="keyword" placeholder="검색할 도서의 제목이나 저자를 입력하세요">
		<button>검색</button>
	</form>
</div>

<div class="mainBox2">
	<p class="title">
		<span class="bom">📚 이달의 도서</span>
		<span>📢 도서관 안내</span>
	</p>

	<!-- 이달의 도서 출력 -->
	<div class="bookOftheMonth">
	
			<!-- 테스트 -->
			<div class="slideBookCard">
				<div class="img">
					<img alt="테스트" src="/images/2.jpg">
				</div>
				<div class="bomInfo">
					<div class="bold">
					<p>제목</p>
					<p>저자</p>
					<p>발행기관</p>
					<p>발행일</p>
					</div>
					<div>
						<p>테스트용 제목</p>
						<p>테스트용 저자</p>
						<p>테스트용 발행기관</p>
						<p>테스트용 발행일</p>
					</div>
				</div>
			</div>
	
	</div>

	<!-- 도서관 정보 출력 -->
	
	<div class="libraryInfo">
		<div class="libName">
			<p>• 스마트 도서관</p>
		</div>
		<div class="libInfo">
			<div class="infoLeft">
				<p>전화번호</p>
				<p>위치</p>
				<p>이용 시간</p>
				<p>휴관일</p>
			</div>
			<div class="infoRight">
				<p>051.1234.9876</p>
				<p>부산광역시 동래구 충렬대로 84</p>
				<p>9:00 ~ 17:00</p>
				<p>매달 둘째 주 일요일</p>
			</div>
		</div>
	</div>

</div>
</section>

<%@ include file="common/footer.jsp" %>
