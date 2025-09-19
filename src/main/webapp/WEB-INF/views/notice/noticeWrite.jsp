<!-- 공지 사항 작성 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class="mainSection1">
  <main class="noticeUpdate">
    <h2 class="up">공지사항 작성</h2>
    <form method="POST" action="${path}/notice/register">
    
    	 <table class="form-table">
       
	        <tr>
	            <th>제목</th>
	            <td>
	            	<input type="text" name="n_title" required autofocus>
	            </td>
	        </tr>
	        
	        <tr>
	            <th>작성 내용</th>
	            <td>
	            	<textarea name="n_content" required rows="18" cols="20">
	            	</textarea>
	            </td>
	        </tr>
         </table>
         <div class="btnBox">
            <button type="submit" class="btn"
                onclick="return confirm('공지 사항을 등록하시겠습니까?')">작성하기</button>
         </div>
    </form>
  </main>
</section>

<%@ include file="../common/footer.jsp" %>
