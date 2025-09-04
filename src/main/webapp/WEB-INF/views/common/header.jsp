<!-- 공통 헤더 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<header class="site-header">
  <!-- 상단바: 비로그인 → 로그인/회원가입 / 로그인 → 마이페이지/로그아웃 (+관리자) -->
  <div class="topbar">
    <div class="wrapnav">
      <div class="brand">Smart 도서관</div>
      <nav class="nav">
        <ul>
        
          <!-- <li><a href="home.jsp">Home</a></li> -->

			<c:if test="">
	            <li><a href="user/login">로그인</a></li>
	            <li><a href="user/join">회원가입</a></li>
			</c:if>
			
			<c:if test="">
	            <li><a href="user/myPage">마이페이지</a></li>
	            <li><a href="/logout">로그아웃</a></li>
            </c:if>

			<c:if test="">
              <li><a href="admin/manageInfo">관리자</a></li>
			</c:if>
        </ul>
      </nav>
    </div>
  </div>

  <!-- 메인 메뉴바: 도서관이용 / 자료검색 / 열린공간 / 내서재 (드롭다운) -->
  <div class="menubar">
    <div class="wrap">
      <nav class="main-nav">
        <ul class="menu">
          <li class="dropdown">
            <a href="libraryInfo">도서관 이용</a>
            <ul class="submenu">
              <li><a href="room/libraryInfo">이용안내</a></li>
              <li><a href="room/roomReservation">스터디룸 예약</a></li>
            </ul>
          </li>

          <li><a href="book/searchBookList">자료 검색</a></li>

          <li class="dropdown">
            <a href="board/noticeList">열린 공간</a>
            <ul class="submenu">
              <li><a href="board/noticeList">공지사항</a></li>
              <li><a href="board/suggestList">건의 사항</a></li>
            </ul>
          </li>

          <li class="dropdown">

            <a href="book/loanList">내 서재</a>
            <ul class="submenu">
				<c:if test="">
	                <li><a href="book/loanList">대출현황</a></li>
	                <li><a href="room/reservationList">스터디룸 예약현황</a></li>
	                <li><a href="board/suggestionList">작성한 건의사항</a></li>
				</c:if>


            </ul>
          </li>
        </ul>
      </nav>
    </div>
  </div>
</header>






