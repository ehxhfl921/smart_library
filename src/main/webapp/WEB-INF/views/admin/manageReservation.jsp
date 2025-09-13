<!-- 관리자 전용 / 스터디룸 예약 관리 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju1>
<aside class="admin-sidebar">
    <ul>
      <li><a href="${path}/user/memberList" class="active">회원 관리</a></li>
      <li><a href="${path}/book/admin/list">도서 관리</a></li>
      <li><a href="${path}/studyroom/admin/reservationList">스터디룸 예약 관리</a></li>
      <li><a href="${path}/manageInfo">도서관 정보 관리</a></li>
    </ul>
</aside>

<main>

<h2>스터디룸 예약 관리</h2>

<div class="toolbar">
  <div class="hint">정렬 기준: 예약 신청일(최신순)</div>
</div>

<table class="table">
  <thead>
    <tr>
      <th>예약 번호</th>
      <th>신청자</th>
      <th>스터디룸번호</th>
      <th>예약희망일</th>
      <th>예약신청일</th>
      <th>상태</th>
      <th>예약 관리</th>
    </tr>
  </thead>
  <tbody>
    
          <tr>
            <td>}</td>
            <td></td>
            <td></td>

            <!-- 상태 -->
            <td>
               <span class="badge badge-pending">대기중</span>
                <span class="badge badge-approved">승인됨</span>
                <span class="badge badge-rejected">거절됨</span>
                <span class="badge badge-cancelled">취소됨</span>
                <span class="badge badge-finished">완료됨</span>

            </td>

            <!-- 예약 관리 버튼 -->
            <td>
              <div class="actions">


                    <form action="" method="post" style="display:inline;">
                      <input type="hidden" name="id" value="">
                      <button type="submit" class="btn btn-approve">승인</button>
                    </form>
                    <form action="" method="post" style="display:inline;">
                      <input type="hidden" name="id" value="${rv.id}">
                      <button type="submit" class="btn btn-reject">거절</button>
                    </form>


                    <form action="" method="post" style="display:inline;">
                      <input type="hidden" name="id" value="">
                      <button type="submit" class="btn btn-cancel">취소</button>
                    </form>
           
    
              </div>
            </td>
          </tr>


        <tr>
          <td colspan="7">예약 내역이 없습니다.</td>
        </tr>

  </tbody>
</table>
</main>
</section>

<%@ include file="../common/footer.jsp" %>