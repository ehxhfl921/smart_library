<!-- 건의 사항 수정 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="mainSection1">
  <main class="noticeUpdate">
    <h2>건의사항 수정</h2>
    <form method="POST" action="${path}/suggest/modify">
        <input type="hidden" name="sug_no" value="${suggestion.sug_no}">
        <input type="hidden" name="rnum" value="${suggestion.rnum}">
        
        <table class="form-table">
       
	        <tr>
	            <th>제목</th>
	            <td>
	            	<input type="text" name="s_title" required value="${suggestion.s_title}">
	            </td>
	        </tr>
	        
	        <tr>
	            <th>작성 내용</th>
	            <td>
	            	<textarea name="s_content" required rows="18" cols="20" autofocus>${suggestion.s_content}</textarea>
	            </td>
	        </tr>
	        <tr>
	            <th>작성자</th>
	            <td>
	            	<input type="text" name="s_author" value="${userInfo.name}" readonly>
	            </td>
	        </tr>
         </table>
         <div class="btnBox">
         	<button type="submit" class="btn"
             	onclick="return confirm('건의 사항을 수정하시겠습니까?')">수정하기</button>
         </div>
    </form>
  </main>
</section>

<%@ include file="../common/footer.jsp" %>