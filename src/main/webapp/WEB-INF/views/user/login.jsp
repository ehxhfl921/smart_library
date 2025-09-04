<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
</head>
<body>
    <h2>로그인</h2>

    <!-- 로그인 실패 메시지 출력 -->
    <c:if test="">
        <p style="color:red;">${msg}</p>
    </c:if>

    <form action="user/login" method="post">
        <div>
            <label for="id">아이디</label>
            <input type="text" id="id" name="id" required>
        </div>
        <div>
            <label for="pw">비밀번호</label>
            <input type="password" id="pw" name="pw" required>
        </div>
        <div>
            <button type="submit">로그인</button>
        </div>
    </form>

    <p>회원가입 부탁드립니다.
        <a href="user/join">회원가입</a>
    </p>
</body>
</html>