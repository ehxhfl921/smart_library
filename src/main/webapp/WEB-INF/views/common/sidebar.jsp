<!-- 공통 사이드 바 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<section class="sidebar">
	<!-- 도서관 이용일때만 사이드 출력 -->
	<c:if test="">
		<h4>도서관 이용</h4>
		<ul>
			<li><a href="">이용안내</a></li>
			<li><a href="">스터디룸 예약</a></li>
			
		</ul>
	</c:if>
	<!-- 열린공간 이용일때만 사이드 출력 -->
	<c:if test="">
		<h4>열린공간</h4>
		<ul>
			<li><a href="">공지사항</a></li>
			<li><a href="">건의사항</a></li>
			
		</ul>
	</c:if>
	<!-- 관리자일때만 사이드 출력 -->
	<c:if test="">
	
		<h4>관리자 메뉴</h4>
		<ul>
			<li><a href="">대출현황</a></li>
			<li><a href="">스터디룸예약현황</a></li>
			<li><a href="">작성한 건의사항</a></li>
			
		</ul>
	</c:if>

</section>