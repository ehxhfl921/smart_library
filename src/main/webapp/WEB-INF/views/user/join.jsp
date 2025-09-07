<!-- 회원 가입 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section>

    <h2>회원가입</h2>
    
    <form action="user/join" method="post">
        <div>
            <label for="id">아이디</label>
            <input type="text" id="id" name="id" required>
        </div>
        <div>
            <label for="pw">비밀번호</label>
            <input type="password" id="pw" name="pw" required>
        </div>
        <div>
            <label for="name">이름</label>
            <input type="text" id="name" name="name" required>
        </div>
        <div>
            <label for="phone">전화번호</label>
            <input type="text" id="phone" name="phone">
        </div>
        <div>
            <label for="email">이메일</label>
            <input type="email" id="email" name="email" required>
        </div>
        <div>
            <label for="addr">주소</label>
            <input type="text" id="addr" name="addr">
        </div>
        <div>
            <label for="role">권한</label>
            <select id="role" name="role">
                <option value="USER">일반회원</option>
                <option value="ADMIN">관리자</option>
            </select>
        </div>
        <div>
            <button type="submit">가입하기</button>
        </div>
    </form>
</section>

<%@ include file="../common/footer.jsp" %>