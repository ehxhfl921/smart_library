<!-- 공통 헤더 -->

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
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
      <div class="logo">SMART 도서관</div>
      <ul class="utils">
        <li><a href="#">로그인</a></li>
        <li><a href="#">회원가입</a></li>
        <li>님</li>
        <li><a href="#">My Page</a></li>
        <li><a href="#">로그아웃</a></li>
        <li><a href="#">운영 관리</a></li>
      </ul>
    </div>

    <nav class="menu-bar" aria-label="주 메뉴">
      <div class="inner">
        <ul class="main-nav">
          <li>
            <a href="#">도서관이용</a>
            <ul class="dropdown">
              <li><a href="#">이용안내</a></li>
              <li><a href="#">스터디룸 예약</a></li>
            </ul>
          </li>
          <li><a href="#">자료검색</a></li>
          <li>
            <a href="#">열린 공간</a>
            <ul class="dropdown">
              <li><a href="#">공지사항</a></li>
              <li><a href="#">건의사항</a></li>
            </ul>
          </li>
          <li>
            <a href="#">내서재</a>
            <ul class="dropdown">
              <li><a href="#">대출현황</a></li>
              <li><a href="#">스터디룸 예약 현황</a></li>
              <li><a href="#">작성한 건의사항</a></li>
            </ul>
          </li>
        </ul>
      </div>
    </nav>
  </header>





