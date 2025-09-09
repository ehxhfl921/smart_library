<!-- 관리자 전용 / 도서 관리 - 도서 상세 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section>
<h2>도서 상세 페이지</h2>

    <!-- 도서 상세 정보 -->
    <table class="form-table">
        <tr>
            <td rowspan="5" width="220" align="center">
                <img src=""
                     alt="책 표지"
                     style="width:200px; height:260px; border:1px solid #ccc;">
            </td>
            <th width="100">제목</th>
            <td>${book.title}</td>
        </tr>
        <tr>
            <th>저자</th>
            <td>${book.author}</td>
        </tr>
        <tr>
            <th>출판사</th>
            <td>${book.publisher}</td>
        </tr>
        <tr>
            <th>발행연도</th>
            <td>${book.p_date}</td>
        </tr>
        <tr>
            <th>관리</th>
            <td>
              <div class="actions">
                <form action="" method="post" style="display:inline;" 
                      onsubmit="return confirm('이달의 도서로 등록하시겠습니까?');">
                  <input type="hidden" name="id" value="${book.bno}">
                  <input type="submit" value="이달의 도서로 등록" class="btn">
                </form>

                <form action="/book/updateForm" method="get" style="display:inline;">
                  <input type="hidden" name="id" value="${book.bno}">
                  <input type="submit" value="수정하기" class="btn outline">
                </form>

                <form action="" method="post" style="display:inline;" 
                      onsubmit="return confirm('삭제하시겠습니까?');">
                  <input type="hidden" name="id" value="${book.bno}">
                  <input type="submit" value="삭제하기" class="btn bad">
                </form>
              </div>
            </td>
          </tr>
    </table>

    <br>

    <!-- 대출 현황 -->
    <h2>대출 현황</h2>
    <table class="form-table">
        <tr>
            <th>대출번호</th>
            <th>사용자ID</th>
            <th>대출일</th>
            <th>상태</th>
        </tr>
            <tr>
                <td>${loan.loan_no}</td>
                <td>${loan.user_id}</td>
                
                <td>${loan.loan_status}</td>
            </tr>
            <tr>
                <td colspan="4" align="center">대출 내역이 없습니다.</td>
            </tr>
    </table>

</section>

<%@ include file="../common/footer.jsp" %>
