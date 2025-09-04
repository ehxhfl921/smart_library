package net.koreate.book.vo;

import java.util.Date;

public class BookVO {
	
	private int bno; 			  // 도서 번호
	private String title;	      // 제목	
	private String author;	      // 저자
	private String publisher;	  // 발행 기관
	private Date p_date;	      // 발행 연도
	private String cover;	      // 표지 이미지 경로
	private String is_available;  // 대출 가능 여부
	private String b_status;      // 상태
	
	private int bom_no;			  // 번호 PK
	private String bom_status;	  // 상태	
	

}
