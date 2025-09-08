package net.koreate.book.vo;

import java.util.Date;

import lombok.Data;

@Data
public class BookVO {
	
	private int rnum;			  // 목록 출력 시 행 번호 저장
	
	private int bno; 			  // 도서 번호
	private String title;	      // 제목	
	private String author;	      // 저자
	private String publisher;	  // 발행 기관
	private Date p_date;	      // 발행 연도
	private String cover;	      // 표지 이미지 경로
	private String is_available;  // 대출 가능 여부
	private String b_status;      // 상태 (삭제된 도서인지 아닌지)
	
	private int loan_no; 		  // 대출 번호
	private String user_id;		  // 대출자 아이디 
	private String loan_status;	  // 도서 대출 상태 (대출 중/반납)
	
	private int bom_no;			  // 이달의 도서 번호
	private String bom_status;	  // 이달의 도서 등록 여부
	
}
