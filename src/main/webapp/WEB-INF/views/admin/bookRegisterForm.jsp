<!-- 관리자 전용 - 도서 신규 등록 폼 페이지 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../common/header.jsp" %>

<section class=jinju1>
<main class="registerBook">
<div class="container">

    <h2 class="up">신규 도서 등록</h2>

    <form action="${path}/book/admin/register" method="post" enctype="multipart/form-data">
      <table class="form-table">
      	<tr>
      		<th>표지 이미지 미리보기</th>
      		<td> 
      			<img class="coverImg" src='${path}/resources/tempImg.jpg' alt="표지 이미지가 없습니다." style="width: 200px;height: 300px;display:inline-block;">
          	</td>
      	</tr>
      	<tr>
      		<th>표지 이미지 선택</th>
          	<td> <input type="file" name="coverFile" accept="image/*" id="cover"></td>
     		</tr>
        <tr>
          <th>제목</th>
          <td><input type="text" name="title"></td>
        </tr>
        <tr>
          <th>저자</th>
          <td><input type="text" name="author"></td>
        </tr>
        <tr>
          <th>발행 기관</th>
          <td><input type="text" name="publisher"></td>
        </tr>
        <tr>
          <th>발행 연도</th>
          <td><input type="number" name="p_date"></td>
        </tr>
      </table>

      <!-- 버튼 중앙 정렬 -->
      <div style="text-align:center; margin-top:16px;">
        <input type="submit" value="등록" class="btn">
      </div>
    </form>
  </div>
</main>
</section>

<!-- 표지 이미지 미리보기 -->
<script>
	let coverImg = document.querySelector(".coverImg");
	let cover = document.getElementById("cover");
	
	// 기존 표지 이미지 경로 저장
	let imagePath = coverImg.getAttribute("src");
	
	cover.onchange = function(){
		// 표지 이미지 선택 입력 태그 요소 변경
		let files = this.files;
		let chooseFile = files[0];
		
		if(chooseFile && chooseFile.type.startsWith("image/")){
			// image 형식의 프로필 사용 가능한 파일 선택
			// chooseFile로 선택된 사용자 PC의 파일 경로를
			// 브라우저가 인식할 수 있는 URL 경로 생성
			let path = URL.createObjectURL(chooseFile);
			// 선택한 파일 경로로 이미지 출력 경로 변경
			coverImg.setAttribute("src", path);
			
		}else{
			alert("이미지를 선택해 주세요.");
			this.value = ""; // 선택 파일 초기화
			coverImg.setAttribute("src", imagePath); // 기본 이미지로 변경
		}
	};
</script>

<%@ include file="../common/footer.jsp" %>