<!-- 관리자 전용 / 도서 관리 - 도서 상세 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<c:if test="${not empty msg}">
    <script>
        alert('${msg}');
    </script>
</c:if>

<section class="jinju1">
<div class="bookDetail">
<h2 class="up">도서 상세 페이지</h2>

    <!-- 도서 상세 정보 -->
    <table class="table">
        <tr>
            <td rowspan="5" align="center">
                <img src="${path}/${book.cover}"
                     alt="${book.title}">
            </td>
            <th width="100">제목</th>
            <td>${book.title}</td>
        </tr>
        <tr>
            <th>저자</th>
            <td>${book.author}</td>
        </tr>
        <tr>
            <th>발행 기관</th>
            <td>${book.publisher}</td>
        </tr>
        <tr>
            <th>발행 연도</th>
            <td>${book.p_date}년</td>
        </tr>
        <tr>
            <th>관리</th>
            <td>
              <div class="actions">
              	<c:choose>
              		<c:when test="${isBom eq 'Y'}">
	                  <button id="bomDBtn" class="btn" style="background-color:#b91c1c;border:none;">이달의 도서에서 삭제</button>
              		</c:when>
              		<c:otherwise>
                  		<button id="bomBtn" class="btn">이달의 도서로 등록</button>
                  	</c:otherwise>
                </c:choose>
                
                <form action="${path}/book/admin/modify" method="get" style="display:inline;">
                  <input type="hidden" name="bno" value="${book.bno}">
                  <input type="submit" value="수정하기" class="btn outline">
                </form>

                <form action="${path}/book/admin/remove/${book.bno}" method="get" style="display:inline;" 
                      onsubmit="return confirm('삭제하시겠습니까?');">
                  <input type="hidden" name="page" value="${pm.cri.page}">
                  <input type="submit" value="삭제하기" class="btn bad">
                </form>
              </div>
           </td>
          </tr>
    </table>

    <br>

    <!-- 대출 현황 -->
    <h2 class="down">대출 현황</h2>
    <table class="form-table">
        <tr>
            <th>대출 번호</th>
            <th>대출자ID</th>
            <th>대출일</th>
            <th>반납일</th>
            <th>상태</th>
        </tr>
        
        <c:choose>
	        <c:when test="${not empty list}">
		        <tr>
		            <td>${list.loan_no}</td>
		            <td>${list.user_id}</td>
		            <td>${list.borrow_date}</td>
		            <td>${list.return_date}</td>
		            <td>${list.loan_status}</td>
		        </tr>	
	        </c:when>
	        
	        <c:otherwise>
		        <tr>
		            <td colspan="5" align="center">대출 내역이 없습니다.</td>
		        </tr>
		    </c:otherwise>
        </c:choose>
    </table>
</div>
</section>

<script>
const contextPath = document.querySelector("meta[name='context-path']").content;

const pathParts = window.location.pathname.split("/");
const bno = pathParts[pathParts.length - 1]; 
console.log(bno); // "9"

const params = new URLSearchParams(window.location.search);
const page = params.get("page");
console.log(page); // "1"

const bomBtn = document.querySelector("#bomBtn");
const bomDBtn = document.querySelector("#bomDBtn");

if(bomBtn){
	
	// 이달의 도서로 등록
	bomBtn.addEventListener("click", () => {
		
	  if (confirm("이 도서를 이달의 도서로 등록하시겠습니까?")) {
		// 경로에서 bno 꺼내기
	    const pathParts = window.location.pathname.split("/");
	    const bno = pathParts[pathParts.length - 1];
	
	    fetch(`\${contextPath}/book/registerBom?bno=\${bno}`, {
	      method: "GET"
	    }).then(res => res.json())
	    .then(data => {
	    	alert(data.msg);
	    	location.reload();
	    }).catch(err => {
	    	alert("등록 실패: " + err);
	    });
	  } // end if
	  
	}); // end 이달의 도서 등록 이벤트
	
	

} // end 등록

if(bomDBtn){
	
	// 이달의 도서에서 삭제
	bomDBtn.addEventListener("click", () => {
		
		if (confirm("이 도서를 이달의 도서에서 제거하시겠습니까?")) {
			// 경로에서 bno 꺼내기
		    const pathParts = window.location.pathname.split("/");
		    const bno = pathParts[pathParts.length - 1];
	
		    fetch(`\${contextPath}/book/removeBom?bno=\${bno}`, {
		    	method: "GET"
		    }).then(res => res.json())
		    .then(data => {
		    	alert(data.msg);
		    	location.reload();
		    }).catch(err => {
		    	alert("삭제 실패: " + err);
		    });
		  } // end if
		
	});

}

</script>
<%@ include file="../common/footer.jsp" %>
