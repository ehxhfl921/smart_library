<!-- 공통 헤더 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!-- 헤더 JSP에 포함 -->

<!DOCTYPE html>
<html>
<head>
	<meta name="context-path" content="${pageContext.request.contextPath}">
	<meta charset="UTF-8">
	<title>Smart Library</title>
<link href="${path}/resources/css/header.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/sidebar.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/common.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/footer.css" rel="stylesheet" type="text/css" />

</head>
<body>
  <header>
    <div class="header-top">
      <div class="logo">
      	<a href="${path}/"><img alt="Logo" src="${path}/resources/logo_shadow.png"></a>
      </div>
      <ul class="utils">
        <li><a href="${path}/user/goToLogin">로그인</a></li>
        <li><a href="${path}/user/join">회원가입</a></li>
        <li>님</li>
        <li><a href="${path}/user/myPage">My Page</a></li>
        <li><a href="${path}/user/logout">로그아웃</a></li>
        <li><a href="${path}/book/admin/list?page=1">운영 관리</a></li>
      </ul>
    </div>

    <nav class="menu-bar" aria-label="주 메뉴">
      <div class="inner">
        <ul class="main-nav">
          <li>
            <a href="${path}/libraryInfo">도서관 이용</a>
            <ul class="dropdown">
              <li><a href="${path}/libraryInfo">이용 안내</a></li>
              <li><a href="${path}/studyroom">스터디룸 예약</a></li>
            </ul>
          </li>
          <li>
          	<a href="${path}/book/search">자료 찾기</a>
          	<ul class="dropdown">
              <li><a href="${path}/book/search">도서 검색</a></li>
            </ul>
          </li>
          <li>
            <a href="${path}/notice/list">열린 공간</a>
            <ul class="dropdown">
              <li><a href="${path}/notice/list">공지 사항</a></li>
              <li><a href="${path}/suggest/list">건의 사항</a></li>
            </ul>
          </li>
          <li>
            <a href="${path}/book/myPage/loans">내 서재</a>
            <ul class="dropdown">
              <li><a href="${path}/book/myPage/loans">도서 대출 현황</a></li>
              <li><a href="${path}/studyroom/myReservationList">스터디룸 예약 현황</a></li>
              <li><a href="${path}/suggest/mySuggestion">작성한 건의 사항</a></li>
            </ul>
          </li>
        </ul>
      </div>
    </nav>
  </header>





