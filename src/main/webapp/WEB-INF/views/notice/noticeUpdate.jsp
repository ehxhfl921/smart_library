<!-- 공지 사항 수정 폼 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="jinju1">
  <main class="noticeUpdate">
    <h2 class="up">공지사항 수정</h2>
    <form method="POST" action="${path}/notice/update">
        <input type="hidden" name="nno" value="${boardVO.nno}">
        
        <table class="form-table">
       
	        <tr>
	            <th>제목</th>
	            <td>
	            	<input type="text" name="n_title" required value="${boardVO.n_title}">
	            </td>
	        </tr>
	        
	        <tr>
	            <th>작성 내용</th>
	            <td>
	            	<textarea name="n_content" required rows="18" cols="20" autofocus>${boardVO.n_content}</textarea>
	            </td>
	        </tr>
         </table>
         <div class="btnBox">
         	<button type="submit" class="btn"
             	onclick="return confirm('공지 사항을 수정하시겠습니까?')">수정하기</button>
         </div>
    </form>
  </main>
</section>

<%@ include file="../common/footer.jsp" %>
