<!-- 공통 헤더 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<jsp:useBean id="now" class="java.util.Date" />
<c:set var="today" value="${now}" />

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Smart Library</title>
<link href="${path}/resources/css/header.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/common.css" rel="stylesheet" type="text/css" />
<link href="${path}/resources/css/footer.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/flatpickr/dist/themes/material_blue.css">
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr/dist/l10n/ko.js"></script>


</head>
<body>
  <header>
    <div class="header-top">
      <ul class="utils">
      
      	<c:if test="${empty userInfo}">
	        <li><a href="${path}/user/goToLogin">로그인</a></li>
	        <li><a href="${path}/user/join">회원가입</a></li>
        </c:if>
        
        <c:if test="${!empty userInfo}">
	        <li style='font-weight:bold;'>${userInfo.name} 님</li>
	        <li><a href="${path}/user/myPage">My Page</a></li>
	        <li><a href="${path}/user/logout">로그아웃</a></li>
	        <c:if test="${userInfo.id eq 'admin'}">
	        	<li><a href="${path}/user/admin/memberList">운영/관리</a></li>
	        </c:if>
        </c:if>
      </ul>
    </div>

    <nav class="menu-bar" aria-label="주 메뉴">
		<div class="inner">
			<div class="logo" title="메인으로">
		     	<a href="${path}/">
		     		<img alt="Logo" src="${path}/resources/logo_shadow.png">
		     	</a>
		    </div>
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
			      <li><a href="${path}/upcoming">출간 예정 도서</a></li>
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
			    <a href="${path}/book/myPage/loans?page=1">내 서재</a>
			    <ul class="dropdown">
			      <li><a href="${path}/book/myPage/loans?page=1">도서 대출 현황</a></li>
			      <li><a href="${path}/studyroom/myReservationList">스터디룸 예약 현황</a></li>
			      <li><a href="${path}/suggest/mySuggestion">작성한 건의 사항</a></li>
			    </ul>
			  </li>
			</ul>
		</div>
    </nav>
  </header>





