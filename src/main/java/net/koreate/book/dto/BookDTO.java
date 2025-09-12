package net.koreate.book.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class BookDTO {

	private int bno; 			  // 도서 번호
	private String title;	      // 제목	
	private String author;	      // 저자
	private String publisher;	  // 발행 기관
	private int p_date;	      	  // 발행 연도
	private String cover;	      // 표지 이미지 경로
	private String is_available;  // 대출 가능 여부
	private String b_status;      // 상태 (삭제된 도서인지 아닌지)
	
	private MultipartFile coverFile;	//업로드할 이미지 파일

}
